;;; package --- summary
;;; Commentary:
;; my-basic.el
;;

;;; Code:

;; disable backup
(setq backup-inhibited t)
;; disable auto save
(setq auto-save-default nil)
(column-number-mode 1)
;; disable menu bar
(menu-bar-mode -99)
;; disable tool bar

;; delete all trailing white spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(add-hook 'buffer-list-update-hook
	  (lambda()
	    (if (window-system)
		(progn
		  (tool-bar-mode -1)
		  (global-set-key (kbd "C-2") 'set-mark-command)
		  (scroll-bar-mode -1)
		  (set-face-attribute 'default nil
				      :font "DejaVuSansMono-12")))))


;; goto-line
(global-set-key (kbd "C-l") 'goto-line)


(provide 'my-basic.el)
;;; my-basic.el ends here
