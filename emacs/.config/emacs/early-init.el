;;; early-init.el --- Early setup -*- lexical-binding: t; -*-
;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
;;
;;; Commentary:
;;
;; This file is just a set of code that runs before the main initialisation
;; starts. Here, I introduce some hacks that can potentially speed up launch of
;; Emacs and other changes related to default GUI.
;;
;; One day, when I feel more confident with Emacs, I may improve notes here, or
;; even put those somewhere else and expand them, to not only say why X, but
;; also show alternatives and differences in approaches, as it's something that
;; would be really helpful for me, when I started this configuration. But it's
;; not yet that day.
;;
;;; Code:

;; Prevent package.el from acting before elpaca.
(setq package-enable-at-startup nil) ; Suggested in elpaca docs.

;; Skip system-wide site-start.el.
(setq site-run-file nil)

;; Defer garbage collection during startup. You'll probably see in many
;; places, that it's not recommended to do so, when you don't know what you're
;; doing. It's true. Here, the finishing bit, that sets those values to various
;; more optimized values is using `gcmh-mode', later in `init.el'.
(setq gc-cons-percentage 1.0)
(setq gc-cons-threshold most-positive-fixnum)

;;; Disable the toolbar using frame parameters, so it's never created.
(push '(tool-bar-lines . 0) default-frame-alist)
;; Apply the same trick for menu bar and scroll bar
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(horizontal-scroll-bars . nil) default-frame-alist)

;; Disable the resize of the frame during startup.
(setq frame-inhibit-implied-resize t)

;; Enable native-compile for packages, when they are installed, instead of
;; stalling when they get loaded for the first time.
(setq package-native-compile t)

;; Suppress startup noise.
(setq inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;;; early-init.el ends here
