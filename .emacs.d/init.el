;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
 '(bibtex-completion-bibliography (quote ("/home/sean/biblioteca.bib")))
 '(custom-safe-themes
   (quote
	("ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" default)))
 '(org-download-screenshot-method "gnome-screenshot")
 '(org-ref-default-bibliography "/home/sean/biblioteca.bib")
 '(package-selected-packages
   (quote
	(frames-only-mode pdf-view-restore org-pomodoro god-mode cyberpunk-theme mode-icons company-irony dash-functional lsp-haskell emmet-mode edit-server cider yasnippet-classic-snippets writeroom-mode which-key use-package undo-tree try smartparens rainbow-delimiters projectile pandoc-mode pandoc ox-reveal ox-jekyll-md ox-epub org-ref org-pretty-tags org-plus-contrib org-noter org-journal org-drill org-download org-bullets ob-sml nyan-mode nov magit linum-relative leetcode keycast html-to-markdown howdoyou helm-dash haskell-snippets gif-screencast flycheck-pycheckers flycheck-plantuml flycheck-irony flycheck-haskell flycheck-cask ess-smart-underscore company-math auto-org-md auto-compile all-the-icons)))
 '(reftex-default-bibliography (quote ("/home/sean/biblioteca.bib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(put 'downcase-region 'disabled nil)
