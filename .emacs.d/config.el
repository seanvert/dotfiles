(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(require 'iso-transl)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(setq desktop-load-locked-desktop t)

(server-start)
;; (if (and (fboundp 'server-running-p)
;; 		 (not (server-running-p)))
;; 	(server-start)
;;   1)

(define-key key-translation-map (kbd "<f1>") (kbd "TAB"))
(define-key key-translation-map (kbd "<f2>") (kbd "("))
(define-key key-translation-map (kbd "<f5>") (kbd "+"))
(define-key key-translation-map (kbd "<f6>") (kbd "-"))
(define-key key-translation-map (kbd "<f7>") (kbd "="))
(define-key key-translation-map (kbd "<f8>") (kbd "_"))
(define-key key-translation-map (kbd "<f9>") (kbd "õ"))
(define-key key-translation-map (kbd "<f11>") (kbd "ã"))
(define-key key-translation-map (kbd "<C-f1>") (kbd "1"))
(define-key key-translation-map (kbd "<C-f2>") (kbd "2"))
(define-key key-translation-map (kbd "<C-f3>") (kbd "3"))
(define-key key-translation-map (kbd "<C-f4>") (kbd "4"))
(define-key key-translation-map (kbd "<C-f5>") (kbd "5"))
(define-key key-translation-map (kbd "<C-f6>") (kbd "6"))
(define-key key-translation-map (kbd "<C-f7>") (kbd "7"))
(define-key key-translation-map (kbd "<C-f8>") (kbd "8"))
(define-key key-translation-map (kbd "<C-f9>") (kbd "9"))

;;(use-package monokai-theme)
;;(use-package leuven-theme)
(use-package poet-theme)
(set-face-attribute 'default nil :family "Iosevka" :height 130)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Baskerville")

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(display-time-mode -1)

;;(powerline-default-theme)
(setq-default mode-line-buffer-identification (list -40 (propertized-buffer-identification "%12b")))

(global-prettify-symbols-mode 1)

(use-package all-the-icons)

(use-package nyan-mode)
(nyan-mode 1)

(add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
(use-package org-pdfview)

(use-package pdf-tools
  :pin manual ;; manually update
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
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete))

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
  "checks if we are going foward on non-read pages"
  (if (not (member (pdf-view-current-page) pdf-time-pages))
	  (setq pdf-time-pages (append (pdf-view-current-page)))))
;; TODO uma função que conta o tempo numa página
;; TODO uma outra função que estima o tempo final
;; TODO uma função que pega a última página como algo arbitrário para remover índices no final

(use-package try)

(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq nov-text-width 80)

(use-package smartparens)

(use-package leetcode)
(setq leetcode-prefer-language "python3")
(setq leetcode-prefer-sql "mysql")

(use-package linum-relative)
(column-number-mode 1)
(setq linum-relative-current-symbol "")

(use-package rainbow-delimiters)

(use-package gif-screencast)
(use-package keycast)
;;(setq keycast-insert-after "%e")
(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))
;;(setq mode-line-format mode-line-keycast)

(use-package undo-tree)

(use-package pandoc-mode)
(use-package pandoc)

(use-package frames-only-mode)
(frames-only-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package multi-term)

(use-package which-key)
(which-key-mode 1)

(use-package helm-bibtex)
(use-package helm-company
  :after company)
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
		  helm-completion-in-region-fuzzy-match t
          helm-quick-update t
		  helm-mode-fuzzy-match t
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

(use-package hydra)

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
(use-package org-journal)

(use-package org-pretty-tags)
(use-package org-ref)

(use-package org-download)
(use-package html-to-markdown)
(use-package ox-jekyll-md)
(use-package ox-epub)
(use-package auto-org-md)
(setq org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")

(use-package org-noter)

(setq org-noter-auto-save-last-location t)

;; This will try to find the respective notes file automatically. It
;; will search in all parent folders and some specific folders set
;; by you. See org-noter-default-notes-file-names and
;; org-noter-notes-search-path for more information.

(setq org-noter-notes-window-behavior '(start scroll))

(setq org-noter-notes-window-location 'other-frame)

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
(use-package idle-org-agenda
  :after org-agenda
  :ensure t
  :config (idle-org-agenda-mode))

(custom-set-variables
 '(idle-org-agenda-interval 300)
 '(idle-org-agenda-key "n")
 '(idle-org-agenda-mode t))

;; TODO colocar os arquivos direitinho nesse negócio
(setq org-agenda-files '("~/Desktop/"
						 "~/vest/vestibular.org"
						 "~/ossu/ossu.org"
						 "~/semana.org"
						 "~/lang/lang.org"
						 "~/Documents/livros.org"
						 "~/Documents/"
						 "~/vest/"))

;; org refiling pra mandar as tarefas de um arquivo pra outro
(setq org-refile-targets (quote (("~/semana.org" :maxlevel . 1)
								 ("~/notes_accomplished.org" :maxlevel . 1)
								 ("/vest/vestibular.org" :maxlevel . 1)
								 ("~/ossu/ossu.org" :maxlevel . 1))))

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
(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✓ PRONTO(p)")
                          (sequence "⚑ ESPERANDO(e)" "|")
                          (sequence "|" "✘ CANCELADO(c)")))

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))

(use-package org-bullets)

(setq org-startup-indented t
	  ;; depende do pacote org-bullets
      org-bullets-bullet-list '("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
	  org-ellipsis "";; " ⤵" ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers t
      ;; show actually italicized text instead of /italicized text/
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
        (insert (format "\ue003 %s: %d (%d->%d) min %d cd <fc=#af3a03,#f9f5d7>\xe0b0</fc>"
						org-clock-heading
                        (- (org-clock-get-clocked-time) org-clock-total-time)
                        org-clock-total-time
                        (org-clock-get-clocked-time)  ;; all time total
						(- (hhmmtomm org-clock-effort)
						   (- (org-clock-get-clocked-time)
							  org-clock-total-time))))))) ;;(org-clock-get-clock-string)
