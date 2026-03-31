;; FONT ------------------------------------------------------------------------ ;;

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 13))

;; THEME ----------------------------------------------------------------------- ;;

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-material-dark)

;; ----------------------------------------------------------------------------- ;;

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; ORG ------------------------------------------------------------------------- ;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Syntax highlighting in org source blocks
(setq org-src-fontify-natively t)

;; Better editing experience
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)

;; Optional: preserve indentation
(setq org-src-preserve-indentation t)

;; CONFIGS -------------------------------------------------------------------- ;;

;; (defun my/toggle-vterm ()
  ;; "Toggle a vterm popup buffer named *vterm*."
  ;; (interactive)
  ;; (if (get-buffer "*vterm*")
  ;;     (if (get-buffer-window "*vterm*")
  ;;         (delete-window (get-buffer-window "*vterm*"))
  ;;       (pop-to-buffer "*vterm*"))
    ;; (vterm "*vterm*")))

;; Keybinding to toggle terminal with leader key
;; (map! :leader
;;       :desc "Toggle terminal"
;;       "t t" #'my/toggle-vterm)

;; (after! gdscript
;;   (setq gdscript-executable-path "/usr/bin/godot"))

(setq display-line-numbers-type 'relative)

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

