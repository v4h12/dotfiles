;;; package --- An original theme inspired by boredom
;;; doom-greish-dark-theme.el --- Doom-Greish-Dark theme -*- lexical-binding: t; no-byte-compile: t; -*-

;;; commentary:
;;; the idea was inspired by atom onedark but with a black background instead

(require 'doom-themes)

;;; code:
(def-doom-theme doom-greish-dark
  "Doom-Greish-Dark: a dark grey theme inspired by Atom One Dark."
  :family 'greish
  :background-mode 'dark

  ;; COLOR FORMAT ----------------------------------------------------------
  ;; Each color is a list of THREE values:
  ;;   (truecolor-hex   xterm-256-name   16-color-name)
  ;;
  ;;   column 1 = exact hex, used on truecolor displays (kitty, GUI) -- the
  ;;              one you'll almost always want to tweak.
  ;;   column 2 = best xterm-256 approximation (256-color terminals).
  ;;   column 3 = 16-color fallback name.
  ;;
  ;; To change a color, edit the FIRST hex string.  The other two columns are
  ;; only seen on non-truecolor terminals, so sync them roughly if you care.
  ;; Colors can also be DERIVED with helpers like (doom-darken X n) and
  ;; (doom-lighten X n), which darken/lighten a color toward black/white by n.
  ;;   n 0.06 = very subtle, 0.2 = noticeable, 0.5 = strong.
  ;; -----------------------------------------------------------------------

  ;; name       default   256           16
  ((bg         '("#141413" "black"       "black"        ))   ; overall background (entire buffer)
   (fg         '("#abb2bf" "#bfbfbf"     "brightwhite"  ))   ; default text color

   ;; off-color variants of bg/fg, used for solaire-mode and subtle highlights
   (bg-alt     '("#21252b" "black"       "black"        ))   ; navy-ish alt bg (solaire panels, subtle fills)
   (fg-alt     '("#5c6370" "#2d2d2d"     "white"        ))   ; dimmed/de-emphasized text

   ;; spectrum from bg to fg: base0 is a starker bg, base8 a starker fg
   (base0      '("#1B2229" "black"       "black"        ))   ; darkest ramp step (starker bg)
   (base1      '("#1c1f24" "#1e1e1e"     "brightblack"  ))   ; base for splitters / near-bg
   (base2      '("#202328" "#2e2e2e"     "brightblack"  ))
   (base3      '("#23272e" "#262626"     "brightblack"  ))
   (base4      '("#3e4451" "#3f3f3f"     "brightblack"  ))   ; LINE NUMBERS (see override below)
   (base5      '("#5c6370" "#525252"     "brightblack"  ))   ; COMMENTS, muted headings (org L5/L7)
   (base6      '("#73797e" "#6b6b6b"     "brightblack"  ))
   (base7      '("#9ca0a4" "#979797"     "brightblack"  ))   ; light grey -- org-document-title
   (base8      '("#DFDFDF" "#dfdfdf"     "white"        ))   ; near-white (spare)

   (grey       base4)                                        ; alias for base4 (reuse as needed)

   ;; main palette -- named colors used both in the semantic classes below
   ;; and directly in the face overrides.  Tweak these and everything that
   ;; references them follows.
   (red        '("#e06c75" "#ff6655"     "red"          ))   ; errors, builtins, variables, TODO, org-level-3
   (orange     '("#d19a66" "#dd8844"     "brightred"    ))   ; numbers, constants, tags, org-list-dt (the gold)
   (green      '("#98c379" "#99bb66"     "green"        ))   ; strings, success, DONE, org-level-1, project-root
   (teal       '("#56b6c2" "#44b9b1"     "brightgreen"  ))   ; methods, operators, org-table
   (yellow     '("#e5c07b" "#ECBE7B"     "yellow"       ))   ; type names, warnings
   (blue       '("#61afef" "#51afef"     "brightblue"   ))   ; functions, hover highlight, dirs, dates
   (dark-blue  '("#528bff" "#2257A0"     "blue"         ))   ; selection / marks (search match highlight)
   (magenta    '("#c678dd" "#c678dd"     "brightmagenta"))   ; keywords (italic via override)
   (violet     '("#c678dd" "#a9a1e1"     "magenta"      ))   ; org-level-2 headings
   (cyan       '("#56b6c2" "#46D9FF"     "brightcyan"   ))   ; symlinks (rarely used)
   (dark-cyan  '("#2b6f77" "#5699AF"     "cyan"         ))   ; spare / barely used

   ;; universal syntax classes -- required by every doom theme.  Each one maps
   ;; a semantic role to one of the palette colors above.
   (highlight      blue)                                     ; hovered links, modeline accent bar, emphasis
   (vertical-bar   (doom-darken base1 0.1))                  ; vertical window splitter
   (selection      dark-blue)                                ; search matches, marks, isearch
   (builtin        red)                                      ; language built-ins (def, if, import...)
   (comments       base5)                                    ; comments
   (doc-comments   (doom-lighten base5 0.25))                ; docstrings / docs
   (constants      orange)                                   ; literal constants
   (functions      blue)                                     ; function names
   (keywords       magenta)                                  ; language keywords
   (methods        cyan)                                     ; method names
   (operators      cyan)                                     ; operators
   (type           yellow)                                   ; type names
   (strings        green)                                    ; string literals
   (variables      red)                                      ; variable names
   (numbers        orange)                                   ; numeric literals
   (region         `(,(doom-lighten (car bg-alt) 0.12) ,@(doom-lighten (cdr base1) 0.3))) ; selected text
   (error          red)                                      ; error messages / flycheck
   (warning        yellow)                                   ; warning messages
   (success        green)                                    ; success messages
   (vc-modified    orange)                                   ; git: modified files (magit/dired)
   (vc-added       green)                                    ; git: added files
   (vc-deleted     red)                                      ; git: deleted files

   ;; custom categories -- semantic colors used ONLY by the face overrides below
   (salmon    '("#e06c75" "#e06c75" "red"   ))               ; spare (was the old org-document-title)
   (olive     '("#98c379" "#98c379" "green" ))               ; org-code (inline code)
   (link      (doom-darken blue 0.2))                        ; hyperlinks (org-link) -- darker than blue
   (modeline-fg     fg)                                      ; active  modeline text
   (modeline-fg-alt base5)                                   ; inactive modeline text
   (modeline-bg             (doom-lighten bg 0.06))          ; active  modeline background (the grey bar ~#222221)
   (modeline-bg-alt         (doom-lighten bg 0.06))          ; second window's modeline
   (modeline-bg-inactive    (doom-lighten bg 0.03))          ; inactive modeline background (~#1b1b1a)
   (modeline-bg-inactive-alt (doom-lighten bg 0.03)))


  ;;;; Base theme face overrides -------------------------------------------
   (((font-lock-comment-face &override)
    :foreground comments :slant 'italic)                     ; comments are italic grey
   ((font-lock-keyword-face &override)
    :foreground keywords :slant 'italic)                     ; keywords are italic magenta
   ((font-lock-doc-face &override)
    :foreground doc-comments :slant 'italic)                 ; docstrings are lighter italic grey
   ((line-number &override) :foreground base4)               ; line numbers = mid-grey
   ((line-number-current-line &override) :foreground fg)     ; current line number = bright fg
   (mode-line
    :background modeline-bg :foreground modeline-fg          ; ACTIVE  modeline (grey bar, fg text)
    :box nil)                                                ; no border box
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt ; INACTIVE modeline (darker grey, dim text)
    :box nil)
   (mode-line-emphasis :foreground highlight)                ; emphasized modeline text (blue)
   (cursor :background "#b0b0b0" :foreground fg)             ; text cursor = light grey bar, letters stay fg
   (hl-line :background (doom-lighten bg 0.1) :extend t)     ; line under the cursor ~#2b2b2a

   ;;;; solaire-mode (dimmed side-buffers: dashboard, magit, help)
   (solaire-default-face :inherit 'default :background bg)   ; keep solaire bg = main bg
   (solaire-hl-line-face :inherit 'hl-line :background bg :extend t)

   ;;;; doom-modeline
   (doom-modeline-bar :background highlight)                 ; left accent bar (blue)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;;;; dired <built-in>
   (dired-directory :foreground blue)                        ; directory names
   (dired-header :foreground blue :weight 'bold)             ; column headers
   (dired-ignored :foreground comments)                      ; ignored/backup files
   (dired-flagged :foreground red)                           ; flagged for deletion
   (dired-marked :foreground magenta :weight 'bold :inverse-video t) ; marked files
   (dired-mark :foreground orange :weight 'bold)
   (dired-perm-write :foreground fg :underline t)            ; writable perms
   (dired-symlink :foreground cyan :weight 'bold)            ; symlinks
   (dired-warning :foreground warning)
   (dired-special :foreground yellow)                        ; sockets/pipes/executable special
   (dired-broken-symlink :foreground red :weight 'bold)      ; broken symlinks

   ;;;; org <built-in>
   (org-document-title :foreground base7 :weight 'bold :height 1.5) ; doc title = light grey, big + bold
   (org-level-1 :foreground green)                           ; *      headings
   (org-level-2 :foreground violet)                          ; **     headings
   (org-level-3 :foreground red)                             ; ***    headings
   (org-level-4 :foreground "#e0a35f")                       ; ****   headings (bright gold, not a palette var)
   (org-level-5 :foreground base5)                           ; deeper headings -> muted grey
   (org-level-6 :foreground fg)
   (org-level-7 :foreground base5)
   (org-level-8 :foreground fg)
   (org-ellipsis :foreground base5 :underline nil)           ; the "..." folding marker
   (org-tag :weight 'bold :foreground orange)                ; tags :tag:
   (org-todo :foreground red)                                ; TODO keyword
   (org-done :foreground green)                              ; DONE keyword
   (org-headline-done :foreground base5 :strike-through t)   ; completed headings
   (org-date :foreground blue :underline t)                  ; timestamps
   (org-link :foreground link :underline t)                  ; hyperlinks (uses `link` = darkened blue)
   (org-code :foreground olive)                              ; ~inline code~
   (org-block :background (doom-lighten bg 0.06))            ; #+begin_src / #+begin_example interior = grey box
   (org-block-begin-line :background (doom-lighten bg 0.06) :foreground comments) ; "#+begin..." line
   (org-block-end-line :background (doom-lighten bg 0.06) :foreground comments)   ; "#+end..." line
   (org-list-dt :foreground orange)                          ; "- term ::" description-list term
   (org-table :foreground teal)                              ; tables
   (org-hide :foreground bg)                                 ; hidden leading stars (invisible on bg)
   (org-document-info-keyword :foreground base5))            ; #+TITLE/#+AUTHOR keywords

  ;;;; Base theme variable overrides
  ())

;;; doom-greish-dark-theme.el ends here
