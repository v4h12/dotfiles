;;; package --- not a package

;;; Commentary: where shit gets done?

;;; Config.el  ------------------------------------------------------------------------ ;;

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to

;;; Code:
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 13))

;; THEME ----------------------------------------------------------------------- ;;

;; look at /usr/share/applications for emacs launching client for vanilla emacs

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(add-to-list 'custom-theme-load-path "~/.config/doom/")
(setq doom-theme 'doom-greish-dark)

(setq-default cursor-type '(bar . 2))
;; (setq doom-theme 'doom-1337)
;; (setq doom-theme 'doom-molokai)
;; (setq doom-theme 'doom-homage-black)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'doom-badger)
;; (setq doom-theme 'doom-sourcerer)
;; (setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'doom-monokai-spectrum)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-earl-grey)
;; (setq load-theme 'tsdh-dark)

;; ----------------------------------------------------------------------------- ;;

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; ORG ------------------------------------------------------------------------- ;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/")

;; Syntax highlighting in org source blocks
(setq org-src-fontify-natively t)

;; Better editing experience
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)

;; Optional: preserve indentation
(setq org-src-preserve-indentation t)

;; CONFIGS -------------------------------------------------------------------- ;;

;; Evil-mode config
;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

; Make horizontal movement cross lines
;; (after! evil)
;;     (setq evil-respect-visual-line-mode t)

;; (after! evil)
;;     (add-hook 'org-mode-hook #'visual-line-mode)

;; relative line-numbers
(setq display-line-numbers-type 'relative)

(defun kb/toggle-transparency ()
  "Toggle between opaque and 85% transparent."
  (interactive)
  (set-frame-parameter nil 'alpha-background
                       (if (eq (frame-parameter nil 'alpha-background) 100)
                           92
                         100)))
(map! :leader
      :desc "Toggle transparency"
      "t t" #'kb/toggle-transparency)

;; epub reader bec emacs
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-text-width 80)

  (defun my/nov-setup ()
    (visual-line-mode 1)
    (visual-fill-column-mode 1)
    (setq visual-fill-column-width 80
          visual-fill-column-center-text t))

  (add-hook 'nov-mode-hook 'my/nov-setup))

;; adds jsonc to json
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . json-mode))

;; treesitter
(setq treesit-language-source-alist
  '((lua "https://github.com/tree-sitter-grammars/tree-sitter-lua")
    (python "https://github.com/tree-sitter/tree-sitter-python")))

(after! eglot
  (setq eglot-server-programs (assq-delete-all 'python-mode eglot-server-programs))
  (push '(python-mode . ("pyright-langserver" "--stdio")) eglot-server-programs)
  (push '(python-ts-mode . ("pyright-langserver" "--stdio")) eglot-server-programs))

;; for hyprland config - not working
(after! eglot
  (add-to-list 'eglot-server-programs
    '(lua-ts-mode . ("lua-language-server"
                     :initializationOptions
                     (:settings
                      (:workspace.library ["/usr/share/hypr/stubs/"]))))))


(use-package lazy-ruff
  :ensure t
  :bind (("C-c f" . lazy-ruff-lint-format-dwim) ;; format+lint on demand
         ("C-c r" . lazy-ruff-mode))            ;; toggle ruff for this buffer
  :config
  nil)

;; --------------------------------------------------------------------------- ;;

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
