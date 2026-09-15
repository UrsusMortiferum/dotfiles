;;; init.el --- Entry point for my configuration -*- lexical-binding: t; no-byte-compile: t -*-
;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
;;
;;; Commentary:
;;
;; This is an entry point for my Emacs configuration. Here, I tackle a few
;; annoyance, boostrap elpaca (current package manager of choice) and load the
;; rest of configuration files.
;;
;;; Code:

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Elpaca bootstrap
(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Uncomment for systems which cannot create symlinks:
;; (elpaca-no-symlink-mode)

;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;; (elpaca example-package)

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)

;; Expands to: (elpaca evil (use-package evil :demand t))
;; (use-package evil :ensure t :demand t)

;;Turns off elpaca-use-package-mode current declaration
;;Note this will cause evaluate the declaration immediately. It is not deferred.
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

;; gcmh
(use-package gcmh
  :ensure t
  :hook (emacs-startup-hook . gcmh-mode)
  :config
  (setq gcmh-idle-delay 'auto ; default is 15s
        gcmh-auto-idle-delay-factor 10
        gcmh-high-cons-threshold (* 64 1024 1024))) ; 64mb

;; ;; (defun insert-divider ()
;; ;;   "Insert  a visual section divider."
;; ;;   (interactive)
;; ;;   (insert "\n" (make-string fill-column ?-) "\n"))

;; ;; Allow upgrading built-in packages
;; (setq package-install-upgrade-built-in t)

;; ;; UI
;; (setq tab-bar-show 1)
;; (set-fringe-mode 10)
;; (setq ring-bell-function 'ignore) ;; Disable bells, cuz we don't like when editor shouts at you
;; (global-display-fill-column-indicator-mode 1) ;; Draw column on the right of maximum width
;; (hl-line-mode t) ;; Enable current line highlighting
;; (blink-cursor-mode -1) ;; Disable cursor blinking
;; (setq-default fill-column 80) ;; Set the default column width
;; (global-display-line-numbers-mode 1) ;; Show line numbers
;; (setq display-line-numbers-type 'relative) ;; Show the line number relative to cursor position
;; (dolist (mode '(ghostel-mode-hook
;; 		org-mode-hook)) ;; Disable line numbers for some modes
;;   (add-hook mode (lambda ()
;; 		   (display-line-numbers-mode 0)
;; 		   (display-fill-column-indicator-mode 0))))
;; (setq use-dialog-box nil) ;; Disable GUI dialog box

;; ;; Font setup
;; (set-face-attribute 'default nil
;;                     :family "Iosevka Nerd Font"
;;                     :height 130)

;; (savehist-mode 1) ;; Enable minibuffer prompt history
;; (setq history-length 25) ;; Set history to 25 positions
;; (save-place-mode 1) ;;

;; (global-auto-revert-mode 1) ;; Revert buffers when the underlying file has changed
;; (setq global-auto-revert-non-file-buffers t) ;; Revert Dired and other buffers

;; (setq make-backup-files nil) ;; Don't store backup
;; (setq auto-save-default nil) ;; Disable auto-save

;; ;; Experimenting with icons
;; (use-package nerd-icons
;;   :ensure t)

;; (use-package nerd-icons-dired
;;   :ensure t
;;   :after (nerd-icons dired)
;;   :config
;;   (add-hook 'dired-mode-hook #'nerd-icons-dired-mode))

;; ;; Setup the theme
(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-gruvbox t))

;; Better terminal
;; (use-package ghostel :elpaca nil)
(use-package ghostel)

;; (use-package lua-mode :ensure t)
;; (use-package nix-mode :ensure t)

