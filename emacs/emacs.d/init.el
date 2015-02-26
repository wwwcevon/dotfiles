(load "~/.emacs.d/load-packages.el")

(add-hook 'after-init-hook
	  '(lambda ()
	     (load "~/.emacs.d/basic.el")
	     (load "~/.emacs.d/custom/init.el")))
(setq mediawiki-site-alist
      '(("zh.wikipedia" "https://zh.wikipedia.org/w/"
	 "AleiPhoenix" "" "User:AleiPhoenix")
	("Wikipedia" "https://en.wikipedia.org/w/"
	 "AleiPhoenix" "" "User:AleiPhoenix")))
