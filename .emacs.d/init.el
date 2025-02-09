;; Put all auto-generated stuff in one file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
;; Disable backup files.
(setf make-backup-files nil)
;; Prompt to delete autosaves when killing buffers.
(setf kill-buffer-delete-auto-save-files t)

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
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

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


(use-package undo-fu)

;; Setting up Evil Mode
(use-package evil
    :ensure t
    :init
    ;; allows for cgn
    (setq evil-search-module 'evil-search)
    (setq evil-want-keybinding nil)
    (setq evil-undo-system 'undo-fu)
    :config
    (evil-mode 1)
    (evil-set-initial-state 'dired-mode 'emacs))

(use-package evil-collection
    :after evil
    :config
    (setq evil-want-integration t)
    (evil-collection-init))

;;; Leader
(define-prefix-command 'my-leader-map)

(keymap-set evil-motion-state-map "SPC" 'my-leader-map)
(keymap-set evil-normal-state-map "SPC" 'my-leader-map)

(evil-define-key nil my-leader-map
    ;; füge hier deine Bindungen hinzu:
    "bs"  'switch-to-buffer
    "B"  'project-switch-to-buffer
    "bi" 'ibuffer
    "pf" 'project-find-file
    "ps" 'project-shell-command
    "oA" 'org-agenda
    "d" 'dired
    "mt" 'org-todo
    "mx" 'org-toggle-checkbox
    "mci" 'org-clock-in
    "mco" 'org-clock-out
    "mp" 'org-priority
    "nrf" 'org-roam-node-find
    "nn" 'org-capture
    "nrn" 'org-roam-capture
    ;; usw.
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

(setq org-directory "~/vaults/org/"
      org-hide-emphasis-markers t
      org-log-done 'time
      org-startup-indented t
      org-startup-folded 'showall
      org-archive-location "~/vaults/org/archive/archive.org::)"
      )
(add-to-list 'org-modules 'org-habit t)

;; Setting Tap for org cycle to help in Terminal Mode
(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
;; (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-fold-hide-drawer-toggle)

;; Keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "FEEDBACK(f)" "VERIFY(v)" "|" "DONE(d)" "DELEGATED(D)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
        (sequence "|" "CANCELED(c)")))

;; Properties


;; Org Capture Template
(setq org-cycle-separator-lines -1)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("Q" "Standard TODO Template" entry (file "~/vaults/org/org-roam/list/inbox.org")
          "* TODO %^{Title} %^{ACTIVITIES}p %^{LOCATION}p %^{ENERGIE}p %^{DEVICE}p %^{SCORE}p :PROPERTIES: :END:")
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
(global-set-key (kbd "C-x C-q") 'my-insert-snippet)

;; Org Agenda
  (setq org-agenda-files '("~/vaults/org/org-roam/habit/" "~/vaults/org/org-roam/list/" "~/vaults/org/org-roam/customer/"))
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
    :commands toc-org-mode
    :init (add-hook 'org-mode-hook 'toc-org-enable))

;; Org Bullets 
  (use-package org-superstar 
    :ensure t)

(setq org-superstar-headline-bullets-list '("◉" "○" "◈" "✸" "✿"))
(add-hook 'org-mode-hook
          (lambda ()
            (org-superstar-mode 1)))

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


