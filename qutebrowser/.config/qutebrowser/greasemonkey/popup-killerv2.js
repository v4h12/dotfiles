// ==UserScript==
// @name         Popup & Overlay Killer
// @namespace    local
// @version      2.0.0
// @description  Hide nuisance popups/overlays, detect common fake verification scams, and block their click-through redirects
// @match        *://*/*
// @run-at       document-start
// @qute-js-world popup-killer
// @grant        none
// ==/UserScript==

(() => {
    'use strict';

    /*
     * High-confidence selectors are hidden anywhere they occur.
     * Generic selectors are only hidden when the matching element actually
     * behaves like an overlay/dialog (fixed/absolute/sticky or dialog-like).
     *
     * This is NOT a complete adblocker:
     * - qutebrowser handles network blocking
     * - this handles cosmetic popups/overlays
     * - scam detection is intentionally heuristic
     */

    const HIGH_CONFIDENCE_SELECTORS = [
        // Cookie / consent / GDPR banners
        '#onetrust-consent-sdk',
        '#onetrust-banner-sdk',
        '.ot-sdk-container',
        '.cky-consent-container',
        '.cky-consent-bar',
        '.cky-overlay',
        '#cookie-law-info-bar',
        '.cli-popupbar-overlay',
        '.cli-bar-container',
        '[class*="tarteaucitron"]',
        '#didomi-host',
        '[class*="didomi"]',
        '#truste-consent-track',
        '[class*="usercentrics"]',
        '[class*="consent-manager"]',
        '.fc-consent-root',
        '#BorlabsCookieBox',
        '[class*="borlabs"]',
        '.cc-banner',
        '.cc-window',
        '.cc-floating',
        '#ccc',
        '[class*="quantcast"]',

        // Newsletter / subscription popups
        '[class*="newsletter-popup"]',
        '[class*="newsletter-overlay"]',
        '[id*="newsletter-popup"]',
        '[class*="subscribe-popup"]',
        '[class*="subscribe-modal"]',
        '[class*="email-popup"]',
        '[class*="exit-popup"]',
        '[class*="exit-intent"]',
        '[class*="leaving-popup"]',
        '[class*="modal-newsletter"]',

        // Generic popup containers with fairly strong names
        '[class*="popup-overlay"]',
        '[class*="overlay-popup"]',
        '[class*="modal-popup"]',
        '[class*="popup-modal"]',

        // Anti-adblock nags
        '[class*="adblock"][class*="detect"]',
        '[class*="adblock"][class*="modal"]',
        '[class*="adblock"][class*="popup"]',
        '[class*="adblock"][class*="warning"]',
        '[class*="adblock"][class*="overlay"]',
        '[class*="adblock"][class*="message"]',
        '[class*="anti-adblock"]',
        '[class*="adblocker"]',
    ];

    const GENERIC_SELECTORS = [
        // Cookie / consent
        '[id*="cookie"][id*="consent"]',
        '[id*="cookie"][id*="banner"]',
        '[id*="cookie"][id*="notice"]',
        '[id*="cookie"][id*="law"]',
        '[id*="cookie"][id*="popup"]',
        '[id*="cookie"][id*="bar"]',
        '[class*="cookie-consent"]',
        '[class*="cookie-banner"]',
        '[class*="cookie-notice"]',
        '[class*="cookie-law"]',
        '[class*="cookie-bar"]',
        '[class*="cookie-popup"]',
        '[class*="cookie-modal"]',
        '[class*="cookielaw"]',
        '[class*="gdpr"]',
        '[id*="gdpr"]',
        '[class*="consent"]',
        '[id*="consent"]',

        // Generic modal / overlay names
        '[class*="popup"]',
        '[id*="popup"]',
        '[class*="modal"]',
        '[id*="modal"]',
        '[class*="overlay"]',
        '[id*="overlay"]',
    ];

    const HIGH_CONFIDENCE_SELECTOR =
        HIGH_CONFIDENCE_SELECTORS.join(',');

    const GENERIC_SELECTOR =
        GENERIC_SELECTORS.join(',');

    /*
     * Deliberately stricter than the original regex.
     *
     * A legitimate page can absolutely say:
     *   "Verify you're human"
     *
     * so that text alone is not enough.
     *
     * Scam pages tend to combine verification language with:
     *   - "click Allow"
     *   - notification instructions
     *   - "allow/enable to continue/watch/download"
     */

    const STRONG_SCAM_RE = [
        /\bclick\s+(allow|ok|enable)(?:\s+to)?\s+(verify|continue|enable|watch|access|download|proceed)\b/i,
        /\b(?:tap|press)\s+(allow|ok|enable)\b/i,
        /\b(?:turn\s+on|enable|allow)\s+notifications\b/i,
        /\b(?:allow|enable)\s+notifications?\s+(?:to|for)\b/i,
        /\bclick\s+(?:allow|enable)\s+notifications?\b/i,
    ];

    const CAPTCHA_RE =
        /\b(?:verify|confirm)\s+(?:you'?re|you\s+are)\b|\bare\s+you\s+(?:a\s+)?(?:robot|bot|human)\b|\byou\s+are\s+not\s+a\s+(?:robot|bot)\b/i;

    const ALLOW_RE =
        /\b(?:allow|enable)\b/i;

    const NOTIFICATION_RE =
        /\bnotifications?\b/i;

    const killed = new WeakSet();

    /*
     * Once a scam overlay has been identified, clicks are blocked until
     * the page URL changes.
     *
     * This is intentionally local state rather than modifying the site's
     * global APIs such as window.open().
     */
    let hostileUrl = null;

    /*
     * Mutation processing is batched.
     *
     * childList changes need a subtree scan.
     * attribute changes only need the affected element checked.
     */
    const pendingSubtrees = new Set();
    const pendingElements = new Set();
    let scanScheduled = false;

    function normalizeText(el) {
        return (el.textContent || '').replace(/\s+/g, ' ').trim();
    }

    function isOverlayLike(el) {
        if (!(el instanceof Element)) {
            return false;
        }

        const role = el.getAttribute('role');

        if (role === 'dialog' || role === 'alertdialog') {
            return true;
        }

        if (el.getAttribute('aria-modal') === 'true') {
            return true;
        }

        const position = getComputedStyle(el).position;

        return position === 'fixed' ||
               position === 'absolute' ||
               position === 'sticky';
    }

    function isScam(el) {
        if (!(el instanceof Element)) {
            return false;
        }

        const text = normalizeText(el);

        if (!text || text.length > 600 || !isOverlayLike(el)) {
            return false;
        }

        if (STRONG_SCAM_RE.some((regex) => regex.test(text))) {
            return true;
        }

        if (!CAPTCHA_RE.test(text)) {
            return false;
        }

        /*
         * "Verify you're human" alone is intentionally not enough.
         * Pair it with notification or Allow/Enable language.
         */
        return NOTIFICATION_RE.test(text) || ALLOW_RE.test(text);
    }

    function shouldHide(el) {
        if (!(el instanceof Element)) {
            return false;
        }

        // Strongly identified popup/consent elements are hidden immediately.
        if (el.matches(HIGH_CONFIDENCE_SELECTOR)) {
            return true;
        }

        // Generic names must actually look like an overlay.
        return el.matches(GENERIC_SELECTOR) && isOverlayLike(el);
    }

    function setHostile() {
        hostileUrl = location.href;
    }

    function clearHostileIfNavigated() {
        if (hostileUrl !== null && hostileUrl !== location.href) {
            hostileUrl = null;
        }
    }

    function hide(el) {
        if (killed.has(el)) {
            return;
        }

        killed.add(el);

        el.style.setProperty(
            'display',
            'none',
            'important'
        );
    }

    function inspectElement(el) {
        if (!(el instanceof Element) || killed.has(el)) {
            return false;
        }

        if (isScam(el)) {
            hide(el);
            setHostile();
            return true;
        }

        if (shouldHide(el)) {
            hide(el);
            return true;
        }

        return false;
    }

    function scanTree(root) {
        if (!(root instanceof Element)) {
            return;
        }

        const stack = [root];

        while (stack.length > 0) {
            const el = stack.pop();

            if (!(el instanceof Element) || killed.has(el)) {
                continue;
            }

            /*
             * If this element was already identified as a popup, none of its
             * children need to be inspected independently.
             */
            if (inspectElement(el)) {
                continue;
            }

            /*
             * Stack children manually rather than allocating a huge
             * querySelectorAll('*') array.
             */
            for (
                let child = el.lastElementChild;
                child;
                child = child.previousElementSibling
            ) {
                stack.push(child);
            }
        }
    }

    function handlePageClick(event) {
        clearHostileIfNavigated();

        const path =
            typeof event.composedPath === 'function'
                ? event.composedPath()
                : [];

        /*
         * Once a fake scam overlay has been detected, treat the document
         * as hostile until the URL changes.
         *
         * Browser-level qutebrowser commands remain available as an escape
         * hatch.
         */
        if (hostileUrl !== null) {
            event.preventDefault();
            event.stopImmediatePropagation();
            return;
        }

        /*
         * composedPath() lets us inspect event targets through open Shadow DOM
         * as well as ordinary parent/child DOM relationships.
         */
        for (const node of path) {
            if (!(node instanceof Element)) {
                continue;
            }

            if (killed.has(node)) {
                event.preventDefault();
                event.stopImmediatePropagation();
                return;
            }

            /*
             * Catch an overlay that was inserted immediately before the click,
             * before the MutationObserver has had a chance to process it.
             */
            if (isScam(node)) {
                hide(node);
                setHostile();

                event.preventDefault();
                event.stopImmediatePropagation();
                return;
            }

            if (shouldHide(node)) {
                hide(node);

                event.preventDefault();
                event.stopImmediatePropagation();
                return;
            }
        }
    }

    function queueSubtree(root) {
        if (!(root instanceof Element)) {
            return;
        }

        pendingSubtrees.add(root);

        if (scanScheduled) {
            return;
        }

        scanScheduled = true;
        requestAnimationFrame(flushScanQueue);
    }

    function queueElement(el) {
        if (!(el instanceof Element)) {
            return;
        }

        pendingElements.add(el);

        if (scanScheduled) {
            return;
        }

        scanScheduled = true;
        requestAnimationFrame(flushScanQueue);
    }

    function hasQueuedAncestor(el) {
        let parent = el.parentElement;

        while (parent) {
            if (pendingSubtrees.has(parent)) {
                return true;
            }

            parent = parent.parentElement;
        }

        return false;
    }

    function flushScanQueue() {
        scanScheduled = false;

        const elements = [...pendingElements];
        const subtrees = [...pendingSubtrees];

        pendingElements.clear();
        pendingSubtrees.clear();

        /*
         * Attribute mutations only require the affected element to be
         * checked.
         */
        for (const el of elements) {
            if (!killed.has(el)) {
                inspectElement(el);
            }
        }

        /*
         * For inserted subtrees, avoid scanning the same subtree twice if
         * several nested nodes were inserted in the same mutation batch.
         */
        for (const root of subtrees) {
            if (!hasQueuedAncestor(root)) {
                scanTree(root);
            }
        }
    }

    /*
     * Capture phase is deliberate:
     * we want to get before the site's own click handler.
     *
     * auxclick covers middle/right mouse-button activation where applicable.
     */
    document.addEventListener(
        'click',
        handlePageClick,
        true
    );

    document.addEventListener(
        'auxclick',
        handlePageClick,
        true
    );

    const observer = new MutationObserver((mutations) => {
        for (const mutation of mutations) {
            if (mutation.type === 'childList') {
                for (const node of mutation.addedNodes) {
                    if (node instanceof Element) {
                        queueSubtree(node);
                    }
                }
            } else if (mutation.type === 'attributes') {
                queueElement(mutation.target);
            }
        }
    });

    /*
     * Observe the Document itself.
     *
     * At @run-at document-start, document.documentElement is not guaranteed
     * to exist yet, so observing document is safer than observing <html>.
     */
    observer.observe(document, {
        childList: true,
        subtree: true,
        attributes: true,

        /*
         * These are the attributes most likely to turn an ordinary element
         * into a popup/overlay or identify one as such.
         */
        attributeFilter: [
            'class',
            'id',
            'style',
            'role',
            'aria-modal',
        ],
    });

    /*
     * Scan whatever already exists while the observer catches everything
     * created after this point.
     */
    if (document.documentElement) {
        scanTree(document.documentElement);
    }
})();
