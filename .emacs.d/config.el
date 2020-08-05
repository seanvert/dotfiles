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

;;(server-start)
(if (and (fboundp 'server-running-p)
 		 (not (server-running-p)))
 	(server-start)
 1)

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

(require 'iso-transl)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; (use-package ewal
;;   :init (setq ewal-use-built-in-always-p t
;;               ewal-use-built-in-on-failure-p nil
;;               ewal-built-in-palette "hybrid-material"))

;; (use-package ewal-spacemacs-themes
;;   :init (progn
;;           (setq spacemacs-theme-underline-parens t
;;                 my:rice:font (font-spec
;;                               :family "Iosevka"
;;                               :weight 'semi-bold
;;                               :size 11.0))
;;           (show-paren-mode +1)
;;           (global-hl-line-mode)
;;           (set-frame-font my:rice:font nil t)
;;           (add-to-list  'default-frame-alist
;;                         `(font . ,(font-xlfd-name my:rice:font))))
;;   :config (progn
;;             (load-theme 'ewal-spacemacs-modern t)
;;             (enable-theme 'ewal-spacemacs-modern)))

(visual-line-mode t)

;;(use-package cyberpunk-theme)
(use-package spaceline
  :after (winum)
  :init (setq powerline-default-separator nil)
  :config (spaceline-spacemacs-theme))
;; highlight lines
(global-hl-line-mode)
;; eink theme
;; (use-package eink-theme)
(use-package solarized-theme)
(load-theme 'solarized-light-high-contrast t)
;;(use-package zenburn-theme)
;;(use-package monokai-theme)
;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvb-light-hard t))
;; 
;; (set-face-attribute 'default nil :family "Iosevka" :height 130)
;; (set-face-attribute 'fixed-pitch nil :family "Sans Serif")
;; (set-face-attribute 'variable-pitch nil :family "Baskerville")

(scroll-bar-mode -1)
(setq scroll-step            1
      scroll-conservatively  10000)
(tool-bar-mode -1)
(menu-bar-mode -1)

(use-package writeroom-mode)
(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))
(setq writeroom-width 120)

;;(powerline-default-theme)

(setq-default mode-line-buffer-identification (list -40 (propertized-buffer-identification "%12b")))

(global-prettify-symbols-mode 1)

;;(use-package all-the-icons)

;; (use-package mode-icons
;;    :after all-the-icons
;;    :config
;;    (mode-icons-mode))

(defvar user-temporary-file-directory "~/.emacs-autosaves/")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . ,user-temporary-file-directory) 
			       (tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))

(setq
   org_notes "/ubuntu/home/sean/" ;; (concat (getenv "HOME") "/Git/Gitlab/Mine/Notes/")
   zot_bib (concat (getenv "HOME") "/Minha biblioteca.bib")
   org-directory org_notes
   deft-directory org_notes
   org-roam-directory org_notes
   )

(add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
(use-package pdf-view-restore)
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
  (setq image-cache-eviction-delay 30)
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

;; (defun org-noter-insert-selected-text-inside-note-content ()
;;   (interactive)
;;   (progn (setq currenb (buffer-name))
;; 		 (org-noter-insert-precise-note)
;; 		 (set-buffer currenb)
;; 		 (org-noter-insert-note)))


;; (define-key pdf-view-mode-map (kbd "y") 'org-noter-insert-selected-text-inside-note-content)

;; (define-key flyspell-mode-map (kbd "C-,") #'flyspell-goto-next-error)

(use-package try)

(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; (setq visual-fill-column-center-text t)
;; (setq nov-text-width t)
;;(setq nov-text-width 50)
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

;; (use-package leetcode)
;; (setq leetcode-prefer-language "python3")
;; (setq leetcode-prefer-sql "mysql")

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
;; (use-package zetteldeft
;;    :after deft
;;    :config
;;    (zetteldeft-set-classic-keybindings))

(use-package linum-relative)
(column-number-mode 1)
(setq linum-relative-current-symbol "")

(use-package rainbow-delimiters)

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

(use-package pandoc-mode)
(use-package pandoc)

(use-package frames-only-mode)
(frames-only-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package multi-term)

(use-package which-key)
(which-key-mode 1)

;; (setq which-key-popup-type 'minibuffer)
(setq which-key-popup-type 'side-window)
(setq which-key-side-window-max-height 0.33)

(edit-server-start)

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
(use-package helm-c-yasnippet)
(use-package helm-cider)
(use-package helm-org-rifle)

(global-set-key (kbd "C-s") 'helm-occur)

(use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
;; changed this 
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

(use-package org-pretty-tags)
(use-package org-ref
    :config
    (setq
         org-ref-completion-library 'org-ref-ivy-cite
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
(use-package ox-jekyll-md)
(use-package ox-epub)
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

(define-key pdf-view-mode-map [C-M-down-mouse-1] 'org-noter-insert-pdf-slice-note)

;; org-agenda load na pasta do emacs

;; TODO colocar os arquivos direitinho nesse negócio
(setq org-agenda-files '("~/.emacs.d/config.org"
                         "/ubuntu/home/sean"))

;;						 "~/vest/"))
;;						 "~/vest/vestibular.org"


(global-set-key (kbd "C-c a") 'org-agenda)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;(add-hook 'org-mode-hook (lambda () (writeroom-mode 1)))

(setq org-startup-with-inline-images t)
(add-hook
 'org-babel-after-execute-hook
 (lambda ()
   (when org-inline-image-overlays
     (org-redisplay-inline-images))))
;; todo states
;; (setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✓ PRONTO(p)")
;;                           (sequence "⚑ ESPERANDO(e)" "|")
;;                           (sequence "|" "✘ CANCELADO(c)")))
(setq org-todo-keywords '((sequence "PRA FAZER(t)" "ESPERANDO(e)" "NÃO ENTENDI(n)" "REVER(r)" "|" "PRONTO(p)" "CANCELADO(c)")))

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))

(use-package org-bullets)

(setq org-startup-indented t
	  ;; depende do pacote org-bullets
      org-bullets-bullet-list '("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
	  org-ellipsis "";; " ⤵" ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers nil       ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-special-ctrl-a/e t)

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


(use-package company-org-roam
  :after org-roam
  :config
(push 'company-org-roam company-backends)
)
  ;; (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev))

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
						(- (hhmmtomm org-clock-effort)
						   (- (org-clock-get-clocked-time)
							  org-clock-total-time))))))) ;;(org-clock-get-clock-string)
(esf/org-clocking-info-to-file)
(add-hook 'org-clock-in 'esf/org-clocking-info-to-file)
(add-hook 'org-clock-in-prepare-hook 'esf/org-clocking-info-to-file)
(add-hook 'display-time-hook 'esf/org-clocking-info-to-file)

(setq org-use-speed-commands 1)

(defun my/insert-text-after-heading (text)
  "Insert TEXT after every heading in the file, skipping property drawers."
  (interactive "sText to insert: ")

  ;; The Org Element API provides functions that allow you to map over all
  ;; elements of a particular type and perform modifications. However, as
  ;; as soon as the buffer is modified the parsed data becomes out of date.
  ;;
  ;; Instead, we treat the buffer as text and use other org-element-*
  ;; functions to parse out important data.

  ;; Use save-excursion so the user's point is not disturbed when this code
  ;; moves it around.
  (save-excursion
    ;; Go to the beginning of the buffer.
    (goto-char (point-min))

    ;; Use save-match-data as the following code uses re-search-forward,
    ;; will disturb any regexp match data the user already has.
    (save-match-data

      ;; Search through the buffer looking for headings. The variable
      ;; org-heading-regexp is defined by org-mode to match anything
      ;; that looks like a valid Org heading.
      (while (re-search-forward org-heading-regexp nil t)

        ;; org-element-at-point returns a list of information about
        ;; the element the point is on. This includes a :contents-begin
        ;; property which is the buffer location of the first character
        ;; of the contents after this headline.
        ;;
        ;; Jump to that point.
        (goto-char (org-element-property :contents-begin (org-element-at-point)))

        ;; Point is now on the first character after the headline. Find out
        ;; what type of element is here using org-element-at-point.
        (let ((first-element (org-element-at-point)))

          ;; The first item in the list returned by org-element-at-point
          ;; says what type of element this is.  See
          ;; https://orgmode.org/worg/dev/org-element-api.html for details of
          ;; the different types.
          ;;
          ;; If this is a property drawer we need to skip over it. It will
          ;; an :end property containing the buffer location of the first
          ;; character after the property drawer. Go there if necessary.
          (when (eq 'property-drawer (car first-element))
            (goto-char (org-element-property :end first-element))))

      ;; Point is now after the heading, and if there was a property
      ;; drawer then it's after that too. Insert the requested text.
      (insert text "\n\n")))))

;; org refiling pra mandar as tarefas de um arquivo pra outro
(setq org-refile-targets (quote (;;("~/semana.org" :maxlevel . 1)
								 ;;("~/notes_accomplished.org" :maxlevel . 1)
								 ;;("~/vest/vestibular.org" :maxlevel . 1)
								 ;; ("~/done.org" :maxlevel . 1) 
								 ;; ("~/ossu/ossu.org" :maxlevel . 1)
								 ("/ubuntu/home/sean/anki.org" :maxlevel . 1)
)))

(setq org-capture-templates
      '(("t" "PRA FAZER" entry (file+headline "~/semana.org" "Tarefas")
	     "* PRA FAZER %^{Descrição breve} %^g \n \n %? \n Adicionado em: %U")
        ("c" "Checklist" entry (file+headline "~/semana.org" "Tarefas")
         "* PRA FAZER %^{Descrição breve} [/] %^g \n- [ ] %? \n Adicionado em: %U")
        ("p" "Programming TODO" entry (file+headline "~/semana.org" "projetos")
         "* PRA FAZER %^{Descrição breve} %^g \n %? \n link: %a \n Adicionado em: %U")
        ("n" "Programming Notes" entry (file+headline "~/ossu/prognotes.org" "notas")
         "* %^{Descrição} %^g \n %x \n")
        ("w" "Citações" entry (file+headline "~/lang/citações.org" "citações")
         "* %^{Descrição} %^gdrill: \n %x \n")
        ("i" "Info" entry (file+headline "~/Documents/emacs.org" "emacs")
         "* %^{Descrição} \n %? \n link: %a \n %:node")
        ("e" "emacs" entry (file+headline "~/Documents/emacs.org" "emacs")
         "* %^{Descrição}  %^g\n %x \n")
        ("j" "日本語" entry (file+headline "~/lang/lang.org" "文法[ぶんぽう]")
         "* %^{Descrição da gramática}\n %? \n")
        ("l" "links internet clipboard" entry (file+headline "~/Desktop/links.org" "links")
         "* %^{Descrição} \n [%x] \n %")
        ("a" "livros/artigos" entry (file+headline "~/Documents/livros.org" "livros")
         "* %^{Título} %^g :referência: \n :PROPERTIES: \n Criado em: %U \n Link: %a \
 \n :END: \n %i \n Descrição:\n %?"
         :prepend t
         :empty-lines 1
         :created t)
		;; Org-capture anki templates
		("b" "Anki basic"
		 entry
		 (file+headline org-my-anki-file "Dispatch Shelf")
		 "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** Back\n%x\n")
		("B" "Anki cloze"
		 entry
		 (file+headline org-my-anki-file "Dispatch Shelf")
		 "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x\n** Extra\n")
		))

(global-set-key (kbd "C-c c") 'org-capture)



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

(use-package org-ref)

(use-package ox-reveal)

;; (require 'org-drill)

(add-hook 'prog-mode-hook (lambda () (progn (linum-relative-mode 1)
									   (smartparens-mode 1)
									   (rainbow-delimiters-mode 1))))

(use-package lsp-ui
  :ensure t
  :requires lsp-mode flycheck
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
		lsp-ui-doc-use-childframe t
		lsp-ui-doc-position 'top
		lsp-ui-doc-include-signature t
		lsp-ui-sideline-enable nil
		lsp-ui-flycheck-enable t
		lsp-ui-flycheck-list-position 'right
		lsp-ui-flycheck-live-reporting t
		lsp-ui-peek-enable t
		lsp-ui-peek-list-width 60
		lsp-ui-peek-peek-height 25))

(use-package company-lsp
  :requires company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)
(use-package helm-lsp
  :after helm
  :commands helm-lsp-workspace-symbol
  :config
  (defun netrom/helm-lsp-workspace-symbol-at-point ()
	(interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))
  
  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))


(use-package dap-mode)
;;(use-package lsp-python)
;;(use-package lsp-clangd)

(use-package lsp-mode
  :requires hydra helm helm-lsp
  :commands (lsp lsp-deferred)
  :hook (haskell-mode . lsp)
  :config
(setq lsp-diagnostic-package nil
;; changed this 
;; lsp-prefer-flymake nil
		netrom--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        netrom--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")))
   ;; Create general hydra.
   (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
			,@(append
			   netrom--general-lsp-hydra-heads
			   netrom--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body))))

(use-package cider)

;; (use-package arduino-mode)

(use-package 
  markdown-mode 
  :commands (markdown-mode gfm-mode)
  ;; github flavor markdown
  :mode (("README\\.md\\'" . gfm-mode) 
	 ("\\.md\\'" . markdown-mode) 
	 ("\\.markdown\\'" . markdown-mode)) 
  :init (setq markdown-command "multimarkdown"))

(use-package flycheck)
  ;; :ensure t)
  ;; :init
  ;; (add-hook 'prog-mode-hook 'flycheck-mode))
  ;;(global-flycheck-mode t))
(use-package flycheck-irony)
(use-package flycheck-haskell)
(use-package flycheck-pycheckers)
(use-package flycheck-plantuml)
(use-package flycheck-cask)

(use-package magit)

(use-package company
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; global company mode
(add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-other-buffers t)

(use-package company-math)
(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-doc-delay 0.3)
  (setq company-box-enable-icon t))

(eval-after-load 'company
  '(define-key company-active-map (kbd "C-n") #'company-select-next-or-abort))
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort))

(setq-default tab-width 4)

(use-package emmet-mode
:ensure t
:defer t
:mode ("\\.html\\'"
	   "\\.css\\'"
	   "\\.ejs\\'"))

(use-package css-mode
:ensure t
:defer t
:mode "\\.css\\'")

(unless (package-installed-p 'indium)
  (use-package indium))
(setq indium-chrome-executable "google-chrome-stable")

(use-package json-mode
:ensure t
:defer t)
(use-package typescript-mode
:ensure t
:defer t)
(use-package js2-mode
:mode ("\\.js\\'" . js2-mode)
:ensure t
:defer t)
(use-package web-mode
:ensure t
:defer t
:mode ("\\.html\\'"
 ;; "\\.css\\'"
 "\\.php\\'"
 "\\.ejs\\'"))

(setq web-mode-enable-current-column-highlight t
	  web-mode-enable-current-element-highlight t)
(add-hook 'web-mode-hook 'emmet-mode)
(setq emmet-move-cursor-between-quotes t)

(add-hook 'web-mode-before-auto-complete-hooks
    '(lambda ()
     (let ((web-mode-cur-language
  	    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
    	   (yas-activate-extra-mode 'php-mode)
      	 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
    	   (setq emmet-use-css-transform t)
      	 (setq emmet-use-css-transform nil)))))

;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)))
;; (defun setup-tide-mode ()
;;   "Setup function for tide."
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1))

;; (setq company-tooltip-align-annotations t)

;; (setq flycheck-javascript-standard-executable "/home/sean/.npm-global/bin/standardx")
;; (use-package prettier-js)
;; ;; TODO ver isso direto depois
;; ;; https://github.com/ananthakumaran/tide/tree/c6b86277f1c7d3d04c07d93a6cf49378225da5a2
;; (setq tide-format-options '(
;; 							:insertSpaceAfterFunctionKeywordForAnonymousFunctions t
;; :placeOpenBraceOnNewLineForFunctions nil
;; :tabSize: 4
;; :indentSize 4
;; ))



;; (add-hook 'js-mode-hook #'setup-tide-mode)
;; (add-hook 'js-mode-hook 'prettier-js-mode)

;; (setq prettier-js-args '(
;;   "--trailing-comma" "none"
;;   "--bracket-spacing" "true"
;;   "--single-quote" "true"
;;   "--no-semi" "true"
;;   "--jsx-single-quote" "true"
;;   "--jsx-bracket-same-line" "true"
;;   "--print-width" "100"))

(use-package restclient)

;; (global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
;; (global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
;; (global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
;; (global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)



(use-package yasnippet)
(use-package auto-yasnippet
  :config
  (global-set-key (kbd "C-,") #'aya-create)
  (global-set-key (kbd "C-.") #'aya-expand))
(use-package yasnippet-snippets
  :config
  (setq yas-snippet-dirs '("/home/sean/.emacs.d/snippets" yasnippet-snippets-dir "/home/sean/.emacs.d/elpa/haskell-snippets-20160919.22/snippets")))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(setq projectile-use-git-grep t)

(use-package helm-dash
  :config
   (setq helm-dash-common-docsets '("Python_3" "Standard ML"))
   (setq helm-dash-browser-func 'browse-url))

(add-to-list 'auto-mode-alist '("\\.m" . octave-mode))

(use-package company-irony)

(use-package company-anaconda)

(add-hook 'python-mode-hook
		  (lambda () (setq tab-width 4
					  python-indent-offset 4)))

(use-package django-mode)
;; (yas/load-directory "/home/sean/.emacs.d/elpa/django-mode-20170522.714/snippets")
;; (add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))

(use-package haskell-snippets)
(use-package company-ghci)
(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-process-path-hie "ghcide")
  (setq lsp-haskell-process-args-hie '()))

(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(use-package sml-mode)

(use-package ess)
(use-package ess-smart-underscore)

(use-package howdoyou)

(with-eval-after-load "helm-net"
  (push (cons "How Do You"  (lambda (candidate) (howdoyou-query candidate)))
        helm-google-suggest-actions))
