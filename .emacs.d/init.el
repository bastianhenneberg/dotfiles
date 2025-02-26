;; Put all auto-generated stuff in one file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
;; Disable backup files.
(setf make-backup-files nil)
;; Prompt to delete autosaves when killing buffers.
(setf kill-buffer-delete-auto-save-files t)
(setq initial-buffer-choice "~/vaults/org/org-roam/index.org")

  (setq org-link-frame-setup
   '((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . find-file)
     (wl . wl-other-frame)))

(add-hook 'org-mode-hook 'display-line-numbers-mode)

;; Package Manager Setup
(require 'package)

(setq package-archives
	  '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
		("MELPA"        . "https://melpa.org/packages/")
		("ORG"          . "https://orgmode.org/elpa/")
		("MELPA Stable" . "https://stable.melpa.org/packages/")
		("nongnu"       . "https://elpa.nongnu.org/nongnu/"))
	  package-archive-priorities
	  '(("GNU ELPA"     . 20)
		("MELPA"        . 15)
		("ORG"          . 10)
		("MELPA Stable" . 5)
		("nongnu"       . 0)))

(package-initialize)


;; Setup use-package
(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

;; No Warnings when installing packages
;(add-to-list 'display-buffer-alist
;             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
;               (display-buffer-no-window)
;               (allow-no-window . t)))

;; Delete Selected text upon typing
(use-package delsel
  :ensure nil ; no need to install it as it is built-in
  :hook (after-init . delete-selection-mode))

;; Graphical Bars Setup
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode -1)

