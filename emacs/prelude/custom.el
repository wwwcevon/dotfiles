(setq auto-save-default nil)
(setq make-backup-files nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'monokai t)

;; Comment and Uncomment
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))
(global-set-key "\M-," 'comment-or-uncomment-line-or-region)

(defun shift-text (distance)
  (if (use-region-p)
      (let ((mark (mark)))
        (save-excursion
          (indent-rigidly (region-beginning)
                          (region-end)
                          distance)
          (push-mark mark t t)
          (setq deactivate-mark nil)))
    (indent-rigidly (line-beginning-position)
                    (line-end-position)
                    distance)))

(defun shift-right (count)
  (interactive "p")
  (shift-text count))

(defun shift-left (count)
  (interactive "p")
  (shift-text (- count)))

(global-set-key (kbd "C-x >") (lambda () (interactive) (shift-right 4)))
(global-set-key (kbd "C-x <") (lambda () (interactive) (shift-left 4)))

;; goto line
(global-set-key "\C-l" 'goto-line)

(defun set-chinese-font()
  (set-default-font "Menlo-10")
  (set-fontset-font "fontset-default"
                    'gb18030 "WenQuanYi Micro Hei-10"))

(defun my-php-settings ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

(defun my-js-settings ()
  (setq js-indent-level 2))

(defun my-sh-settings ()
  (setq sh-basic-offset 2)
  (setq sh-indentation 2))

(defun my-coffee-settings ()
  (setq tab-width 2))

(defun my-lua-settings ()
  (setq lua-indent-level 2))

(add-hook 'php-mode-hook 'my-php-settings)
(add-hook 'js-mode-hook 'my-js-settings)
;; (add-hook 'before-make-frame-hook #'(lambda () (set-chinese-font)))
(add-hook 'sh-mode-hook 'my-sh-settings)
(add-hook 'coffee-mode-hook 'my-coffee-settings)
(add-hook 'lua-mode-hook 'my-lua-settings)

(let ((rtmv-module (expand-file-name
                    "emacs-realtime-markdown-viewer/realtime-markdown-viewer.el"
                    prelude-personal-dir)))
  (if (file-exists-p rtmv-module)
      (load rtmv-module)))

(setq rtmv:lang 'ruby)
;; (set-chinese-font)
