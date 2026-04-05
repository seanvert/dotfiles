;;; init.el --- Emacs Startup File

;; ===================================================================
;; 1. Emacs Core Settings & Optimizations
;; ===================================================================

;; Increase garbage collection threshold for faster startup
(setq gc-cons-threshold 100000000)
;; Allow larger process output to prevent truncation (e.g., in LSP/Eglot)
(setq read-process-output-max (* 1024 1024))

;; Suppress startup messages/screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; ===================================================================
;; 2. Package Management Bootstrap (Required for use-package)
;; ===================================================================

(require 'package)
(setq package-enable-at-startup nil)

;; Define package archives BEFORE package-initialize
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)


;; Force a refresh of the package list on first run (fixes dependency issues)
;; (package-refresh-contents)

;; Initialize the package system to load available packages
(package-initialize)

;; 3. Bootstrap use-package (The core of a modern Emacs config)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; CRITICAL: Makes all packages defined with `use-package` install automatically
(setq use-package-always-ensure t)

;; ===================================================================
;; 4. Load Configuration (Use a dedicated Org file for structure)
;; ===================================================================

;; This line loads your main configuration, which should be in an Org file.
;; It assumes your configuration is located at ~/.emacs.d/config.org
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


;; Ensure the server is started *after* everything is initialized
(use-package server
  :config
  (add-hook 'after-init-hook (lambda ()
                              (when (and (fboundp 'server-running-p)
                                         (not (server-running-p)))
                                (server-start)))))

;; ===================================================================
;; 5. Final Commands
;; ===================================================================

;; If you use the desktop/session save feature
(desktop-save-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(org-agenda-files
   '("/home/arch/.emacs.d/config.org" "/home/arch/bruner spiral.org"
	 "/home/arch/estudo-exatas.org"))
 '(package-selected-packages
   '(anki-editor apheleia auto-org-md auto-yasnippet cider company-box
				 company-c-headers company-ghci company-math composer
				 consult corfu counsel dante dash-functional deft
				 devdocs eat elpy esup exec-path-from-shell
				 flycheck-clj-kondo flycheck-joker flycheck-mypy
				 flycheck-pycheckers forge gif-screencast god-mode
				 helpful hindent hl-todo howdoyou html-to-markdown
				 hydra keycast linum-relative lsp-mode lsp-ui
				 marginalia merlin-eldoc mistty multi-term nov
				 ob-restclient ob-sml olivetti orderless
				 org-attach-screenshot org-download org-journal
				 org-noter org-projectile org-ref org-ref-ivy org-roam
				 org-roam-ui org-superstar pdf-view-restore pdfgrep
				 php-mode rainbow-delimiters rainbow-mode reason-mode
				 restclient rust-mode smartparens smex
				 tree-sitter-langs try tuareg undo-tree vertico
				 yaml-mode yasnippet-snippets zotxt)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
