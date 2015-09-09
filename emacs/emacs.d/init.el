;;
;; Emacs config of AleiPhoenix
;;

;; (setq debug-on-error t)
(load "~/.emacs.d/my-functions.el")


(add-hook 'after-init-hook
	  '(lambda()
	     (load "~/.emacs.d/my-basic.el")
	     (load "~/.emacs.d/my-loadpackages.el")
	     (load "~/.emacs.d/my-style.el")
	     (load "~/.emacs.d/my-themes.el")

	     (message "startup time was %s" (emacs-uptime "%s"))))
