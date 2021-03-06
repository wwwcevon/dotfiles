;;; package --- Summary
;;; Commentary:

;;
;; my-packages.el
;;

;;; Code:

;; list all packages I want
(require 'package)

;; add MELPA
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/")
	     t)

(package-initialize)

(defvar momoka-packages
  '(
    ;; themes
    zenburn-theme
    solarized-theme
    monokai-theme

    ;; modes
    cmake-mode
    coffee-mode
    emmet-mode
    erlang
    go-mode
    haskell-mode
    jade-mode
    js2-mode
    lua-mode
    markdown-mode
    nginx-mode
    php-mode
    python-mode
    sass-mode
    scss-mode
    stylus-mode
    web-mode
    yaml-mode

    ;; misc
    auto-complete
    ac-emmet
    flycheck
    highlight-indentation
    jdee
    jedi
    mew
    robe
    undo-tree
    visual-regexp
    yasnippet

    )
  )


;; http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
(setq url-http-attempt-keepalives nil)

(defun packages-installed-p ()
  (loop for p in momoka-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p momoka-packages)
    (when (not (package-installed-p p))
      (package-install p))))
