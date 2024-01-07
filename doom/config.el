(add-to-list 'load-path "~/.config/doom/scripts/")

(require 'buffer-move)   ;; Buffer-move for better window management

(map! :leader
      :desc "M-x"
      "SPC" #'execute-extended-command)

(map! :leader
      :desc "Find File in Project"
      ":" #'projectile-find-file)

(setq doom-theme 'doom-dracula)

(setq display-line-numbers-type 'relative)

;; Line Spacing for Emacs
(setq-default line-spacing 0.12)

;; Settings for Font Family and Size
(setq doom-font (font-spec :family "MesloLGL Nerd Font Mono" :size 16))
;; (setq doom-font (font-spec :family "Fira Code Nerd Font Mono" :size 17))

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

(setq org-directory "~/Documents/org/"
      org-hide-emphasis-markers t
      org-log-done 'time
     ;;org-superstar-headline-bullets-list '("◉" "○" "⁖" "✸" "✿")
      )
(add-to-list 'org-modules 'org-habit t)

(after! org
  (setq org-agenda-files '("~/Documents/org/" "~/Documents/org/org-roam"))
  (setq org-agenda-include-diary t)
  (setq org-habit-show-all-today t)
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t)
  )

(use-package toc-org
  :commands toc-org-mode
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/Documents/org/org-roam"))
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
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
         "#+title: %<%Y-%m-%d>\n"))))
  (setq org-roam-capture-templates
        '(("a" "workstuff" plain (file "~/Documents/org/org-roam/customer/templates/normal.org")
        :target (file+head "customer/%<%Y%m%d%H%M%S>-${slug}.org" "${title}\n") :unnarrowed t)
        ("b" "research" plain (file "~/Documents/org/org-roam/work/templates/updates.org")
        :target (file+head "work/%<%Y%m%d%H%M%S>-${slug}.org" "${title}\n") :unnarrowed t)
        ))
)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.10))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.08))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.06))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.04))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.02))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.00)))))

(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(use-package astro-ts-mode)

(setq treesit-language-source-alist
      '((astro "https://github.com/virchau13/tree-sitter-astro")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (typescript  "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
))

 (setenv "PATH" (concat (getenv "PATH") "/home/bastian/.nvm/versions/node/v21.2.0/bin/astro-ls"))
 (add-to-list 'exec-path (expand-file-name "/home/bastian/.nvm/versions/node/v21.2.0/bin/"))

 (setenv "PATH" (concat (getenv "PATH") "/home/bastian/.nvm/versions/node/v21.2.0/bin/tailwindcss-language-server"))
 (add-to-list 'exec-path (expand-file-name "/home/bastian/.nvm/versions/node/v21.2.0/bin/"))

(define-derived-mode astro-mode astro-ts-mode "astro")

(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(astro-mode . "astro"))

 (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("tailwindcss-language-server" "--stdio"))
                    :activation-fn (lsp-activate-on "astro" "blade")
                    :server-id 'tailwindcss-language-server
                    :add-on? t))
(lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                    :activation-fn (lsp-activate-on "astro")
                    :server-id 'astro-ls
                    :add-on? t))
)

(define-derived-mode blade-mode web-mode "blade")

(setq auto-mode-alist
      (append '((".*\\.blade.php\\'" . blade-mode))
              auto-mode-alist))

(use-package multi-vterm)

(use-package undo-fu-session
 :config
 (setq undo-fu-session-compression nil)
 )
