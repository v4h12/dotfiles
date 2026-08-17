;;; package --- An original theme inspired by boredom
;;; doom-greish-light-theme.el --- Doom-Greish-Light theme -*- lexical-binding: t; no-byte-compile: t; -*-

;;; commentary:
;;; light sibling of doom-greish-dark; retro sage/olive palette.
;;; tweak any color below, same rules as the dark theme (first hex = truecolor).

(require 'doom-themes)

;;; code:
(def-doom-theme doom-greish-light
  "Doom-Greish-Light: a retro sage light theme."
  :family 'greish
  :background-mode 'light

  ;; COLOR FORMAT ----------------------------------------------------------
  ;; (truecolor-hex   xterm-256  16-color-name) -- edit the FIRST hex.
  ;; helpers: (doom-darken X n) darker, (doom-lighten X n) lighter.
  ;; -----------------------------------------------------------------------

  ;; name       default   256           16
  ((bg         '("#848C7A" "#848C7A"    "white"        ))   ; overall background (the sage)
   (fg         '("#262B20" "#262B20"    "black"        ))   ; default text color

   ;; off-color variants of bg/fg, used for solaire-mode and subtle highlights
   (bg-alt     '("#777F6D" "#777F6D"    "white"        ))   ; darker sage (solaire panels, fills)
   (fg-alt     '("#555D4C" "#555D4C"    "brightblack"  ))   ; dimmed/de-emphasized text

   ;; spectrum bg->fg: base0 is a starker bg (lighter), base8 a starker fg (darker)
   (base0      '("#8A927E" "#8A927E"    "white"        ))   ; lightest ramp step (starker bg)
   (base1      '("#7F8774" "#7F8774"    "white"        ))
   (base2      '("#757D6B" "#757D6B"    "white"        ))
   (base3      '("#6B7361" "#6B7361"    "brightwhite"  ))
   (base4      '("#5E6654" "#5E6654"    "brightblack"  ))   ; LINE NUMBERS
   (base5      '("#4A5141" "#4A5141"    "brightblack"  ))   ; COMMENTS, muted headings (org L5/L7)
   (base6      '("#3A4133" "#3A4133"    "brightblack"  ))
   (base7      '("#2C3227" "#2C3227"    "brightblack"  ))   ; dark grey -- org-document-title
   (base8      '("#1D2218" "#1D2218"    "black"        ))   ; darkest (spare)

   (grey       base4)                                        ; alias for base4

   ;; main palette -- DEEP tones so they contrast against the mid-tone sage bg
   ;; (bright accents wash out; these sit ~2.7-3:1 vs bg, same zone as the dark greys)
   (red        '("#6F2A35" "#6F2A35"    "red"          ))   ; errors, builtins, variables, TODO, org-level-3
   (orange     '("#6F2A35" "#6F2A35"    "red"          ))   ; GOLD IS GONE -- this var exists only because doom's base
                                                          ; faces (all-the-icons-dorange, vc-annotate) reference it.
                                                          ; Pointed at deep brick so no amber ever shows.
   (green      '("#3A4F22" "#3A4F22"    "green"        ))   ; strings, success, DONE, org-level-1, project-root
   (teal       '("#2A4844" "#2A4844"    "cyan"         ))   ; methods, operators, org-table, org-level-4
   (yellow     '("#524413" "#524413"    "yellow"       ))   ; type names, warnings
   (blue       '("#2A4353" "#2A4353"    "blue"         ))   ; functions, hover highlight, dirs, dates
   (dark-blue  '("#243847" "#243847"    "blue"         ))   ; selection / marks
   (magenta    '("#463A5A" "#463A5A"    "magenta"      ))   ; keywords (italic via override), tags
   (violet     '("#463A5A" "#463A5A"    "magenta"      ))   ; org-level-2 headings
   (cyan       '("#234A45" "#234A45"    "cyan"         ))   ; symlinks (rarely used)
   (dark-cyan  '("#26433F" "#26433F"    "cyan"         ))   ; spare / barely used

   ;; universal syntax classes -- semantic roles -> palette colors
   (highlight      blue)                                     ; hovered links, modeline accent bar, emphasis
   (vertical-bar   (doom-darken base1 0.1))                  ; vertical window splitter
   (selection      dark-blue)                                ; search matches, marks, isearch
   (builtin        red)                                      ; language built-ins
   (comments       base5)                                    ; comments
   (doc-comments   (doom-lighten base5 0.25))                ; docstrings / docs
   (constants      red)                                      ; literal constants
   (functions      blue)                                     ; function names
   (keywords       magenta)                                  ; language keywords
   (methods        cyan)                                     ; method names
   (operators      cyan)                                     ; operators
   (type           yellow)                                   ; type names
   (strings        green)                                    ; string literals
   (variables      red)                                      ; variable names
   (numbers        red)                                      ; numeric literals
   (region         `(,(doom-darken (car bg-alt) 0.08) ,@(doom-darken (cdr bg-alt) 0.08))) ; selected text
   (error          red)                                      ; error messages / flycheck
   (warning        yellow)                                   ; warning messages
   (success        green)                                    ; success messages
   (vc-modified    yellow)                                   ; git: modified files
   (vc-added       green)                                    ; git: added files
   (vc-deleted     red)                                      ; git: deleted files

   ;; custom categories -- used only by the face overrides below
   (salmon    '("#6F2A35" "#6F2A35" "red"   ))               ; spare (was the old org-document-title)
   (olive     '("#3A4F22" "#3A4F22" "green" ))               ; org-code (inline code)
   (link      (doom-darken blue 0.2))                        ; hyperlinks (org-link) -- darker slate blue
   (modeline-fg     fg)                                      ; active  modeline text
   (modeline-fg-alt base5)                                   ; inactive modeline text
   (modeline-bg             (doom-darken bg 0.1))            ; active  modeline background (~#767E6C)
   (modeline-bg-alt         (doom-darken bg 0.1))            ; second window's modeline
   (modeline-bg-inactive    (doom-darken bg 0.13))           ; inactive modeline (~#717967)
   (modeline-bg-inactive-alt (doom-darken bg 0.13)))


  ;;;; Base theme face overrides -------------------------------------------
   (((font-lock-comment-face &override)
    :foreground comments :slant 'italic)                     ; comments are italic olive-grey
   ((font-lock-keyword-face &override)
    :foreground keywords :slant 'italic)                     ; keywords are italic violet
   ((font-lock-doc-face &override)
    :foreground doc-comments :slant 'italic)                 ; docstrings italic mid-grey
   ((line-number &override) :foreground base4)               ; line numbers = mid olive
   ((line-number-current-line &override) :foreground fg)     ; current line number = dark fg
   (mode-line
    :background modeline-bg :foreground modeline-fg          ; ACTIVE  modeline (dark sage bar, fg text)
    :box nil)
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt ; INACTIVE modeline (darker, dim text)
    :box nil)
   (mode-line-emphasis :foreground highlight)                ; emphasized modeline text (dusty blue)
   (cursor :background "#555D4C" :foreground fg)             ; text cursor = dark olive grey, letters stay fg
   (hl-line :background (doom-darken bg 0.06) :extend t)     ; line under the cursor (~#7B8371)

   ;;;; solaire-mode (dimmed side-buffers: dashboard, magit, help)
   (solaire-default-face :inherit 'default :background bg)   ; keep solaire bg = main bg
   (solaire-hl-line-face :inherit 'hl-line :background bg :extend t)

   ;;;; doom-modeline
   (doom-modeline-bar :background highlight)                 ; left accent bar (dusty blue)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;;;; dired <built-in>
   (dired-directory :foreground blue)                        ; directory names
   (dired-header :foreground blue :weight 'bold)             ; column headers
   (dired-ignored :foreground comments)                      ; ignored/backup files
   (dired-flagged :foreground red)                           ; flagged for deletion
   (dired-marked :foreground magenta :weight 'bold :inverse-video t) ; marked files
   (dired-mark :foreground red :weight 'bold)
   (dired-perm-write :foreground fg :underline t)            ; writable perms
   (dired-symlink :foreground cyan :weight 'bold)            ; symlinks
   (dired-warning :foreground warning)
   (dired-special :foreground yellow)                        ; sockets/pipes/executable special
   (dired-broken-symlink :foreground red :weight 'bold)      ; broken symlinks

   ;;;; org <built-in>
   (org-document-title :foreground base7 :weight 'bold :height 1.5) ; doc title = dark grey, big + bold
   (org-level-1 :foreground green)                           ; *      headings (deep olive)
   (org-level-2 :foreground violet)                          ; **     headings (deep aubergine)
   (org-level-3 :foreground red)                             ; ***    headings (deep brick)
   (org-level-4 :foreground teal)                            ; ****   headings (deep pine -- gold is gone)
   (org-level-5 :foreground base5)                           ; deeper headings -> muted grey
   (org-level-6 :foreground fg)
   (org-level-7 :foreground base5)
   (org-level-8 :foreground fg)
   (org-ellipsis :foreground base5 :underline nil)           ; the "..." folding marker
   (org-tag :weight 'bold :foreground violet)                ; tags :tag: (deep aubergine)
   (org-todo :foreground red)                                ; TODO keyword
   (org-done :foreground green)                              ; DONE keyword
   (org-headline-done :foreground base5 :strike-through t)   ; completed headings
   (org-date :foreground blue :underline t)                  ; timestamps
   (org-link :foreground link :underline t)                  ; hyperlinks (uses `link` = darkened dusty blue)
   (org-code :foreground olive)                              ; ~inline code~
   (org-block :background (doom-darken bg 0.1))              ; #+begin_src / #+begin_example interior = dark sage box
   (org-block-begin-line :background (doom-darken bg 0.1) :foreground comments) ; "#+begin..." line
   (org-block-end-line :background (doom-darken bg 0.1) :foreground comments)   ; "#+end..." line
   (org-list-dt :foreground teal)                            ; "- term ::" description-list term (deep pine)
   (org-table :foreground teal)                              ; tables
   (org-hide :foreground bg)                                 ; hidden leading stars (invisible on bg)
   (org-document-info-keyword :foreground base5))            ; #+TITLE/#+AUTHOR keywords

  ;;;; Base theme variable overrides
  ())

;;; doom-greish-light-theme.el ends here
