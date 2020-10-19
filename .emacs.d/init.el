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
 '(beacon-color "#F8BBD0")
 '(custom-safe-themes
   '("7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "4f01c1df1d203787560a67c1b295423174fd49934deb5e6789abd1e61dba9552" "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "5036346b7b232c57f76e8fb72a9c0558174f87760113546d3a9838130f1cdb74" "28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" "2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "711efe8b1233f2cf52f338fd7f15ce11c836d0b6240a18fffffc2cbd5bfe61b0" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "3df5335c36b40e417fec0392532c1b82b79114a05d5ade62cfe3de63a59bc5c6" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "d5a878172795c45441efcd84b20a14f553e7e96366a163f742b95d65a3f55d71" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "dde8c620311ea241c0b490af8e6f570fdd3b941d7bc209e55cd87884eb733b0e" "54cf3f8314ce89c4d7e20ae52f7ff0739efb458f4326a2ca075bf34bc0b4f499" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" default))
 '(default-input-method "cyrillic-translit")
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(emms-mode-line-icon-color "#1ba1a1")
 '(evil-emacs-state-cursor '("#D50000" hbar) t)
 '(evil-insert-state-cursor '("#D50000" bar) t)
 '(evil-normal-state-cursor '("#F57F17" box) t)
 '(evil-visual-state-cursor '("#66BB6A" box) t)
 '(gnus-logo-colors '("#1ec1c4" "#bababa") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   '("#F57F17" "#66BB6A" "#0097A7" "#42A5F5" "#7E57C2" "#D84315"))
 '(highlight-symbol-foreground-color "#546E7A")
 '(highlight-tail-colors '(("#F8BBD0" . 0) ("#FAFAFA" . 100)))
 '(line-spacing 0.2)
 '(org-agenda-files
   '("/ubuntu/home/sean/computer.org" "/ubuntu/home/sean/20200723120050-projects.org" "/ubuntu/home/sean/20200723114804-emacs.org" "/ubuntu/home/sean/20200724100553-reading_assistant_emacs.org" "/ubuntu/home/sean/20200724101050-philosophy.org" "/ubuntu/home/sean/Ancient Philosophy Volume 1 - Anthony Kenny.org" "/ubuntu/home/sean/Judith S. Beck Phd - Cognitive Behavior Therapy_ Basics and Beyond, Second Edition  -The Guilford Press (2011).org" "/ubuntu/home/sean/20200724100440-meu_guia.org" "/ubuntu/home/sean/posts.org" "/ubuntu/home/sean/20200724095938-math.org" "/ubuntu/home/sean/20200804231437-ciclo.org" "/ubuntu/home/sean/Voyage of Discovery, 4th ed_ - William F. Lawhead.org" "/ubuntu/home/sean/20200724115032-vestibular.org" "/ubuntu/home/sean/20200724201749-books.org" "~/.emacs.d/config.org"))
 '(package-selected-packages
   '(composer org-superstar flycheck-pychecker flycheck-mypy flycheck-joker flycheck-clj-kondo dante rjsx-mode org-attach-screenshot php-mode tuareg tuareg-mode merlin-eldoc merlin ranger company-c-headers helm-gtags gg-tags forge wakatime-mode wakatime devdocs devdocs-lookup reason-mode elpy pyenv-mode realgud yaml-mode css-mode rustic rust-mode rainbow-mode ob-restclient restclient yasnippet-snippets which-key web-mode use-package undo-tree try tree-mode smartparens skewer-mode rainbow-delimiters prettier-js polymode pdfgrep pdf-view-restore ox-reveal ox-jekyll-md ox-epub org-roam-bibtex org-ref org-pretty-tags org-pomodoro org-plus-contrib org-noter org-journal org-download ob-sml nov multi-term memoize magit lsp-ui lsp-haskell lsp-clangd linum-relative leetcode keycast json-mode html-to-markdown howdoyou helm-swoop helm-org-rifle helm-lsp helm-c-yasnippet haskell-snippets god-mode gif-screencast frames-only-mode flycheck-pycheckers flycheck-plantuml flycheck-package flycheck-irony flycheck-haskell flycheck-demjsonlint flycheck-cask emmet-mode django-mode deft deferred dap-mode company-quickhelp company-org-roam company-math company-irony auto-yasnippet auto-org-md auto-complete auto-compile anki-editor))
 '(pos-tip-background-color "#ffffffffffff")
 '(pos-tip-foreground-color "#78909C")
 '(projectile-mode t nil (projectile))
 '(tabbar-background-color "#ffffffffffff"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#31d4356343a0"))))
 '(company-scrollbar-fg ((t (:background "#26f829c034e3"))))
 '(company-tooltip ((t (:inherit default :background "#1c1e26"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
 '(emmet-preview-input ((t (:inherit lazy-highlight))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