;; ;; Undo tree
;; (use-package undo-tree
;;   :ensure t
;;   :config
;;   (global-undo-tree-mode)
;;   (setq undo-tree-history-directory-alist '(("." . "~/.local/emacs/undo/")))
;;   (unless (file-exists-p "~/.local/emacs/undo/")
;;     (make-directory "~/.local/emacs/undo/" t)))

;; ;; Enable Vertico.
;; (use-package vertico
;;   :ensure t
;;   :custom
;;   ;; (vertico-scroll-margin 0) ;; Different scroll margin
;;   ;; (vertico-count 20) ;; Show more candidates
;;   ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
;;   (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
;;   :init
;;   (vertico-mode))

;; ;; Persist history over Emacs restarts. Vertico sorts by history position.
;; (use-package savehist
;;   :init
;;   (savehist-mode))

;; ;; Emacs minibuffer configurations.
;; (use-package emacs
;;   :custom
;;   ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
;;   ;; to switch display modes.
;;   (context-menu-mode t)
;;   ;; Support opening new minibuffers from inside existing minibuffers.
;;   (enable-recursive-minibuffers t)
;;   ;; Hide commands in M-x which do not work in the current mode.  Vertico
;;   ;; commands are hidden in normal buffers. This setting is useful beyond
;;   ;; Vertico.
;;   (read-extended-command-predicate #'command-completion-default-include-p)
;;   ;; Do not allow the cursor in the minibuffer prompt
;;   (minibuffer-prompt-properties
;;    '(read-only t cursor-intangible t face minibuffer-prompt)))

;; ;; Enable rich annotations using the Marginalia package
;; (use-package marginalia
;;   :ensure t
;;   ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
;;   ;; available in the *Completions* buffer, add it to the
;;   ;; `completion-list-mode-map'.
;;   :bind (:map minibuffer-local-map
;;               ("M-A" . marginalia-cycle))

;;   ;; The :init section is always executed.
;;   :init

;;   ;; Marginalia must be activated in the :init section of use-package such that
;;   ;; the mode gets enabled right away. Note that this forces loading the
;;   ;; package.
;;   (marginalia-mode))

;; ;; Optionally use the `orderless' completion style.
;; (use-package orderless
;;   :ensure t
;;   :custom
;;   ;; Configure a custom style dispatcher (see the Consult wiki)
;;   ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
;;   ;; (orderless-component-separator #'orderless-escapable-split-on-space)
;;   (completion-styles '(orderless basic))
;;   (completion-category-overrides '((file (styles partial-completion))))
;;   (completion-category-defaults nil) ;; Disable defaults, use our settings
;;   (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; (use-package consult
;;   :ensure t
;;   :bind (("C-c C-s" . consult-line)
;; 	 ("C-x b" . consult-buffer)
;; 	 ;; ("C-x C-f" . consult-find)
;; 	 ("M-y" . consult-yank-pop)))

;; ;; Corfu - in-buffer completion popup
;; (use-package corfu
;;   :ensure t
;;   ;; Optional customizations
;;   ;; :custom
;;   ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
;;   ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
;;   ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
;;   ;; (corfu-preview-current nil)    ;; Disable current candidate preview
;;   ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
;;   ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

;;   ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
;;   ;; :hook ((prog-mode . corfu-mode)
;;   ;;        (shell-mode . corfu-mode)
;;   ;;        (eshell-mode . corfu-mode))

;;   :init

;;   ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
;;   ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
;;   ;; variable `global-corfu-modes' to exclude certain modes.
;;   (global-corfu-mode)

;;   ;; Enable optional extension modes:
;;   ;; (corfu-history-mode)
;;   ;; (corfu-mouse-mode)
;;   ;; (corfu-popupinfo-mode)
;;   )

;; ;; A few more useful configurations...
;; (use-package emacs
;;   :custom
;;   ;; TAB cycle if there are only few candidates
;;   ;; (completion-cycle-threshold 3)

;;   ;; Enable indentation+completion using the TAB key.
;;   ;; `completion-at-point' is often bound to M-TAB.
;;   (tab-always-indent 'complete)

;;   ;; Emacs 30 and newer: Disable Ispell completion function.
;;   ;; Try `cape-dict' as an alternative.
;;   (text-mode-ispell-word-completion nil)

;;   ;; Hide commands in M-x which do not apply to the current mode.  Corfu
;;   ;; commands are hidden, since they are not used via M-x. This setting is
;;   ;; useful beyond Corfu.
;;   (read-extended-command-predicate #'command-completion-default-include-p))

;; Magit
(use-package magit
  :ensure t)

;; ;; Markdown
;; (use-package markdown-mode
;;   :ensure t
;;   :mode "\\.md\\'")

;; ;; Org Mode
;; (use-package org-modern
;;   :ensure t
;;   :mode ("\\.org\\'" . org-mode)
;;   :custom
;;   (setq org-auto-align-tags nil ;; Disable auto-align for tags -> less visual shuffling
;; 	org-tags-column 0
;; 	org-catch-invisible-edits 'show-and-error
;; 	org-special-ctrl-a/e t
;; 	org-insert-heading-respect-content t

;; 	;; Org styling, hide markup etc.
;; 	org-hide-emphasis-markers t
;; 	org-pretty-entities t
;; 	org-agenda-tags-column 0
;; 	org-ellipsis "...")
;;   (org-modern-start 'replace)
;;   :config
;;   (set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)
;;   :init
;;   (global-org-modern-mode))

;;; Python
;;
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((python-base-mode :language-id "python") . ("uvx" "ty" "server"))))

(add-hook 'python-base-mode-hook 'eglot-ensure)


;; (use-package lsp-mode
;;   :ensure t
;;   :custom
;;   (lsp-prefer-flymake nil)  ; Use Flycheck instead (your choice)
;;   :config
;;   ;; Main type checker - Ty
;;   (lsp-register-client
;;    (make-lsp-client
;;     :new-connection (lsp-stdio-connection '("ty" "server"))
;;     :major-modes '(python-mode python-ts-mode)
;;     :server-id 'ty
;;     :add-on? nil  ; Primary server
;;     :priority 10))

;;   ;; Ruff as add-on for linting/formatting
;;   (lsp-register-client
;;    (make-lsp-client
;;     :new-connection (lsp-stdio-connection '("ruff" "server"))
;;     :major-modes '(python-mode python-ts-mode)
;;     :server-id 'ruff
;;     :add-on? t  ; Secondary/additional server
;;     :priority 5))

;;   ;; Disable Ty's syntax errors to avoid conflicts with Ruff
;;   (setq-default lsp-ty-diagnostic-options
;;                 (list '(:showSyntaxErrors . nil))))

;;; init.el ends here
