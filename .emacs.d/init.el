
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
		   user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(org-plus-contrib org-drill ox-reveal atomic-chrome howdoyou ess-smart-underscore ess company-ghci haskell-snippets ein company-anaconda company-irony helm-dash projectile yasnippet-snippets yasnippet-classic-snippets yasnippet company-quickhelp company-math magit flycheck-cask flycheck-plantuml flycheck-pycheckers flycheck-haskell flycheck-irony flycheck ob-sml org-bullets auto-org-md ox-epub ox-jekyll-md html-to-markdown org-download org-pomodoro org-ref org-pretty-tags org-noter org-journal helm-company helm-bibtex which-key frames-only-mode undo-tree keycast gif-screencast rainbow-delimiters linum-relative leetcode smartparens nov try org-pdfview nyan-mode all-the-icons use-package monokai-theme auto-compile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
