(setq-default filesets-be-docile-flag 'nil)

(setq filesets-submenus '("org" ("0 org" ["Files: org" (filesets-open ':files '"org")] "---" ["0 newgtd.org" (filesets-file-open nil '"/home/sean/Desktop/newgtd.org" '"org")] ["1 ossu.org" (filesets-file-open nil '"/home/sean/ossu/ossu.org" '"org")] ["2 semana.org" (filesets-file-open nil '"/home/sean/semana.org" '"org")] ["3 vestibular.org" (filesets-file-open nil '"/home/sean/vest/vestibular.org" '"org")] "---" ["Close all files" (filesets-close ':files '"org")] ["Run Command" (filesets-run-cmd nil '"org" ':files)] ["Add current buffer" (filesets-add-buffer '"org" (current-buffer))] ["Remove current buffer" (filesets-remove-buffer '"org" (current-buffer))] ["Rebuild this submenu" (filesets-rebuild-this-submenu '"org")])))

(setq filesets-menu-cache '(("0 org" ["Files: org" (filesets-open ':files '"org")] "---" ["0 newgtd.org" (filesets-file-open nil '"/home/sean/Desktop/newgtd.org" '"org")] ["1 ossu.org" (filesets-file-open nil '"/home/sean/ossu/ossu.org" '"org")] ["2 semana.org" (filesets-file-open nil '"/home/sean/semana.org" '"org")] ["3 vestibular.org" (filesets-file-open nil '"/home/sean/vest/vestibular.org" '"org")] "---" ["Close all files" (filesets-close ':files '"org")] ["Run Command" (filesets-run-cmd nil '"org" ':files)] ["Add current buffer" (filesets-add-buffer '"org" (current-buffer))] ["Remove current buffer" (filesets-remove-buffer '"org" (current-buffer))] ["Rebuild this submenu" (filesets-rebuild-this-submenu '"org")])))

(setq filesets-ingroup-cache 'nil)

(setq filesets-cache-version "1.8.4")

