(setq-default filesets-be-docile-flag 'nil)

(setq filesets-submenus '("org" ("0 org" ["Files: org" (filesets-open (quote :files) (quote "org"))] "---" ["0 newgtd.org" (filesets-file-open nil (quote "/home/sean/Desktop/newgtd.org") (quote "org"))] ["1 ossu.org" (filesets-file-open nil (quote "/home/sean/ossu/ossu.org") (quote "org"))] ["2 semana.org" (filesets-file-open nil (quote "/home/sean/semana.org") (quote "org"))] ["3 vestibular.org" (filesets-file-open nil (quote "/home/sean/vest/vestibular.org") (quote "org"))] "---" ["Close all files" (filesets-close (quote :files) (quote "org"))] ["Run Command" (filesets-run-cmd nil (quote "org") (quote :files))] ["Add current buffer" (filesets-add-buffer (quote "org") (current-buffer))] ["Remove current buffer" (filesets-remove-buffer (quote "org") (current-buffer))] ["Rebuild this submenu" (filesets-rebuild-this-submenu (quote "org"))])))

(setq filesets-menu-cache '(("0 org" ["Files: org" (filesets-open (quote :files) (quote "org"))] "---" ["0 newgtd.org" (filesets-file-open nil (quote "/home/sean/Desktop/newgtd.org") (quote "org"))] ["1 ossu.org" (filesets-file-open nil (quote "/home/sean/ossu/ossu.org") (quote "org"))] ["2 semana.org" (filesets-file-open nil (quote "/home/sean/semana.org") (quote "org"))] ["3 vestibular.org" (filesets-file-open nil (quote "/home/sean/vest/vestibular.org") (quote "org"))] "---" ["Close all files" (filesets-close (quote :files) (quote "org"))] ["Run Command" (filesets-run-cmd nil (quote "org") (quote :files))] ["Add current buffer" (filesets-add-buffer (quote "org") (current-buffer))] ["Remove current buffer" (filesets-remove-buffer (quote "org") (current-buffer))] ["Rebuild this submenu" (filesets-rebuild-this-submenu (quote "org"))])))

(setq filesets-ingroup-cache 'nil)

(setq filesets-cache-version "1.8.4")

