// // ==UserScript==
// // @name         Popup & Overlay Killer
// // @namespace    local
// // @version      1.1.0
// // @description  Hide in-page popup/overlay banners, kill fake scam "verify you are human" captchas, and stop clicks on them from opening new tabs
// // @match        *://*/*
// // @run-at       document-start
// // @grant        none
// // ==/UserScript==

// (() => {
//     'use strict';

//     // qutebrowser's built-in adblocker only blocks network requests and does
//     // not do cosmetic/element hiding, so in-page popups get through. This
//     // userscript hides them instead. Selectors are deliberately scoped to
//     // avoid nuking legitimate dialogs (login, image lightboxes, settings).
//     const selectors = [
//         // cookie / consent / gdpr banners
//         '#onetrust-consent-sdk', '#onetrust-banner-sdk', '.ot-sdk-container',
//         '.cky-consent-container', '.cky-consent-bar', '.cky-overlay',
//         '#cookie-law-info-bar', '.cli-popupbar-overlay', '.cli-bar-container',
//         '[class*="tarteaucitron"]', '#didomi-host', '[class*="didomi"]',
//         '#truste-consent-track', '[class*="usercentrics"]',
//         '[class*="consent-manager"]', '.fc-consent-root',
//         '#BorlabsCookieBox', '[class*="borlabs"]',
//         '.cc-banner', '.cc-window', '.cc-floating', '#ccc',
//         '[class*="quantcast"]',
//         '[id*="cookie"][id*="consent"]', '[id*="cookie"][id*="banner"]',
//         '[id*="cookie"][id*="notice"]', '[id*="cookie"][id*="law"]',
//         '[id*="cookie"][id*="popup"]', '[id*="cookie"][id*="bar"]',
//         '[class*="cookie-consent"]', '[class*="cookie-banner"]',
//         '[class*="cookie-notice"]', '[class*="cookie-law"]',
//         '[class*="cookie-bar"]', '[class*="cookie-popup"]',
//         '[class*="cookie-modal"]', '[class*="cookielaw"]',
//         '[class*="gdpr"]', '[id*="gdpr"]',
//         '[class*="consent"]', '[id*="consent"]',
//         // newsletter / subscribe overlays
//         '[class*="newsletter-popup"]', '[class*="newsletter-overlay"]',
//         '[id*="newsletter-popup"]', '[class*="subscribe-popup"]',
//         '[class*="subscribe-modal"]', '[class*="email-popup"]',
//         '[class*="exit-popup"]', '[class*="exit-intent"]',
//         '[class*="leaving-popup"]', '[class*="modal-newsletter"]',
//         // generic overlay popup containers
//         '[class*="popup-overlay"]', '[class*="overlay-popup"]',
//         '[class*="modal-popup"]', '[class*="popup-modal"]',
//         // anti-adblock / adblocker-detection nags
//         '[class*="adblock"][class*="detect"]', '[class*="adblock"][class*="modal"]',
//         '[class*="adblock"][class*="popup"]', '[class*="adblock"][class*="warning"]',
//         '[class*="adblock"][class*="overlay"]', '[class*="adblock"][class*="message"]',
//         '[class*="anti-adblock"]', '[class*="adblocker"]',
//     ];

//     // Fake captcha / "click allow" scam text. Only ever checked against
//     // fixed-positioned overlay candidates with short text, so article copy
//     // containing these words is never touched.
//     const SCAM_RE = /\b(verify\s+(you\s*re|you\s+are)|confirm\s+(you\s*re|you\s+are)|are\s+you\s+a\s+(robot|bot|human)|you\s+are\s+not\s+a\s+(robot|bot))\b|\bclick\s+(allow|ok|continue)(\s+to\s+)?(verify|continue|enable|watch|access|download|proceed)\b|\b(please\s+|kindly\s+)?turn\s+on\s+notifications\b|\b(enable|allow)\s+notifications(\s+to\s+)?(continue|watch|verify|play)\b/i;

//     const killed = new WeakSet();
//     let scamPage = false;

//     function isOverlayCandidate(el) {
//         if (el.nodeType !== Node.ELEMENT_NODE) return false;
//         const pos = getComputedStyle(el).position;
//         if (pos !== 'fixed' && pos !== 'absolute' && pos !== 'sticky') return false;
//         const text = el.textContent || '';
//         return text.length > 0 && text.length < 600;
//     }

//     function isScam(el) {
//         return isOverlayCandidate(el) && SCAM_RE.test(el.textContent);
//     }

//     function hide(el) {
//         killed.add(el);
//         el.style.setProperty('display', 'none', 'important');
//     }

//     function killNode(node) {
//         if (node.nodeType !== Node.ELEMENT_NODE) return;
//         for (const el of [node, ...node.querySelectorAll('*')]) {
//             if (killed.has(el)) continue;
//             const scam = isScam(el);
//             if (el.matches(selectors) || scam) {
//                 hide(el);
//                 if (scam) scamPage = true;
//             }
//         }
//     }

//     // Catch clicks on anything we killed (or that matches) so their handlers
//     // can't open a new tab/window. Capture phase -> runs before the site's own
//     // handlers.
//     document.addEventListener('click', (e) => {
//         let node = e.target;

//         // Once a fake-captcha/scam overlay is found the whole page is treated
//         // as hostile: every click is swallowed so click-through redirects to
//         // the scam destination never fire. qutebrowser commands (:open, hints)
//         // navigate directly and are unaffected, so the page is still leaveable.
//         if (scamPage) {
//             e.preventDefault();
//             e.stopPropagation();
//             return;
//         }

//         while (node && node !== document.documentElement) {
//             const scam = isScam(node);
//             if (killed.has(node) || (node.matches && node.matches(selectors)) || scam) {
//                 e.preventDefault();
//                 e.stopPropagation();
//                 if (!killed.has(node)) hide(node);
//                 if (scam) scamPage = true;
//                 return;
//             }
//             node = node.parentElement;
//         }
//     }, true);

//     const observer = new MutationObserver((mutations) => {
//         for (const mutation of mutations) {
//             for (const node of mutation.addedNodes) {
//                 if (node.nodeType === Node.ELEMENT_NODE) killNode(node);
//             }
//         }
//     });

//     observer.observe(document.documentElement, { childList: true, subtree: true });
// })();