;;(esf/org-clocking-info-to-file)
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

(setq org-capture-templates
      '(("t" "☛ TODO" entry (file+headline "~/semana.org" "Tarefas")
	     "* ☛ TODO %^{Descrição breve} %^g \n \n %? \n Adicionado em: %U")
        ("c" "Checklist" entry (file+headline "~/semana.org" "Tarefas")
         "* ☛ TODO %^{Descrição breve} [/] %^g \n- [ ] %? \n Adicionado em: %U")
        ("p" "Programming TODO" entry (file+headline "~/semana.org" "projetos")
         "* ☛ TODO %^{Descrição breve} %^g \n %? \n link: %a \n Adicionado em: %U")
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
         :created t)))

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

(require 'org-drill)

(add-hook 'prog-mode-hook (lambda () (progn (linum-relative-mode 1)
											(smartparens-mode 1)
											(rainbow-delimiters-mode 1))))

(use-package lsp-ui
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
  :config
  ;; Create general hydra.
  (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
           ,@(append
              netrom--general-lsp-hydra-heads
              netrom--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body)))
  
  (setq lsp-prefer-flymake nil
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
          ("b" pop-tag-mark "Back"))))

(use-package cider)

(use-package arduino-mode)

(use-package flycheck)
(use-package flycheck-irony)
(use-package flycheck-haskell)
(use-package flycheck-pycheckers)
(use-package flycheck-plantuml)
(use-package flycheck-cask)

(use-package magit)

(use-package company
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-idle-delay 0.3))

;; global company mode
(global-company-mode 1)
(use-package company-math)
(use-package company-quickhelp)

(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-n") #'company-select-next-or-abort))
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort))

(setq company-quickhelp-delay 1)

(setq-default tab-width 4)

(global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)

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

(use-package helm-dash)

(add-to-list 'auto-mode-alist '("\\.m" . octave-mode))

(use-package company-irony)

(use-package company-anaconda)

(use-package ein)

(add-hook 'python-mode-hook
		  (lambda () (setq indent-tabs-mode nil
					  tab-width 4
					  python-indent-offset 4)))

(use-package haskell-snippets)
(use-package company-ghci)
(use-package intero)

(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(use-package sml-mode)

(use-package ess)
(use-package ess-smart-underscore)

(use-package howdoyou)

(with-eval-after-load "helm-net"
  (push (cons "How Do You"  (lambda (candidate) (howdoyou-query candidate)))
        helm-google-suggest-actions))
