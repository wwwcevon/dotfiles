;;
;; my-basic.el
;;

;; disable backup
(setq backup-inhibited t)
;; disable auto save
(setq auto-save-default nil)
(column-number-mode 1)
;; disable menu bar
(menu-bar-mode -99)
;; disable tool bar
(if (window-system)
    (progn
     (tool-bar-mode -1)
     (global-set-key (kbd "C-2") 'set-mark-command)))

;; delete all trailing white spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; goto-line
(global-set-key (kbd "C-l") 'goto-line)