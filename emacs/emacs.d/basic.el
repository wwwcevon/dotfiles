;;;; basic.el

(message "%s" "hello basic")

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

(column-number-mode 1)

;; disable menu bar
(menu-bar-mode -99)

;; disable tool bar
(if (window-system)
    (tool-bar-mode -1))

;; delete all trailing white spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;
;; global key bindings
;;;;
(global-set-key "\C-l" 'goto-line)
