;;; package --- Summary
;;; Commentary:
;; my-loadpackages.el
;;

;; setup ELPA package sources
(require 'cl)

;;; Code: loading package list from another directory
(load "~/.emacs.d/my-packages.el")


;; flycheck-mode
(require 'flycheck)
(global-flycheck-mode)
(load "~/.emacs.d/my-flycheck.el")

;; highlight-indentation
(add-hook 'python-mode-hook (highlight-indentation-mode))

;; yaml-mode
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; auto-complete
(load "~/.emacs.d/my-init-auto-complete.el")

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")
(add-hook 'term-mode-hook
	  (lambda()
	    (setq yas-dont-activate t)))


;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq js2-basic-offset 2)))

;; coffee-mode
(require 'coffee-mode)
(add-hook 'coffee-mode-hook
	  '(lambda()
	     ;; automatically clean up bad whitespace
	     (setq whitespace-action '(auto-cleanup))
	     ;; only show bad whitespace
	     (setq whitespace-style
		   '(
		     trailing
		     space-before-tab
		     indentation
		     empty
		     space-after-tab
		     )
		   )
	     (setq coffee-tab-width 2)
	     (whitespace-mode)
	     (global-whitespace-mode)))

;; web-mode
(require 'web-mode)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mako$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(setq web-mode-engines-alist
      '(("php" . "\\.phtml\\'")
	("django" . "\\.jinja\\'")))

(add-hook 'web-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq web-mode-markup-indent-offset 2)))


;; emmet-mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; ac-emmet
(require 'ac-emmet)
(add-hook 'css-mode-hook 'ac-emmet-css-setup)
(add-hook 'html-mode-hook 'ac-emmet-html-setup)
(add-hook 'sgml-mode-hook 'ac-emmet-html-setup)
(add-hook 'web-mode-hook 'ac-emmet-html-setup)

;; python-mode
(require 'python-mode)
(add-hook 'python-mode-hook
	  '(lambda()
	     (setq python-indent-level 4)
	     (setq tab-width 4)))

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; lua-mode
(require 'lua-mode)
(add-hook 'lua-mode-hook
	  '(lambda()
	     (setq lua-indent-level 2)))

;; nginx-mode
(add-hook 'nginx-mode-hook
	  '(lambda()
	     (setq nginx-indent-level 2)))

(require 'ido)
(ido-mode t)

(load "~/.emacs.d/my-init-mew.el")

;; visual wrap
(load "~/.emacs.d/my-visual-wrap.el")

;; mediawiki
(load "~/.emacs.d/mediawiki.el")
(require 'mediawiki)
(add-to-list 'auto-mode-alist '("\\.wiki$" . mediawiki-mode))
(add-to-list 'auto-mode-alist '("\\.mediawiki$" . mediawiki-mode))
(add-hook 'mediawiki-mode-hook
	  '(lambda()
	     (setq visual-wrap-column 78)
	     (set-visual-wrap-column 78)))



;; w3m
(require 'w3m)
(setq w3m-home-page "http://emacs-w3m.namazu.org/")
(setq browse-url-browser-function 'w3m-browse-url
      browse-url-new-window-flag t)

(autoload 'browse-url-interactive-arg "browse-url")
(autoload 'w3m-browse-url "w3m" "" t)
(global-set-key (kbd "C-x C-m") 'browse-url-at-point)
(global-set-key (kbd "C-x t") 'browse-url)

;; haskell-mode
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)



;; c-mode
(add-hook 'c-mode-hook
	  (lambda()
	    (setq c-default-style "linux"
		  c-indent-tab-mode t
		  tab-width 8
		  c-basic-offset 8)
	    (setq flycheck-gcc-language-standard "c99")))


;; cmake-mode
(require 'cmake-mode)


;; mo-mode
(load "~/.emacs.d/mo-mode.el")
(require 'mo-mode)
(add-to-list 'completion-ignored-extensions ".mo")
(add-to-list 'completion-ignored-extensions ".gmo")

;; highlight-indent
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'python-mode-hook 'highlight-indent-guides-mode)


;; whitespace

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines))
(global-whitespace-mode +1)
(set-face-attribute 'whitespace-line nil
		    :weight 'bold
		    :slant 'italic
		    :underline t
		    :foreground "#c2870f"
		    :background "#fab20a")

;; robe
(add-hook 'ruby-mode-hook 'robe-mode)

;; gentoo
(if (package-installed-p 'site-gentoo)
    (require 'site-gentoo))

(provide 'my-loadpackages.el)
;;; my-loadpackages.el ends here
