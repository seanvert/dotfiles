;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

;;(require 'package)
;;(setq package-enable-at-startup nil)

(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
		   user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" default))
 '(org-agenda-files
   '("/ubuntu/home/sean/20200723120050-projects.org" "/ubuntu/home/sean/20200723114804-emacs.org" "/ubuntu/home/sean/20200724100553-reading_assistant_emacs.org" "/ubuntu/home/sean/20200724101050-philosophy.org" "/ubuntu/home/sean/Ancient Philosophy Volume 1 - Anthony Kenny.org" "/ubuntu/home/sean/Judith S. Beck Phd - Cognitive Behavior Therapy_ Basics and Beyond, Second Edition  -The Guilford Press (2011).org" "/ubuntu/home/sean/German Quickly_ A Grammar for Reading Germ - April Wilson.org" "/ubuntu/home/sean/20200724100440-meu_guia.org" "/ubuntu/home/sean/posts.org" "/ubuntu/home/sean/20200724095938-math.org" "/ubuntu/home/sean/computer.org" "/ubuntu/home/sean/20200804231437-ciclo.org" "/ubuntu/home/sean/Voyage of Discovery, 4th ed_ - William F. Lawhead.org" "/ubuntu/home/sean/20200724115032-vestibular.org" "/ubuntu/home/sean/20200724201749-books.org" "~/.emacs.d/config.org"))
 '(package-selected-packages
   '(realgud yaml-mode css-mode rustic rust-mode rainbow-mode ob-restclient restclient yasnippet-snippets which-key web-mode use-package undo-tree try tree-mode smartparens skewer-mode rainbow-delimiters prettier-js polymode pdfgrep pdf-view-restore ox-reveal ox-jekyll-md ox-epub org-roam-bibtex org-ref org-pretty-tags org-pomodoro org-plus-contrib org-noter org-journal org-download ob-sml nov multi-term memoize magit lsp-ui lsp-haskell lsp-clangd linum-relative leetcode keycast json-mode html-to-markdown howdoyou helm-swoop helm-org-rifle helm-lsp helm-dash helm-c-yasnippet haskell-snippets god-mode gif-screencast frames-only-mode flycheck-pycheckers flycheck-plantuml flycheck-package flycheck-irony flycheck-haskell flycheck-demjsonlint flycheck-cask emmet-mode django-mode deft deferred dap-mode company-quickhelp company-org-roam company-math company-irony auto-yasnippet auto-org-md auto-complete auto-compile anki-editor)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#3ca724641aaf"))))
 '(company-scrollbar-fg ((t (:background "#2ae019b912dd"))))
 '(company-tooltip ((t (:inherit default :background "#190f0b"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))