;; Font stuff
(let ((mono-spaced-font "Victor Mono Medium")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 140)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(use-package catppuccin-theme
  :ensure t 
  :config 
  (load-theme 'catppuccin :no-confim))


;; Use Icons Font in various places
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Configure Minibuffer and related stuff
(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package corfu
    :custom
    (corfu-cycle t)                 ; Allows cycling through candidates
    (corfu-auto t)                  ; Enable auto completion
    (corfu-auto-prefix 2)
    (corfu-auto-delay 0.1)
    (corfu-popupinfo-delay '(0.4 . 0.2))
    (corfu-preview-current 'insert) ; Do not preview current candidate
    (corfu-preselect-first nil)
    (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets

    :bind (:map corfu-map
                ("M-SPC"      . corfu-insert-separator)
                ("TAB"        . corfu-next)
                ([tab]        . corfu-next)
                ("S-TAB"      . corfu-previous)
                ([backtab]    . corfu-previous)
                ("S-<return>" . nil) ;; leave my entry as it is
                ("RET"        . corfu-insert))

    :init
       (global-corfu-mode)
       (corfu-history-mode)
       (corfu-popupinfo-mode) ; Popup completion info
    )
  (add-hook 'tex-mode-hook #'corfu-mode)
  (add-hook 'LaTeX-mode-hook #'corfu-mode)
 
(use-package corfu-terminal
      :ensure t)

(unless (display-graphic-p)
  (corfu-terminal-mode +1))


;; Tweaking dired file Manager
(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))


(use-package undo-fu
    :ensure t)
(use-package undo-tree
    :ensure t)

;; Setting up Evil Mode
(use-package evil
    :ensure t
    :init
    ;; allows for cgn
    (setq evil-search-module 'evil-search)
    (setq evil-want-keybinding nil)
    (setq evil-undo-system 'undo-fu)
    :config
    (evil-mode 1))

(use-package evil-collection
    :ensure t
    :after evil
    :config
    (setq evil-want-integration t)
    (evil-collection-init))

;; Leader
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))

(define-prefix-command 'my-leader-map)

(keymap-set evil-motion-state-map "SPC" 'my-leader-map)
(keymap-set evil-normal-state-map "SPC" 'my-leader-map)

(evil-define-key nil my-leader-map
    ;; füge hier deine Bindungen hinzu:
    "b" '("buffer" . (keymap))
    "bi" 'ibuffer
    "bd" 'evil-delete-buffer
    "pf" 'project-find-file
    "ps" 'project-shell-command
    "oA" 'org-agenda
    "d" 'dired
    "mt" 'org-todo
    "mx" 'org-toggle-checkbox
    "mci" 'org-clock-in
    "mco" 'org-clock-out
    "mp" 'org-priority
    "mds" 'org-schedule
    "mdd" 'org-deadline
    "msv" 'org-cut-subtree
    "msc" 'org-copy-subtree
    "mod" 'org-do-demote
    "mop" 'org-do-promote
    "mol" 'org-toggle-link-display
    "nri" 'org-roam-node-insert
    "nrf" 'org-roam-node-find
    "nn" 'org-capture
    "nrn" 'org-roam-capture
    "wh" 'evil-window-left
    "wk" 'evil-window-down
    "wl" 'evil-window-right
    "ws" 'evil-window-new
    "wv" 'evil-window-vnew
    "wd" 'evil-window-delete
    "sg" 'find-grep
    "sf" 'find-file
    "fp" 'my-insert-snippet
    "ac" 'evil-avy-goto-char
)

(evil-define-key 'insert minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)


;; Setting up which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Setting up Doom Modline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Doom Modline Configuration
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

;; Org all Stuff
;; Org-Mode
(use-package org
  :ensure t)

;; Org Remark
(use-package org-remark
  :ensure t)

;; Org Mermaid
(use-package mermaid-mode
    :ensure t)

(use-package mermaid-ts-mode
    :ensure t)

(use-package ob-mermaid
  :ensure t)
;; Installing mermaid-cli and set path to it
(setq ob-mermaid-cli-path "~/.nvm/versions/node/v20.16.0/bin/mmdc")

(use-package rustic
    :ensure t)

(use-package lsp-mode
    :ensure t)

(use-package avy
    :ensure t)

(use-package rust-mode
  :ensure t)

(setq org-directory "~/vaults/org/"
      org-hide-emphasis-markers t
      org-log-done 'time
      org-startup-indented t
      org-tags-column 0
      ;; Enter to follow a Link
      org-return-follows-link t
      org-startup-folded 'showall
      org-archive-location "~/vaults/org/archive/archive.org::)"
      )
(add-to-list 'org-modules 'org-habit t)

;; Source code native style
(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

;; Setting Tap for org cycle to help in Terminal Mode
(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
;; (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-fold-hide-drawer-toggle)

;; Keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "PROJ(p)" "WAIT(w)" "HOLD(h)" "MEET(x)" "CALL(c)" "MAIL(m)" "|" "DONE(D)" "DELEGATED(d)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
        (sequence "|" "CANCELED(C)")))

(setq org-todo-keyword-faces
      '(("TODO" . "#8aadf4") ("PROJ" . "#939ab7")  ("HOLD" . "#f5a97f") ("WAIT" . "#eed49f") ("MEET" . "#f5bde6") ("CALL" . "#8bd5ca") ("MAIL" . "#b7bdf8")
        ("DONE" . "#a6da95") ("DELEGATED" . "#939ab7") ("CANCELED" . (:foreground "#ed8796" :weight bold))))

;; Properties


;; Org Capture Template
(setq org-cycle-separator-lines -1)

(setq org-capture-templates
      '(("Q" "Standard TODO Template" entry (file "~/vaults/org/org-roam/list/inbox.org")
          "* TODO %^{Title} %^{LOCATION}p %^{ENERGIE}p %^{DEVICE}p %^{SCORE}p :PROPERTIES: :END:")
        ))

;; Setting org Properties for my Notes System if the are not devined by the capture template
(defun my-insert-snippet (location power device score)
  "Insert snippet and move point."
  (interactive "sEnter the Location (home, office, everywhere): \nsEnter the Energie (low, medium, high): \nsEnter the Device (phone, computer, none): \nsEnter the Score (10, 25, 50, 75, 100): ")
  (insert "\n:PROPERTIES:\n:LOCATION: "
      location
      "\n:ENERGIE: "
      power
      "\n:DEVICE: "
      device
      "\n:SCORE: " score "  \n:END:")
  (backward-word 2))
(global-set-key (kbd "C-x C-q") 'my-insert-snippet)

;; Org Agenda
  (setq org-agenda-files '("~/vaults/org/org-roam/habit/" "~/vaults/org/org-roam/list/" "~/vaults/org/org-roam/customer/" "~/vaults/org/org-roam/peppermint-digital.org"))
  (setq org-agenda-include-diary t)
  (setq org-habit-show-all-today t)
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t)
  (setq org-log-into-drawer "LOGBOOK")
  (setq org-agenda-window-setup 'current-window)


;; Org Roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/vaults/org/org-roam")
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
        )))

(use-package websocket
    :ensure t
    :after org-roam)

;; Org Roam UI
(use-package org-roam-ui
    :ensure t
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

;; Org Mode All Stuff

;; Org Modern
;(use-package org-modern
;    :ensure t
;    :config
;    (with-eval-after-load 'org (global-org-modern-mode)))

;; Org TOC
  (use-package toc-org
    :ensure t
    :commands toc-org-mode
    :init (add-hook 'org-mode-hook 'toc-org-enable))

;; Org Bullets 
  (use-package org-superstar 
    :ensure t)

(setq org-superstar-headline-bullets-list '("◉" "○" "◈" "✸" "✿"))
(add-hook 'org-mode-hook
          (lambda ()
            (org-superstar-mode 1)))

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . " ")
                                  (?B . " ")
                                  (?C . " "))))

;; Treesitter
(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

;; Org Modern
 
  ;(custom-set-faces
  ; '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
  ; '(org-level-2 ((t (:inherit outline-2 :height 1.10))))
  ; '(org-level-3 ((t (:inherit outline-3 :height 1.08))))
  ; '(org-level-4 ((t (:inherit outline-4 :height 1.06))))
  ; '(org-level-5 ((t (:inherit outline-5 :height 1.04))))
  ; '(org-level-6 ((t (:inherit outline-5 :height 1.02))))
  ; '(org-level-7 ((t (:inherit outline-5 :height 1.00))))
  ; )
  ;


