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

(server-start)

(use-package monokai-theme)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(global-prettify-symbols-mode 1)

(use-package all-the-icons)

(use-package nyan-mode)
(nyan-mode 1)

(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
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

(use-package try)

(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq nov-text-width 80)

(use-package smartparens)

(use-package leetcode)
(setq leetcode-prefer-language "python3")
(setq leetcode-prefer-sql "mysql")

(use-package linum-relative)
(setq linum-relative-current-symbol "")

(use-package rainbow-delimiters)

(use-package gif-screencast)
(use-package keycast)
;;(setq keycast-insert-after "%e")

;;(setq mode-line-format mode-line-keycast)

(use-package undo-tree)

(use-package frames-only-mode)
(frames-only-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package which-key)
(which-key-mode 1)

;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

(use-package helm-bibtex)
(use-package helm-company)
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
          helm-quick-update t
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

(global-set-key (kbd "C-s") 'helm-occur)

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


(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)

(setq org-enable-org-journal-support t)
(add-to-list 'org-modules 'org-tempo t)
;; não sei porque mas os módulos do org-plus-contrib precisam ser usados com require
(require 'org-tempo)
(use-package org-journal)
(use-package org-noter)
(use-package org-pretty-tags)
(use-package org-ref)
(use-package org-pomodoro)
(use-package org-download)
(use-package html-to-markdown)
(use-package ox-jekyll-md)
(use-package ox-epub)
(use-package auto-org-md)
(setq org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")



;; org-agenda load na pasta do emacs
;; TODO colocar os arquivos direitinho nesse negócio
(setq org-agenda-files '("~/Desktop/"
						 "~/vest/vestibular.org"
						 "~/ossu/ossu.org"
						 "~/semana.org"
						 "~/lang/lang.org"
						 "~/Documents/livros.org"
						 "~/Documents/"
						 "~/vest/"
						 "~/Documents/journal"))

;; org refiling pra mandar as tarefas de um arquivo pra outro
(setq org-refile-targets (quote (("~/semana.org" :maxlevel . 1)
								 ("~/notes_accomplished.org" :maxlevel . 1)
								 ("/vest/vestibular.org" :maxlevel . 1)
								 ("~/ossu/ossu.org" :maxlevel . 1))))

(global-set-key (kbd "C-c a") 'org-agenda)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; todo states
(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✓ PRONTO(p)")
                          (sequence "⚑ ESPERANDO(e)" "|")
                          (sequence "|" "✘ CANCELADO(c)")))

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))

(use-package org-bullets)

(setq org-startup-indented t
      org-bullets-bullet-list '("一" "二" "三" "四" "五" "六" "七" "八" "九" "十");; no bullets, needs org-bullets package
	  ;;      org-ellipsis " ⤵" ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers t
      ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-special-ctrl-a/e t)

(shell-command "mkfifo /tmp/.todo-pipe") 

(defun write-todo-pipe-esperando ()
  "writes down esperando message in the todo pipe"
  (write-region "Esperando <fc=#af3a03,#f9f5d7>\xe0b0</fc>\n" 
				nil 
				"/tmp/.todo-pipe" 
				nil 
				'quiet))

(write-todo-pipe-esperando)

(defun write-todo-pipe ()
  "adds a pipe file with the pomodoro modeline, also reads the current task
       from org-clock."
  (write-region
   (concat "\ue003 "
           (org-pomodoro-format-seconds)
           " "
           org-clock-current-task
           " "
           "<fc=#af3a03,#f9f5d7>\xe0b0</fc>" "\n")
   nil "/tmp/.todo-pipe"
   nil 'quiet))

(defun speak-pomodoro ()
  "function that says the name out loud"
  (espeak org-clock-current-task))

(setq org-pomodoro-started-hook 'speak-pomodoro)

;; hook que adiciona a modeline no tick do pomodoro
(setq org-pomodoro-tick-hook 'write-todo-pipe)
;; hook que tira o que estava anteriormente e coloca o esperando
(setq org-pomodoro-finished-hook 'write-todo-pipe-esperando)
;; hook pra tirar a atividade se eu cancelar o pomodoro
(setq org-pomodoro-killed-hook 'write-todo-pipe-esperando)

;; o comando que cria o pipe está no org pomodoro
(defun write-clock-todo-pipe ()
  "escreve as coisas do org-clock no todo-pipe"
  (write-region (concat
                 (car (split-string org-mode-line-string))
                 " " org-clock-heading " "
                 "<fc=#af3a03,#f9f5d7>\xe0b0</fc>" "\n")
                nil "/tmp/.todo-pipe"
                nil 'quiet))

(setq org-clock-out-hook 'write-todo-pipe-esperando)
(setq org-clock-in-prepare-hook 'write-clock-todo-pipe)

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
         "* %^{Título} %^g :referência: \n :PROPERTIES: \n Criado em: %U \n Link: %a \n :END: \n %i \n Descrição:\n %?"
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

(use-package flycheck)
(use-package flycheck-irony)
(use-package flycheck-haskell)
(use-package flycheck-pycheckers)
(use-package flycheck-plantuml)
(use-package flycheck-cask)

(use-package magit)

(use-package company
  :config (add-hook 'prog-mode-hook 'company-mode))
;; global company mode
(global-company-mode 1)
(use-package company-math)
(use-package company-quickhelp)

(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(setq company-quickhelp-delay 1)

(setq-default tab-width 4)

(global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(use-package yasnippet)
(use-package yasnippet-classic-snippets)
(use-package yasnippet-snippets)

(use-package projectile)

(use-package helm-dash)

(add-to-list 'auto-mode-alist '("\\.m" . octave-mode))

(use-package company-irony)

(use-package company-anaconda)

(use-package ein)

(use-package haskell-snippets)
(use-package company-ghci)

(use-package sml-mode)

(use-package ess)
(use-package ess-smart-underscore)

(use-package howdoyou)
