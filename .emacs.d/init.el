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

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(bibtex-completion-bibliography (quote ("/home/sean/biblioteca.bib")))
;;  '(custom-safe-themes
;;    (quote
;; 	("00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "021321ae56a45794f43b41de09fb2bfca184e196666b7d7ff59ea97ec2114559" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" default)))
;;  '(default-input-method "japanese")
;;  '(org-download-screenshot-method "gnome-screenshot")
;;  '(org-ref-default-bibliography "/home/sean/biblioteca.bib")
;;  '(org-roam-bibtex-mode nil)
;;  '(package-selected-packages
;;    (quote
;; 	(prettier-js tide anki-editor org-roam-protocol org-roam-bibtex company-org-roam org-roam deft eink-theme justify-kp indium typescript-mode json-mode web-mode django-mode frames-only-mode pdf-view-restore org-pomodoro god-mode cyberpunk-theme mode-icons company-irony dash-functional lsp-haskell emmet-mode edit-server cider yasnippet-classic-snippets writeroom-mode which-key use-package undo-tree try smartparens rainbow-delimiters projectile pandoc-mode pandoc ox-reveal ox-jekyll-md ox-epub org-ref org-pretty-tags org-noter org-journal org-drill org-download org-bullets ob-sml nyan-mode nov linum-relative leetcode keycast html-to-markdown howdoyou helm-dash haskell-snippets gif-screencast flycheck-pycheckers flycheck-plantuml flycheck-irony flycheck-haskell flycheck-cask ess-smart-underscore company-math auto-org-md)))
;;  '(reftex-default-bibliography (quote ("/home/sean/biblioteca.bib")))
;;  '(spaceline-helm-mode t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
;; ;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; ;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; (put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" default)))
 '(org-agenda-files
   (quote
	("/ubuntu/home/sean/20200723114804-emacs.org" "~/.emacs.d/config.org")))
 '(package-selected-packages
   (quote
	(rainbow-mode ob-restclient restclient yasnippet-snippets which-key web-mode use-package undo-tree try tree-mode smartparens skewer-mode rainbow-delimiters prettier-js polymode pdfgrep pdf-view-restore ox-reveal ox-jekyll-md ox-epub org-roam-bibtex org-ref org-pretty-tags org-pomodoro org-plus-contrib org-noter org-journal org-download ob-sml nov multi-term memoize magit lsp-ui lsp-haskell lsp-clangd linum-relative leetcode keycast json-mode html-to-markdown howdoyou helm-swoop helm-org-rifle helm-lsp helm-dash helm-c-yasnippet haskell-snippets god-mode gif-screencast frames-only-mode flycheck-pycheckers flycheck-plantuml flycheck-package flycheck-irony flycheck-haskell flycheck-demjsonlint flycheck-cask emmet-mode django-mode deft deferred dap-mode company-quickhelp company-org-roam company-math company-lsp company-irony company-box auto-yasnippet auto-org-md auto-complete auto-compile anki-editor))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#3c8e24551aa4"))))
 '(company-scrollbar-fg ((t (:background "#2ac719aa12d2"))))
 '(company-tooltip ((t (:inherit default :background "#190f0b"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))
