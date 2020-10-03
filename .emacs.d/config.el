(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(require 'use-package)
(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(setq desktop-load-locked-desktop t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq read-process-output-max (* 1024 1024))  ;; lsp-mode's performance suggest

(if (and (fboundp 'server-running-p)
 		 (not (server-running-p)))
 	(server-start))

;; (define-key key-translation-map (kbd "<f1>") (kbd "TAB"))
;; (define-key key-translation-map (kbd "<f2>") (kbd "("))
;; (define-key key-translation-map (kbd "<f5>") (kbd "+"))
;; (define-key key-translation-map (kbd "<f6>") (kbd "-"))
;; (define-key key-translation-map (kbd "<f7>") (kbd "="))
;; (define-key key-translation-map (kbd "<f8>") (kbd "_"))
;; (define-key key-translation-map (kbd "<f9>") (kbd "õ"))
;; (define-key key-translation-map (kbd "<f11>") (kbd "ã"))
;; (define-key key-translation-map (kbd "<C-f1>") (kbd "1"))
;; (define-key key-translation-map (kbd "<C-f2>") (kbd "2"))
;; (define-key key-translation-map (kbd "<C-f3>") (kbd "3"))
;; (define-key key-translation-map (kbd "<C-f4>") (kbd "4"))
;; (define-key key-translation-map (kbd "<C-f5>") (kbd "5"))
;; (define-key key-translation-map (kbd "<C-f6>") (kbd "6"))
;; (define-key key-translation-map (kbd "<C-f7>") (kbd "7"))
;; (define-key key-translation-map (kbd "<C-f8>") (kbd "8"))
;; (define-key key-translation-map (kbd "<C-f9>") (kbd "9"))

(setenv "PATH" (concat (getenv "PATH") ":~/.local/bin"))
(setq exec-path (append exec-path '("~/.local/bin")))

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))
(unless (assoc-default "melpa-stable" package-archives)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))

(require 'iso-transl)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; (use-package ewal
;;   :init (setq ewal-use-built-in-always-p nil
;;               ewal-use-built-in-on-failure-p nil
;;               ewal-built-in-palette "sexy-material"))

;; highlight lines
(global-hl-line-mode)

(set-frame-font "Droid Sans Mono for Powerline Plus Nerd File Types Mono" nil t)

(use-package olivetti)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;; How tall the mode-line should be. It's only respected in GUI.
;; If the actual char height is larger, it respects the actual height.
(setq doom-modeline-height 25)

;; How wide the mode-line bar should be. It's only respected in GUI.
(setq doom-modeline-bar-width 3)

;; The limit of the window width.
;; If `window-width' is smaller than the limit, some information won't be displayed.
(setq doom-modeline-window-width-limit fill-column)

;; How to detect the project root.
;; The default priority of detection is `ffip' > `projectile' > `project'.
;; nil means to use `default-directory'.
;; The project management packages have some issues on detecting project root.
;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
;; to hanle sub-projects.
;; You can specify one if you encounter the issue.
(setq doom-modeline-project-detection 'project)

;; Determines the style used by `doom-modeline-buffer-file-name'.
;;
;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;;   auto => emacs/lisp/comint.el (in a project) or comint.el
;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;;   truncate-with-project => emacs/l/comint.el
;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;;   truncate-all => ~/P/F/e/l/comint.el
;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
;;   relative-from-project => emacs/lisp/comint.el
;;   relative-to-project => lisp/comint.el
;;   file-name => comint.el
;;   buffer-name => comint.el<2> (uniquify buffer name)
;;
;; If you are experiencing the laggy issue, especially while editing remote files
;; with tramp, please try `file-name' style.
;; Please refer to https://github.com/bbatsov/projectile/issues/657.
(setq doom-modeline-buffer-file-name-style 'auto)

;; Whether display icons in the mode-line.
;; While using the server mode in GUI, should set the value explicitly.
(setq doom-modeline-icon (display-graphic-p))

;; Whether display the icon for `major-mode'. It respects `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Whether display the colorful icon for `major-mode'.
;; It respects `all-the-icons-color-icons'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display the icon for the buffer state. It respects `doom-modeline-icon'.
(setq doom-modeline-buffer-state-icon t)

;; Whether display the modification icon for the buffer.
;; It respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
(setq doom-modeline-buffer-modification-icon t)

;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
(setq doom-modeline-unicode-fallback nil)

;; Whether display the minor modes in the mode-line.
(setq doom-modeline-minor-modes nil)

;; If non-nil, a word count will be added to the selection-info modeline segment.
(setq doom-modeline-enable-word-count nil)

;; Major modes in which to display word count continuously.
;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
;; remove the modes from `doom-modeline-continuous-word-count-modes'.
(setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

;; Whether display the buffer encoding.
(setq doom-modeline-buffer-encoding t)

;; Whether display the indentation information.
(setq doom-modeline-indent-info nil)

;; If non-nil, only display one number for checker information if applicable.
(setq doom-modeline-checker-simple-format t)

;; The maximum number displayed for notifications.
(setq doom-modeline-number-limit 99)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 12)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(setq doom-modeline-workspace-name t)

;; Whether display the perspective name. Non-nil to display in the mode-line.
(setq doom-modeline-persp-name t)

;; If non nil the default perspective name is displayed in the mode-line.
(setq doom-modeline-display-default-persp-name nil)

;; If non nil the perspective name is displayed alongside a folder icon.
(setq doom-modeline-persp-icon t)

;; Whether display the `lsp' state. Non-nil to display in the mode-line.
(setq doom-modeline-lsp t)

;; Whether display the GitHub notifications. It requires `ghub' package.
(setq doom-modeline-github nil)

;; The interval of checking GitHub.
(setq doom-modeline-github-interval (* 30 60))

;; Whether display the modal state icon.
;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
(setq doom-modeline-modal-icon t)

;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
(setq doom-modeline-mu4e nil)

;; Whether display the gnus notifications.
(setq doom-modeline-gnus t)

;; Wheter gnus should automatically be updated and how often (set to 0 or smaller than 0 to disable)
(setq doom-modeline-gnus-timer 2)

;; Wheter groups should be excludede when gnus automatically being updated.
(setq doom-modeline-gnus-excluded-groups '("dummy.group"))

;; Whether display the IRC notifications. It requires `circe' or `erc' package.
(setq doom-modeline-irc t)

;; Function to stylize the irc buffer names.
(setq doom-modeline-irc-stylize 'identity)

;; Whether display the environment version.
(setq doom-modeline-env-version t)
;; Or for individual languages
(setq doom-modeline-env-enable-python t)
(setq doom-modeline-env-enable-ruby t)
(setq doom-modeline-env-enable-perl t)
(setq doom-modeline-env-enable-go t)
(setq doom-modeline-env-enable-elixir t)
(setq doom-modeline-env-enable-rust t)

;; Change the executables to use for the language version string
(setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
(setq doom-modeline-env-ruby-executable "ruby")
(setq doom-modeline-env-perl-executable "perl")
(setq doom-modeline-env-go-executable "go")
(setq doom-modeline-env-elixir-executable "iex")
(setq doom-modeline-env-rust-executable "rustc")

;; What to dispaly as the version while a new one is being loaded
(setq doom-modeline-env-load-string "...")

;; Hooks that run before/after the modeline version string is updated
(setq doom-modeline-before-update-env-hook nil)
(setq doom-modeline-after-update-env-hook nil)

(use-package all-the-icons)

(defun fk/disable-all-themes ()
  "Disable all active themes."
  (interactive)
  (dolist (theme custom-enabled-themes)
    (disable-theme theme)))

(defadvice load-theme (before disable-themes-first activate)
  (fk/disable-all-themes))

(use-package poet-theme
  :defer t)

(use-package doom-themes)
(load-theme 'doom-horizon t)

(scroll-bar-mode -1)
(setq scroll-step            1
      scroll-conservatively  10000)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default mode-line-buffer-identification (list -40 (propertized-buffer-identification "%12b")))

(global-prettify-symbols-mode 1)

(defvar user-temporary-file-directory "~/.emacs-autosaves/")
(setq-default 
 ring-bell-function 'ignore
 inhibit-startup-screen t
 initial-major-mode 'fundamental-mode
 initial-scratch-message nil
 create-lockfiles nil
 backup-by-copying t
 require-final-newline t
 delete-old-versions t)
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . ,user-temporary-file-directory) 
			       (tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))

(add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
(use-package pdf-view-restore
  :after pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))
(add-hook 'pdf-view-mode-hook (lambda () (pdf-view-restore-mode t)))
(use-package pdfgrep)
(use-package pdf-tools
  :ensure t
  ;; :pin manual ;; manually update
  :config
  ;; initialise
  (pdf-tools-install)
  ;; numero de páginas no cache. default 64
  (setq pdf-cache-image-limit 15)
  ;; tempo que ele demora pra apagar uma imagem do cache
  (setq image-cache-eviction-delay 180)
  ;; open pdfs scaled to fit page
  ;; fit-height, fit-width, fit-page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; 
  ;; use normal isearch
  ;; (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  ;; turn off cua so copy works
  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1)
  ;; keyboard shortcuts
  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)
  (define-key pdf-view-mode-map (kbd "z") 'org-noter))

;; troca a cor do midnight mode para combinar com a cor do tema
(setq pdf-view-midnight-colors (cons (face-attribute 'default :foreground) (face-attribute 'default :background)))

;; TODO FAZER O BÁSICO PRIMEIRO
(setq pdf-time-before 0)
(setq pdf-time-after 0)
;; TODO adicionar uma função para chamar isso
(add-hook 'pdf-view-after-change-page-hook (lambda () (progn (set-pdf-time-after)
														(message (int-to-string (- pdf-time-after pdf-time-before)))
														(set-pdf-time-before))))


;;TODO: fazer uma função pra entrar no hook do relógio conforme passam
;;os minutos e pegar a janela com foco e ver se é uma janela do org
;;noter ou do pdf
;; comando do shell pra pegar a janela ativa
;; xdotool getwindowfocus getwindowname

(defun set-pdf-time-after ()
  (setq pdf-time-after (hhmmtomm (car (split-string (substring-no-properties display-time-string) " ")))))

(defun set-pdf-time-before ()
  (setq pdf-time-before (hhmmtomm (car (split-string (substring-no-properties display-time-string) " ")))))

;; TODO uma função que checa se avançamos nas páginas
(defun pdf-check-page-advance ()
  (interactive)
  "checks if we are going forward on non-read pages"
  (if (not (member (pdf-view-current-page) pdf-time-pages))
	  (setq pdf-time-pages (append (pdf-view-current-page)))))
;; TODO uma função que conta o tempo numa página
;; TODO uma outra função que estima o tempo final
;; TODO uma função que pega a última página como algo arbitrário para remover índices no final

(use-package eaf
  :load-path "/usr/share/emacs/site-lisp/eaf" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding))

(use-package try)

(use-package rainbow-mode
  :hook
  (css-mode . rainbow-mode)
  (web-mode . rainbow-mode))

(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                                           :height 1.0))
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-hook 'nov-mode-hook 'visual-line-mode)
;; justification on buffers
(load "justify-kp")
;; (use-package justify-kp)
(setq nov-text-width t)

(defun my-nov-window-configuration-change-hook ()
  (my-nov-post-html-render-hook)
  (remove-hook 'window-configuration-change-hook
               'my-nov-window-configuration-change-hook
               t))

(defun my-nov-post-html-render-hook ()
  (if (get-buffer-window)
      (let ((max-width (pj-line-width))
            buffer-read-only)
        (save-excursion
          (goto-char (point-min))
          (while (not (eobp))
            (when (not (looking-at "^[[:space:]]*$"))
              (goto-char (line-end-position))
              (when (> (shr-pixel-column) max-width)
                (goto-char (line-beginning-position))
                (pj-justify)))
            (forward-line 1))))
    (add-hook 'window-configuration-change-hook
              'my-nov-window-configuration-change-hook
              nil t)))

(add-hook 'nov-post-html-render-hook 'my-nov-post-html-render-hook)
;;(add-hook 'nov-mode-hook 'visual-fill-column-mode)

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
  (global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
  (global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
  (global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp))

(use-package deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        ;; de-couples filename and note title:
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename t
        ;; disable auto-save
        deft-auto-save-interval -1.0
        ;; converts the filter string into a readable file-name using kebab-case:
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))
  :config
  (add-to-list 'deft-extensions "tex")
  )

(setq
 org_notes "/ubuntu/home/sean/" ;; (concat (getenv "HOME") "/Git/Gitlab/Mine/Notes/")
 zot_bib (concat (getenv "HOME") "/Minha biblioteca.bib")
 org-directory org_notes
 deft-directory org_notes
 org-roam-directory org_notes)

(use-package org-roam
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  ;; Set this to nil so we can later detect whether the user has set a custom
  ;; directory for it, and default to `org-directory' if they haven't.
  ;; (defvar org-roam-directory nil)
  :init
  :config
  (add-to-list 'org-roam-capture-templates
               '("w" "webref" plain (function org-roam-capture--get-point)
                 "%?"
                 :file-name "web/${slug}"
                 :head "#+TITLE: ${title}\n#+ROAM_KEY: %x\n#+ROAM_ALIAS: \n#+ROAM_TAGS: ${tags} \n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- links :: \n\n"
                 :unnarrowed t))
  (add-to-list 'org-roam-capture-templates '("r" "regular" plain (function org-roam-capture--get-point)
                                             "%?"
                                             :file-name "${slug}"
                                             :head "#+TITLE: ${title}\n#+ROAM_KEY: \n#+ROAM_ALIAS: \n#+ROAM_TAGS: ${tags} \n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- links :: \n\n"
                                             :unnarrowed t))
  (require 'org-roam-protocol)
  (setq 
;; org-roam-directory (expand-file-name (or org-roam-directory "roam")
;;                                               org-directory)
        org-roam-verbose nil  ;; https://youtu.be/fn4jIlFwuLU
;; changed this 
        ;; org-roam-buffer-no-delete-other-windows t ;; make org-roam buffer sticky
                org-roam-buffer-window-parameters '((no-delete-other-windows . t))
        org-roam-completion-system 'default
                org-roam-graph-executable "/usr/bin/dot"
                org-roam-graph-viewer "/usr/bin/google-chrome-stable"
                org-roam-completion-system 'helm
                org-roam-index-file "index.org"


  ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; (but not `find-file', to limit the scope of this behavior).
  ;; (add-hook 'find-file-hook
  ;;   (defun +org-roam-open-buffer-maybe-h ()
  ;;     (and +org-roam-open-buffer-on-find-file
  ;;          (memq 'org-roam-buffer--update-maybe post-command-hook)
  ;;          (not (window-parameter nil 'window-side)) ;; don't proc for popups
  ;;          (not (eq 'visible (org-roam-buffer--visibility)))
  ;;          (with-current-buffer (window-buffer)
  ;;            (org-roam-buffer--get-create)))))

  ;; ;; Hide the 
  ;; mode line in the org-roam buffer, since it serves no purpose. This
  ;; makes it easier to distinguish among other org buffers.
  ;; (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)
                )
  :bind (:map org-roam-mode-map
                          (("C-c n l" . org-roam)
                           ("C-c n f" . org-roam-find-file)
                           ("C-c n g" . org-roam-graph)
                           ("C-c n i" . org-roam-insert)
                           ("C-c n I" . org-roam-insert-immediate)
                           ("C-c n d" . deft)))
  )


;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.

;; (use-package org-roam-protocol
;;   :after org-protocol)

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config

  (setq orb-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))

  (setq orb-templates
	'(("r" "ref" plain (function org-roam-capture--get-point)
	   ""
	   :file-name "${slug}"
	   :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}
	   - tags ::
	   - keywords :: ${keywords}
	   \n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"
	   :unnarrowed t))))

(use-package linum-relative)
(column-number-mode 1)
(setq linum-relative-current-symbol "")

(use-package rainbow-delimiters
  :config
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
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1"))))))

(use-package anki-editor
  :after org
  :bind (:map org-mode-map
              ("<f12>" . anki-editor-cloze-region-auto-incr)
              ("<f11>" . anki-editor-cloze-region-dont-incr)
              ("<f10>" . anki-editor-reset-cloze-number)
              ("<f9>"  . anki-editor-push-tree))
  :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
  :config
  (setq anki-editor-create-decks t ;; Allow anki-editor to create a new deck if it doesn't exist
        anki-editor-org-tags-as-anki-tags t)

  (defun anki-editor-cloze-region-auto-incr (&optional arg)
    "Cloze region without hint and increase card number."
    (interactive)
    (anki-editor-cloze-region my-anki-editor-cloze-number "")
    (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
    (forward-sexp))
  (defun anki-editor-cloze-region-dont-incr (&optional arg)
    "Cloze region without hint using the previous card number."
    (interactive)
    (anki-editor-cloze-region (1- my-anki-editor-cloze-number) "")
    (forward-sexp))
  (defun anki-editor-reset-cloze-number (&optional arg)
    "Reset cloze number to ARG or 1"
    (interactive)
    (setq my-anki-editor-cloze-number (or arg 1)))
  (defun anki-editor-push-tree ()
    "Push all notes under a tree."
    (interactive)
    (anki-editor-push-notes '(4))
    (anki-editor-reset-cloze-number))
  ;; Initialize
  (anki-editor-reset-cloze-number)
  )

(setq org-my-anki-file "/ubuntu/home/sean/anki.org")

;; Allow Emacs to access content from clipboard.
(setq select-enable-clipboard t
      select-enable-primary t)

(use-package gif-screencast)
(use-package keycast)
;;(setq keycast-insert-after "%e")
(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))
;;(setq mode-line-format mode-line-keycast)

(use-package undo-tree)
(global-undo-tree-mode)

(require 'mu4e)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)

(setq mu4e-drafts-folder "/[Gmail].Rascunhos")
(setq mu4e-sent-folder   "/[Gmail].E-mails enviados")
(setq mu4e-trash-folder  "/[Gmail].Lixeira")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

;; (setq mu4e-maildir-shortcuts
;;     '( (:maildir "/INBOX"              :key ?i)
;;        (:maildir "/[Gmail].E-mails enviados"  :key ?s)
;;        (:maildir "/[Gmail].Lixeira"      :key ?t)
;;        (:maildir "/[Gmail].Todos e-mails"   :key ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
   user-mail-address "seankuchida@gmail.com"
   user-full-name  "Sean K. Uchida"
   mu4e-compose-signature
    (concat
      "Sean K. Uchida\n"
      "http://seanvert.github.io\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "seankuchida@gmail.com" nil))
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(use-package frames-only-mode)
(frames-only-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package multi-term)
(setq multi-term-program "/bin/bash")

(use-package which-key)
(which-key-mode 1)
;; (setq which-key-popup-type 'minibuffer)
(setq which-key-popup-type 'side-window)
(setq which-key-side-window-max-height 0.33)

(use-package helm-bibtex
  :custom
  (bibtex-completion-bibliography '("/home/sean/Minha biblioteca.bib"))
  (reftex-default-bibliography '("//home/sean/Minha biblioteca.bib"))
  (bibtex-completion-notes-path "/ubuntu/home/sean/")
  (bibtex-completion-pdf-field "file")
  (bibtex-completion-notes-template-multiple-files
  (concat
   "#+TITLE: ${title}\n"
   "#+ROAM_KEY: cite:${=key=}\n"
   "* TODO Notes\n"
   ":PROPERTIES:\n"
   ":Custom_ID: ${=key=}\n"
   ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
   ":AUTHOR: ${author-abbrev}\n"
   ":JOURNAL: ${journaltitle}\n"
   ":DATE: ${date}\n"
   ":YEAR: ${year}\n"
   ":DOI: ${doi}\n"
   ":URL: ${url}\n"
   ":END:\n\n"
   ))
)
(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
		  ;; changed this
		  ;; helm-completion-in-region-fuzzy-match t
		  helm-completion-style 'emacs
		  helm-ff-auto-update-initial-value nil
		  helm-split-window-inside-p t
          helm-quick-update t
		  ;; helm-mode-fuzzy-match t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)))

(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

(use-package helm-swoop)
()
(use-package helm-c-yasnippet)
(use-package helm-org-rifle)

(global-set-key (kbd "C-s") 'helm-occur)

(use-package hydra)

(use-package god-mode
  :config
  (define-key god-local-mode-map (kbd "i") 'god-local-mode)
  (global-set-key (kbd "<escape>") 'god-local-mode))

(god-mode-all)
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; depende do espeak
(defun espeak (text)
  "Speaks text by espeak"
  (save-window-excursion
    (let* ((amplitude 100)
           (voice 'brazil)
           (command (format "espeak -a %s -v %s \"%s\"" amplitude voice text)))
      (async-shell-command command "*Messages*" "*Messages*"))))

(desktop-save-mode 1)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq org-enable-org-journal-support t)
(add-to-list 'org-modules 'org-tempo t)
;; não sei porque mas os módulos do org-plus-contrib precisam ser usados com require
(require 'org-habit)
(require 'org-tempo)
;; TODO este pedaço não está funcionando
(setq org-startup-folded 'content) ;; default t)
(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-entry))

(use-package org-ref
    :config
    (setq
         org-ref-completion-library 'org-ref-helm-insert-cite
         org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
         org-ref-default-bibliography (list "/home/sean/Minha biblioteca.bib")
         org-ref-bibliography-notes "/ubuntu/home/sean/biblio.org"
         org-ref-note-title-format "* PRA FAZER %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
         org-ref-notes-directory "/ubuntu/home/sean/"
         org-ref-notes-function 'orb-edit-notes))

(use-package org-download
  :custom
  (org-download-screenshot-method "gnome-screenshot")
  (org-download-image-dir "./assets/images"))
(use-package html-to-markdown)

(use-package auto-org-md)
(setq org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

(use-package org-noter
  :config
  (setq org-noter-auto-save-last-location t
		org-noter-notes-window-behavior '(start scroll)
		org-noter-hide-other nil
		;; abrir em outra janela
		org-noter-notes-window-location 'other-frame
		;; org-noter-notes-window-location 'horizontal-split
		org-noter-separate-notes-from-heading t)

  (defun org-noter-init-pdf-view ()
	(pdf-view-fit-page-to-window))
;;	(pdf-view-auto-slice-minor-mode)
	;; (run-at-time "0.5 sec" nil #'org-noter))

  (add-hook 'pdf-view-mode-hook 'org-noter-init-pdf-view)) 
;;TODO: fazer um esquema de screen shot com o flameshot
(defun org-noter-insert-image-slice-note (event &optional switch-back)
  (interactive "@e")
  )
(define-key org-noter-doc-mode-map [C-M-down-mouse-1] 'org-noter-insert-pdf-slice-note)
(defun org-noter-insert-pdf-slice-note (event &optional switch-back)
  (interactive "@e")
  (setq current-b (buffer-name))
  (progn  (pdf-view-mouse-set-region-rectangle event)
		  (pdf-view-extract-region-image pdf-view-active-region
										 (pdf-view-current-page)
										 (pdf-view-image-size)
										 (get-buffer-create "teste")
										 t)
		  (set-buffer "teste")
		  (write-file "/tmp/screenshot.png" nil)
		  (kill-buffer "screenshot.png")
		  (set-buffer current-b)
		  (org-noter-insert-note)
		  (org-download-screenshot)
		  (if switch-back			 
			  (switch-to-buffer-other-frame current-b))))

(define-key org-noter-doc-mode-map [C-M-down-mouse-1] 'org-noter-insert-pdf-slice-note)

(defun org-noter-insert-selected-text-inside-note-content ()
  (interactive)
  (async-start
     (progn (setq currenb (buffer-name))
		 (org-noter-insert-precise-note)
		 (set-buffer currenb)
		 (org-noter-insert-note))
   	 (shell-command "xdotool key --clearmodifiers super+Tab") ;; plays nice with frames-only-mode
	 ))

(define-key org-noter-doc-mode-map (kbd "q") 'org-noter-insert-selected-text-inside-note-content)

(defun org-noter-insert-note-and-change-window-back ()
  "Integrates org-noter better with frames-only-mode"
  (interactive)
  (async-start (org-noter-insert-note)
			   (shell-command "xdotool key --clearmodifiers super+Tab")))

(define-key org-noter-doc-mode-map (kbd "t") 'org-noter-insert-note-and-change-window-back)

;; TODO colocar os arquivos direitinho nesse negócio
(setq org-agenda-files '("~/.emacs.d/config.org"))
;;                         "/ubuntu/home/sean"
;;						 "/ubuntu/home/sean/web"))

(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-startup-indented t
	  org-ellipsis "";; " ⤵" ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers nil       ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-special-ctrl-a/e t)

(use-package org-pomodoro)
;; duração
(setq org-pomodoro-length 50)
;; duração dos intervalos curtos
(setq org-pomodoro-short-break-length 10)
;;duração dos intervalos longos
(setq org-pomodoro-long-break-length 20)
;; frequência dos intervalos longos
(setq org-pomodoro-long-break-frequency 3)

(setq org-pomodoro-audio-player "mplayer")

(setq org-pomodoro-finished-sound-args "-volume 0.4")
(setq org-pomodoro-long-break-sound-args "-volume 0.4")
(setq org-pomodoro-short-break-sound-args "-volume 0.4")

;; acho que não tem necessidade de usar essa função
(defun hhmmtomm (time)
  "converts hh:mm formated time string to minutes int"
  (if time
   (if (= 4 (length time))
	   (+ (* (string-to-number (substring time 0 1)) 60)
		  (string-to-number (substring time 2)))
	   (+ (* (string-to-number (substring time 0 2)) 60)
		  (string-to-number (substring time 3))))
   0))

(defun speak-current-task ()
  "function that says the name out loud"
  (espeak org-clock-current-task))

(display-time)
(defun esf/org-clocking-info-to-file ()
  (with-temp-file "/tmp/clocking"
    ;; (message (org-clock-get-clock-string))
    (if (org-clock-is-active)
        (insert (format "\ue003 %s: %d (%d->%d) min %d cd"
						org-clock-heading
                        (- (org-clock-get-clocked-time) org-clock-total-time)
                        org-clock-total-time
                        (org-clock-get-clocked-time)  ;; all time total
						;; FIX ME fazer isso usando funções nativas do emacs lisp
						(- (hhmmtomm org-clock-effort)
						   (- (org-clock-get-clocked-time)
							  org-clock-total-time))))))) ;;(org-clock-get-clock-string)
(esf/org-clocking-info-to-file)
(add-hook 'org-clock-in 'esf/org-clocking-info-to-file)
(add-hook 'org-clock-in-prepare-hook 'esf/org-clocking-info-to-file)
(add-hook 'display-time-hook 'esf/org-clocking-info-to-file)

(setq org-use-speed-commands 1)

;; org refiling pra mandar as tarefas de um arquivo pra outro
(setq org-refile-targets (quote (;;("~/semana.org" :maxlevel . 1)
								 ;;("~/notes_accomplished.org" :maxlevel . 1)
								 ;;("~/vest/vestibular.org" :maxlevel . 1)
								 ;; ("~/done.org" :maxlevel . 1) 
								 ;; ("~/ossu/ossu.org" :maxlevel . 1)
								 ("/ubuntu/home/sean/anki.org" :maxlevel . 1))))

(setq org-capture-templates
      '(;;		Org-capture anki templates
		("j" "Japanese basic"
		 entry
		 (file+headline org-my-anki-file "Dispatch Shelf")
		 "* %<%H:%M:%S>   :japones:\n :PROPERTIES:\n :ANKI_NOTE_TYPE: Japanese (recognition&recall)\n :ANKI_DECK: japones\n :END:\n** Expression\n%x\n** Meaning\n%?\n** Reading\n%x\n** Kanji\n\n** Diagram\n\n** Imagem \n\n** Audio \n\n** ref\n\n")
		;; TODO adicionar um outro pra francês, alemão e russo
		("c" "Cloze"
		 entry
		 (file+headline org-my-anki-file "Dispatch Shelf")
		 "* %<%H:%M:%S>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x%?\n** Extra\n")
		("a" "Anki cloze"
		 entry
		 (file+headline org-my-anki-file "Dispatch Shelf")
		 "* %<%H:%M:%S>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x\n** Extra\n")
		;; TODO não está funcionando
		("i" "Image cloze"
		 entry
		 (file+headline org-my-anki-file "Dispatch shelf")
		 "* %<%H:%M:%S>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Image\n:ANKI_DECK: Mega\n:END:\n** Descrição\n%?\n** Imagem\n\n** Comentários\n")))

(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))
(setq org-startup-with-inline-images t)
(add-hook
 'org-babel-after-execute-hook
 (lambda ()
   (when org-inline-image-overlays
     (org-redisplay-inline-images))))

;; todo states
(setq org-todo-keywords '((sequence "PRA FAZER(t)" "ESPERANDO(e)" "NÃO ENTENDI(n)" "REVER(r)" "|" "PRONTO(p)" "CANCELADO(c)")))

(use-package hl-todo
  :custom
  ;; Better hl-todo colors, taken from spacemacs
  (hl-todo-keyword-faces '(("TODO" . "#dc752f")
                           ("NEXT" . "#dc752f")
                           ("THEM" . "#2d9574")
                           ("PROG" . "#4f97d7")
                           ("OKAY" . "#4f97d7")
                           ("DONT" . "#f2241f")
                           ("FAIL" . "#f2241f")
                           ("DONE" . "#86dc2f")
                           ("NOTE" . "#b1951d")
                           ("KLUDGE" . "#b1951d")
                           ("HACK" . "#b1951d")
                           ("TEMP" . "#b1951d")
                           ("QUESTION" . "#b1951d")
                           ("HOLD" . "#dc752f")
                           ("FIXME" . "#dc752f")
                           ("XXX+" . "#dc752f")))
  :config
  (global-hl-todo-mode))

(use-package ob-sml)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure    . t)
   (dot        . t)
   (shell      . t)
   (C          . t)
   ;;(cpp        . t)
   (sml        . t)
   (haskell    . t)
   (scheme     . t)
   (sml        . t)
   (python     . t)
   (ocaml      . t)
   (emacs-lisp . t)
   (plantuml   . t)
   (js         . t)
   (octave     . t)
   (R          . t)
   (ruby       . t)))

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
	  org-src-preserve-indentation nil
	  org-edit-src-content-indentation 0)

(use-package ox-epub)
(use-package ox-reveal)

(add-hook 'prog-mode-hook (lambda () (progn (linum-relative-mode 1)
									   (smartparens-mode 1)
									   (rainbow-delimiters-mode 1))))

(use-package 
  markdown-mode 
  :commands (markdown-mode gfm-mode)
  ;; github flavor markdown
  :mode (("README\\.md\\'" . gfm-mode) 
	 ("\\.md\\'" . markdown-mode) 
	 ("\\.markdown\\'" . markdown-mode)) 
  :init (setq markdown-command "multimarkdown"))

(use-package magit)
(setq magit-refresh-status-buffer nil)
(setq auto-revert-buffer-list-filter
      'magit-auto-revert-repository-buffer-p)
(remove-hook 'server-switch-hook 'magit-commit-diff)

(use-package company
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers t)
)

;; global company mode
(add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-other-buffers t)

(use-package company-math)

;; (use-package company-box
;;   :hook (company-mode . company-box-mode)
;;   :config
;;   (setq company-box-doc-delay 0.3)
;;   (setq company-box-enable-icon nil)
;;   (setq company-box-color-icon nil))

(eval-after-load 'company
  '(define-key company-active-map (kbd "C-n") #'company-select-next-or-abort))
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort))

;; (let ((bg (face-attribute 'default :background)))
;;     (custom-set-faces
;;      `(company-tooltip ((t (:inherit default :background ,bg))))
;;      `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;      `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;      `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;      `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

(use-package company-org-roam
  :requires company
  :after org-roam
  :config
(push 'company-org-roam company-backends)
)


  ;; (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev))

(setq-default tab-width 4)

(use-package cider)

(use-package web-mode
  :custom
  (css-indent-offset 2)
  ;;(web-mode-markup-indent-offset 2)
  (web-mode-enable-auto-indentation nil)
  (web-mode-enable-auto-pairing nil)
  (web-mode-engines-alist '(("django" . "\\.html\\'")))
  :mode ;; Copied from spacemacs
  (("\\.phtml\\'"      . web-mode)
   ("\\.tpl\\.php\\'"  . web-mode)
   ("\\.twig\\'"       . web-mode)
   ("\\.xml\\'"        . web-mode)
   ("\\.html\\'"       . web-mode)
   ("\\.htm\\'"        . web-mode)
   ("\\.[gj]sp\\'"     . web-mode)
   ("\\.as[cp]x?\\'"   . web-mode)
   ("\\.eex\\'"        . web-mode)
   ("\\.erb\\'"        . web-mode)
   ("\\.mustache\\'"   . web-mode)
   ("\\.handlebars\\'" . web-mode)
   ("\\.hbs\\'"        . web-mode)
   ("\\.eco\\'"        . web-mode)
   ("\\.ejs\\'"        . web-mode)
   ("\\.svelte\\'"     . web-mode)
   ("\\.djhtml\\'"     . web-mode))
  ;; :hook
  ;; (web-mode . tree-sitter-hl-mode)
  ;; (web-mode . (lambda () (fk/add-local-hook 'before-save-hook 'fk/indent-buffer)))
  )

(use-package emmet-mode
  :custom
  (emmet-move-cursor-between-quotes t)
  :custom-face
  (emmet-preview-input ((t (:inherit lazy-highlight))))
  :bind
  (
   :map emmet-mode-keymap
   ([remap yas-expand] . emmet-expand-line)
   ("M-n"  . emmet-next-edit-point)
   ("M-p"  . emmet-prev-edit-point)
   ("C-c p" . emmet-preview-mode))
  :hook
  ;;(rjsx-mode . (lambda () (setq emmet-expand-jsx-className? t)))
  (web-mode . emmet-mode)
  (css-mode . emmet-mode))

(use-package nodejs-repl)

(use-package prettier-js
  :hook
  ;;(web-mode . prettier-js-mode) ;; breaks django templates
  (css-mode . prettier-js-mode)
  (json-mode . prettier-js-mode))

(use-package yasnippet
  :config
  (defun mars/company-backend-with-yas (backends)
      "Add :with company-yasnippet to company BACKENDS.
Taken from https://github.com/syl20bnr/spacemacs/pull/179."
      (if (and (listp backends) (memq 'company-yasnippet backends))
	  backends
	(append (if (consp backends)
		    backends
		  (list backends))
		'(:with company-yasnippet))))
    ;; add yasnippet to all backends
  (setq company-backends
		(mapcar #'mars/company-backend-with-yas company-backends))
  (yas-global-mode 1))

(use-package auto-yasnippet
  :config
  (global-set-key (kbd "C-,") #'aya-create)
  (global-set-key (kbd "C-.") #'aya-expand))

(use-package yasnippet-snippets
  :config
  (setq yas-snippet-dirs '("/home/sean/.emacs.d/snippets"
						   yasnippet-snippets-dir)))

(use-package haskell-mode)
(setq haskell-process-type 'stack-ghci)
(use-package company-ghci)
(use-package hindent)

(use-package projectile
  :pin melpa-stable
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(setq projectile-use-git-grep t)

(setq created-property "
  :PROPERTIES:
  :CREATED: %U
  :END:")

(use-package org-projectile
  :bind ("C-c n p" . org-projectile-project-todo-completing-read)
  :config
  (progn
	(org-projectile-per-project)
	(setq org-projectile-per-project-filepath "my_project_todo_filename.org")
    (setq org-projectile-projects-file "/home/sean/projetos.org"
          org-projectile-capture-template
          (format "%s%s" "* TODO %? %A\n" created-property))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "l"
                  :capture-heading "Linked Project TODO"))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "p"))
    (setq org-confirm-elisp-link-function nil)
	(setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))))

(use-package helm-dash
  :config
   (setq helm-dash-common-docsets '("Python_3" "Standard ML"))
   (setq helm-dash-browser-func 'browse-url))

(use-package rustic)

(add-to-list 'auto-mode-alist '("\\.m" . octave-mode))

(use-package lsp-mode
  ;; :hook (prog-mode . lsp)
  :config
  (setq lsp-idle-delay 0.500))

;;(use-package lsp-ui)

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(add-hook 'python-mode-hook
		  (lambda () (setq tab-width 4
					  python-indent-offset 4)))

(use-package lsp-pyright
  :ensure t)
  ;; :hook (python-mode . (lambda ()
  ;;                         (require 'lsp-pyright)
  ;;                         (lsp))))

(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
			'(lambda ()
			   (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(use-package sml-mode)

(use-package howdoyou)

(with-eval-after-load "helm-net"
  (push (cons "How Do You"  (lambda (candidate) (howdoyou-query candidate)))
        helm-google-suggest-actions))
