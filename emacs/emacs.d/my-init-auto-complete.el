;;; package --- Summary
;;; Commentary:


;;; Code:
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-expand-on-auto-complete nil)
(setq-default ac-auto-start nil)
(setq-default ac-dwim nil)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(setq completion-cycle-threshold 5)


(setq c-tab-always-indent nil
      c-insert-tab-function 'indent-for-tab-command)

;; hook AC into completion-at-point
(defun sanityinc/auto-complete-at-point ()
  (when (and (not (minibufferp))
	     (fboundp 'auto-complete-mode)
	     auto-complete-mode)))

(defun sanityinc/never-indent ()
  (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions
	(cons 'sanityinc/auto-complete-at-point
	      (remove 'sanityinc/auto-complete-at-point
		      completion-at-point-functions))))

(add-hook 'auto-complete-mode-hook
	  'set-auto-complete-as-completion-at-point-function)

(set-default 'ac-sources
	     '(ac-source-imenu
	       ac-source-dictionary
	       ac-source-words-in-buffer
	       ac-source-words-in-same-mode-buffers
	       ac-source-words-in-all-buffer))

(dolist (mode '(magit-log-edit-mode
		log-edit-mode org-mode text-mode haml-mode
		git-commit-mode
		sass-mode yaml-mode haskell-mode
		html-mode lisp-mode markdown-mode
		js2-mode css-mode stylus-mode
		sql-mode python-mode
		))
  (add-to-list 'ac-modes mode))

(provide 'my-init-auto-complete.el)
;;; my-init-auto-complete.el ends here
