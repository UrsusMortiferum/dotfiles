;;; 10_options.el --- Options, hacks -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

;; Disable bidirectional text scanning for.
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Save the clipboard before killing
(setq save-interprogram-paste-before-kill t)

;; Deduplicate kill ring
(setq kill-do-not-save-duplicates t)

;; ;; Persist kill ring across sessions
;; (setq savehist-additional-variables
;;       '(search-ring regexp-search-ring kill-ring))

;; Increase process output buffer for LSP, to reduce number of required calls.
;; Default values is 64KB, benefit should be mainly visible when working with
;; modern LSPs or larger files.
(setq read-process-output-max (* 4 1024 1024))  ; 4MB

;; Disable bells (visual & sound), cuz we don't appreciate when editor shouts at you
(setq ring-bell-function 'ignore)
;; Draw column on the right of maximum width
(global-display-fill-column-indicator-mode 1)
;; Enable current line highlighting
(hl-line-mode t)
;; Disable cursor blinking
(blink-cursor-mode -1)

;; Show line numbers
(global-display-line-numbers-mode 1)
;; Show line numbers relative to cursor position
(setq display-line-numbers-type 'relative)

(provide '10_options)
;;; 10_options.el ends here
