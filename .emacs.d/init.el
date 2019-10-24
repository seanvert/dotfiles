
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
 '(custom-safe-themes
   (quote
	("fa2af0c40576f3bde32290d7f4e7aa865eb6bf7ebe31eb9e37c32aa6f4ae8d10" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(idle-org-agenda-interval 300)
 '(idle-org-agenda-key "n")
 '(idle-org-agenda-mode t nil (idle-org-agenda))
 '(package-selected-packages
   (quote
	(edit-server arduino-mode cider yasnippet-classic-snippets writeroom-mode which-key use-package undo-tree try spacemacs-theme smartparens rainbow-delimiters projectile posframe poet-theme pandoc-mode pandoc ox-reveal ox-jekyll-md ox-epub org-ref org-pretty-tags org-pomodoro org-plus-contrib org-pdfview org-noter org-journal org-drill org-download org-bullets ob-sml nyan-mode nov monokai-theme magit linum-relative leuven-theme leetcode keycast idle-org-agenda html-to-markdown howdoyou helm-dash helm-company haskell-snippets gif-screencast frames-only-mode flycheck-pycheckers flycheck-plantuml flycheck-irony flycheck-haskell flycheck-cask ess-smart-underscore ein company-quickhelp company-math company-irony company-ghci company-anaconda auto-org-md auto-compile all-the-icons)))
 '(safe-local-variable-values (quote ((org-confirm-babel-evaluate)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
