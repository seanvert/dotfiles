;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a
;; lower value in your dotfile (function `dotspacemacs/user-config')
(setq gc-cons-threshold 100000000)
;; (setq inhibit-x-resources t)

(defconst spacemacs-version         "0.200.13" "Spacemacs version.")
(defconst spacemacs-emacs-min-version   "24.4" "Minimal version of Emacs.")

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (error (concat "Your version of Emacs (%s) is too old. "
                   "Spacemacs requires Emacs version %s or above.")
           emacs-version spacemacs-emacs-min-version)
  (load-file (concat (file-name-directory load-file-name)
                     "core/core-load-paths.el"))
  (require 'core-spacemacs)
  (spacemacs/init)
  (configuration-layer/sync)
  (spacemacs-buffer/display-startup-note)
  (spacemacs/setup-startup-hook)
  (require 'server)
  (unless (server-running-p) (server-start)))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;; FIXME: workaround
;; https://github.com/syl20bnr/spacemacs/issues/11798
(when (version<= "9.2" (org-version))
  (require 'org-tempo))

(frames-only-mode 1)
(global-set-key (kbd "C-s") 'helm-occur)
(global-prettify-symbols-mode 1)

(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✓ PRONTO(p)")
			  (sequence "⚑ ESPERANDO(e)" "|")
			  (sequence "|" "✘ CANCELADO(c)")))

(setq org-startup-indented t
      org-bullets-bullet-list ' ("一" "二" "三" "四" "五" "六" "七" "八" "九" "十");; no bullets, needs org-bullets package
;;      org-ellipsis " ⤵" ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers t
      ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)


;; org refiling pra mandar as tarefas de um arquivo pra outro
(setq org-refile-targets (quote (
				 ("~/semana.org" :maxlevel . 1)
				 ("~/notes_accomplished.org" :maxlevel . 1)
				 ("/vest/vestibular.org" :maxlevel . 1)
                 ("~/ossu/ossu.org" :maxlevel . 1))))


;; org-agenda load na pasta do emacs
;; TODO colocar os arquivos direitinho nesse negócio
(setq org-agenda-files '("~/Desktop/"
                         "~/vest/vestibular.org"
                         "~/ossu/ossu.org"
                         "~/semana.org"))


;; org-capture templates
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/Desktop/newgtd.org" "Tarefas")
	 "* TODO %^{Descrição breve} %^g \n %? \n Adicionado em: %U")
      ("c" "Checklist" entry (file+headline "~/Desktop/newgtd.org" "Tarefas")
       "* TODO %^{Descrição breve} [/] %^g \n- [ ] %? \n Adicionado em: %U")
      ("a" "Anotação" entry (file+headline "~/Desktop/notes.org" "Tarefas")
       "* TODO %^{Descrição breve} %^g \n %? \n link: %a \n Adicionado em: %U")
      ("i" "Info" entry (file+headline "~/Desktop/learn.org" "emacs")
       "* %^{Descrição} \n %? \n link: %a \n %:node")
      ("Ll" "links internet clipboard" entry (file+headline "~/Desktop/links.org" "links")
       "* %^{Descrição} \n [%x] \n %")))

;; disable linum mode in pdf mode
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(pdf-tools-install)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)
   (C . t)
   (sml . t)
   (haskell . t)
   (scheme . t)
   (sml . t)))

;; scheme -> racket babel
(add-hook 'scheme-mode-hook 'geiser-mode)
(setq geiser-default-implementation 'racket)

;;org-babel indent
(setq org-src-tab-acts-natively t)


;; auto completion snippers
(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-snippets-in-popup t)))

(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-help-tooltip t)))

(custom-set-faces
 '(company-tooltip-common
   ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection
   ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-sort-by-usage t)))

;; haskell

(eval-after-load "company"
  '(add-to-list 'company-backends 'company-dabbrev-code))
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-yasnippet))
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-files))
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))

;;ocaml TODO não está funcionando

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))


;;file sets pra abrir mais de um arquivo de uma vez
(filesets-init)

;; custom keys
;; TODO

(global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)


