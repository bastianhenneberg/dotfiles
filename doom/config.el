(add-to-list 'load-path "~/.config/doom/scripts/")

(require 'buffer-move)   ;; Buffer-move for better window management

(map! :leader
      :desc "M-x"
      "SPC" #'execute-extended-command)

(map! :leader
      :desc "Find File in Project"
      ":" #'projectile-find-file)

;; (setq doom-theme 'doom-dracula)
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'macchiato) ;; or 'latte, 'macchiato, or 'mocha


(setq display-line-numbers-type 'relative)

;; Line Spacing for Emacs
(setq-default line-spacing 0.12)

;; Settings for Font Family and Size
;;(setq doom-font (font-spec :family "MesloLGL Nerd Font Mono" :size 16))
(setq doom-font (font-spec :family "Victor Mono Medium" :size 17))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; If the actual char height is larger, it respects the actual height.
(setq doom-modeline-height 50)
;; How wide the mode-line bar should be. It's only respected in GUI.
(setq doom-modeline-bar-width 5)
;; Whether to use hud instead of default bar. It's only respected in GUI.
(setq doom-modeline-hud nil)
;; Whether display the minor modes in the mode-line.
(setq doom-modeline-minor-modes nil)
;; adds perspective name to modeline
(setq doom-modeline-persp-name t)
;; adds folder icon next ot persp name
(setq doom-modeline-persp-icon t)
;; Whether display icons in the mode-line.
;; While using the server mode in GUI, should set the value explicitly.
;; Whether display icons in the mode-line.
;; While using the server mode in GUI, should set the value explicitly.
(setq doom-modeline-icon t)

;; Whether display the icon for `major-mode'. It respects option `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Whether display the colorful icon for `major-mode'.
;; It respects `nerd-icons-color-icons'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display the icon for the buffer state. It respects option `doom-modeline-icon'.
(setq doom-modeline-buffer-state-icon t)

;; Whether display the modification icon for the buffer.
;; It respects option `doom-modeline-icon' and option `doom-modeline-buffer-state-icon'.
(setq doom-modeline-buffer-modification-icon t)

;; Whether display the lsp icon. It respects option `doom-modeline-icon'.
(setq doom-modeline-lsp-icon t)

;; Whether display the time icon. It respects option `doom-modeline-icon'.
(setq doom-modeline-time-icon t)

;; Whether display the live icons of time.
;; It respects option `doom-modeline-icon' and option `doom-modeline-time-icon'.
(setq doom-modeline-time-live-icon t)

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :hook
  ((org-mode prog-mode) . rainbow-mode))

(setq org-directory "~/vaults/org/"
      org-hide-emphasis-markers t
      org-log-done 'time
      org-archive-location "~/vaults/org/archive/archive.org::)"
     ;;org-superstar-headline-bullets-list '("◉" "○" "⁖" "✸" "✿")
      )
(add-to-list 'org-modules 'org-habit t)

(after! org
(setq org-cycle-separator-lines -1)
(add-to-list 'org-capture-templates
             '("Q" "Standard TODO Template" entry (file "~/vaults/org/org-roam/list/inbox.org")
               "* TODO %^{Title} %^{ACTIVITIES}p %^{LOCATION}p %^{ENERGIE}p %^{DEVICE}p %^{SCORE}p
:PROPERTIES:
:END:
"
))

;; Setting org Properties for my Notes System if the are not devined by the capture template
(defun my-insert-snippet (activity location power device score)
  "Insert snippet and move point."
  (interactive "sEnter the Activity (appointment, planning, invoice, offer, call): \nsEnter the Location (home, office, everywhere): \nsEnter the Energie (low, medium, high): \nsEnter the Device (phone, computer, none): \nsEnter the Score (10, 25, 50, 75, 100): ")
  (insert "\n:PROPERTIES:\n:ACTIVITIES: "
      activity
      "\n:LOCATION: "
      location
      "\n:ENERGIE: "
      power
      "\n:DEVICE: "
      device
      "\n:SCORE: " score "  \n:END:")
  (backward-word 2))
;; (evil-define-key 'normal 'global (kbd "<leader>nz") 'my-insert-snippet))
(global-set-key (kbd "C-q") 'my-insert-snippet))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(after! org
  (setq org-agenda-files '("~/vaults/org/org-roam/habit/" "~/vaults/org/org-roam/list/" "~/vaults/org/org-roam/customer/"))
  (setq org-agenda-include-diary t)
  (setq org-habit-show-all-today t)
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t)
  (setq org-log-into-drawer "LOGBOOK")
  )

;; Keywords
(after! org
(setq org-todo-keywords
      '((sequence "TODO(t)" "PROJ(p)" "WAIT(w)" "HOLD(h)" "MEET(x)" "CALL(c)" "MAIL(m)" "|" "DONE(D)" "DELEGATED(d)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
        (sequence "|" "CANCELED(C)")))

(setq org-todo-keyword-faces
      '(("TODO" . "#8aadf4") ("PROJ" . "#939ab7")  ("HOLD" . "#f5a97f") ("WAIT" . "#eed49f") ("MEET" . "#f5bde6") ("CALL" . "#8bd5ca") ("MAIL" . "#b7bdf8")
        ("DONE" . "#a6da95") ("DELEGATED" . "#939ab7") ("CANCELED" . (:foreground "#ed8796" :weight bold))))
)

(use-package toc-org
  :commands toc-org-mode
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/vaults/org/org-roam"))
  (org-roam-complete-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n h" . org-roam-capture)
         ([mouse-1] . org-roam-visit-thing)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-dailies-capture-templates
      '(("s" "daily" entry (file "~/vaults/org/org-roam/templates/daily.org")
         :target (file+head "%<%Y-%m-%d>.org" "%<%Y-%m-%d>\n"))
        ))
  (setq org-roam-capture-templates
        '(("a" "customer" plain (file "~/vaults/org/org-roam/templates/customer.org")
        :target (file+head "customer/${slug}.org" "${title}\n") :unnarrowed t)
        ("b" "project" plain (file "~/vaults/org/org-roam/templates/project.org")
        :target (file+head "project/${slug}.org" "${title}\n") :unnarrowed t)
        ("h" "habit" plain (file "~/vaults/org/org-roam/templates/habit.org")
        :target (file+head "habit/${slug}.org" "${title}\n") :unnarrowed t)
        ("d" "default" plain (file "~/vaults/org/org-roam/templates/default.org")
        :target (file+head "${slug}.org" "${title}\n") :unnarrowed t)
        ("l" "list" plain (file "~/vaults/org/org-roam/templates/list.org")
        :target (file+head "list/${slug}.org" "${title}\n") :unnarrowed t)
        ("c" "contact" plain (file "~/vaults/org/org-roam/templates/contact.org")
        :target (file+head "contact/${slug}.org" "${title}\n") :unnarrowed t)
        ("e" "coding" plain (file "~/vaults/org/org-roam/templates/coding.org")
        :target (file+head "coding/${slug}.org" "${title}\n") :unnarrowed t)
        ))
)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.10))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.08))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.06))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.04))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.02))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.00))))
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package! lsp-tailwindcss           ;;
;;   :init                                 ;;
;;   (setq lsp-tailwindcss-add-on-mode t)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (astro "https://github.com/virchau13/tree-sitter-astro")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(global-set-key (kbd "C-:") 'avy-goto-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package astro-ts-mode)                                                                                           ;;
;;                                                                                                                       ;;
;; (setq treesit-language-source-alist                                                                                   ;;
;;       '((astro "https://github.com/virchau13/tree-sitter-astro")                                                      ;;
;;         (css "https://github.com/tree-sitter/tree-sitter-css")                                                        ;;
;;         (typescript  "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")               ;;
;;         (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")                              ;;
;; ))                                                                                                                    ;;
;;                                                                                                                       ;;
;;   (setenv "PATH" (concat (getenv "PATH") "/home/bastian/.nvm/versions/node/v21.2.0/bin/astro-ls"))                    ;;
;;   (add-to-list 'exec-path (expand-file-name "/home/bastian/.nvm/versions/node/v21.2.0/bin/"))                         ;;
;;                                                                                                                       ;;
;;   (setenv "PATH" (concat (getenv "PATH") "/home/bastian/.nvm/versions/node/v21.2.0/bin/tailwindcss-language-server")) ;;
;;   (add-to-list 'exec-path (expand-file-name "/home/bastian/.nvm/versions/node/v21.2.0/bin/"))                         ;;
;;                                                                                                                       ;;
;; (define-derived-mode astro-mode astro-ts-mode "astro")                                                                ;;
;;                                                                                                                       ;;
;; (setq auto-mode-alist                                                                                                 ;;
;;       (append '((".*\\.astro\\'" . astro-mode))                                                                       ;;
;;               auto-mode-alist))                                                                                       ;;
;;                                                                                                                       ;;
;; (with-eval-after-load 'lsp-mode                                                                                       ;;
;;   (add-to-list 'lsp-language-id-configuration                                                                         ;;
;;                '(astro-mode . "astro"))                                                                               ;;
;;                                                                                                                       ;;
;;  (lsp-register-client                                                                                                 ;;
;;    (make-lsp-client :new-connection (lsp-stdio-connection '("tailwindcss-language-server" "--stdio"))                 ;;
;;                     :activation-fn (lsp-activate-on "astro" "blade")                                                  ;;
;;                     :server-id 'tailwindcss-language-server                                                           ;;
;;                     :add-on? t))                                                                                      ;;
;; (lsp-register-client                                                                                                  ;;
;;    (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))                                    ;;
;;                     ;;:initialization-options '("./node_modules/typescript/lib")                                      ;;
;;                     :activation-fn (lsp-activate-on "astro")                                                          ;;
;;                     :server-id 'astro-ls                                                                              ;;
;;                     :add-on? t))                                                                                      ;;
;; )                                                                                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; WEB MODE
;; (use-package web-mode
;;   :ensure t)

;; ;; ASTRO
;; (define-derived-mode astro-mode web-mode "astro")
;; (setq auto-mode-alist
;;       (append '((".*\\.astro\\'" . astro-mode))
;;               auto-mode-alist))

;; ;; EGLOT
;; (use-package eglot
;;   :ensure t
;;   :config
;;   (add-to-list 'eglot-server-programs
;;                '(astro-mode . '(("astro-ls" "--stdio"
;;                                :initializationOptions
;;                                (:typescript (:tsdk "./node_modules/typescript/lib")))
;; ("tailwindcss-language-server" "--stdio")
;;                                 )))
;;   :init
;;   ;; auto start eglot for astro-mode
;;   (add-hook 'astro-mode-hook 'eglot-ensure))

(define-derived-mode blade-mode web-mode "blade")

(setq auto-mode-alist
      (append '((".*\\.blade.php\\'" . blade-mode))
              auto-mode-alist))

;; (use-package multi-vterm :ensure t)
;; (add-hook 'vterm-mode-hook 'evil-emacs-state)

(use-package undo-fu-session
 :config
 (setq undo-fu-session-compression nil)
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package org-excalidraw                                    ;;
;;   :config                                                      ;;
;;   (setq org-excalidraw-directory "~/Documents/org/excalidraw") ;;
;; )                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ob-mermaid
  :config
  (setq ob-mermaid-cli-path "/home/bastian/.nvm/versions/node/v20.16.0/bin/mmdc")
)

;; (use-package mermaid-mode
;;   :config
;;   (setq mermaid-mmdc-location "/home/bastian/.nvm/versions/node/v20.16.0/bin/mmdc")
;; )

 (org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)
      (your-other-langs . t)))

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail)

  (setq mu4e-maildir "~/mail")

  (setq mu4e-contexts
        (list
         ;; Info account
         (make-mu4e-context
          :name "Info"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/info" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "info@brandkollektiv.de")
                  (user-full-name    . "info@brandkollektiv.de")
                  (mu4e-drafts-folder  . "/info/[Gmail]/Entw&APw-rfe")
                  (mu4e-sent-folder  . "/info/[Gmail]/Gesendet")
                  (mu4e-refile-folder  . "/info/[Gmail]/Alle Nachrichten")
                  (mu4e-trash-folder  . "/info/[Gmail]/Papierkorb")
                  (mu4e-compose-signature . "---\nBastian Henneberg\nHead of Development")))

         ;; Buchhaltung account
          (make-mu4e-context
          :name "Buchhaltung"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/buchhaltung" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "buchhaltung@brandkollektiv.de")
                  (user-full-name    . "buchhaltung@brandkollektiv.de")
                  (mu4e-drafts-folder  . "/buchhaltung/[Gmail]/Entw&APw-rfe")
                  (mu4e-sent-folder  . "/buchhaltung/[Gmail]/Gesendet")
                  (mu4e-refile-folder  . "/buchhaltung/[Gmail]/Alle Nachrichten")
                  (mu4e-trash-folder  . "/buchhaltung/[Gmail]/Papierkorb")
                   (mu4e-compose-signature . "---\nBastian Henneberg\nHead of Development")))

          ;; Peppermint account
          (make-mu4e-context
          :name "Peppermint"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/peppermint" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "henneberg@peppermint-digital.de")
                  (user-full-name    . "henneberg@peppermint-digital.de")
                  (mu4e-drafts-folder  . "/peppermint/Drafts")
                  (mu4e-sent-folder  . "/peppermint/Sent")
                  (mu4e-refile-folder  . "/peppermint/Archiv")
                  (mu4e-trash-folder  . "/peppermint/Trash")
                  (mu4e-compose-signature . "---\nBastian Henneberg\nHead of Development")))

    )

      ;; (setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)

)
