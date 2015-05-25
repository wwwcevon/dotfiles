;;; package --- Summary:

;;; Commentary:

;;; Code:

;;; (defun mew-summary-auto-or-manually-refile-region (func &optional arg)
;;;   "refile region."
;;;   (interactive "P")
;;;   ;; * -> $
;;;   (mew-summary-mark-escape)
;;;   (when (mew-mark-active-p) (setq arg t))
;;;   (if arg
;;;       (let ((begend (mew-summary-get-region)))
;;; 	(mew-summary-mark-all-region (car begend) (cdr begend))
;;; 	(funcall func))
;;;     (message "No region to refile"))
;;;   ;; $ -> *
;;;   (mew-summary-mark-review))
;;;
;;; (defun mew-summary-auto-refile-region (&optional arg)
;;;   "auto refile region."
;;;   (interactive "P")
;;;   (mew-summary-auto-or-manually-refile-region #'(lambda ()(mew-summary-auto-refile t)) arg))
;;;
;;; (defun mew-summary-refile-region (&optional arg)
;;;   "refile region selectively."
;;;   (interactive "P")
;;;   (mew-summary-auto-or-manually-refile-region #'mew-summary-mark-refile arg))
;;;
;;;

(setq mew-refile-guess-alist
      '(("Reply-To:"
	 ("cnpycon-volunteer@googlegroups.com" "%python-cn"))

        ("Reply-To:"
	 ("god-rb@googlegroups.com" "%god-rb"))

        ("Reply-To:"
	 ("arch-linux@googlegroups.com" "%archlinux"))

        ("Reply-To:"
	 ("zh_wikipedia@googlegroups.com" "%wikipedia"))

        ("Reply-To:"
	 ("sinatrarb@googlegroups.com" "%sinatrarb"))

	("Reply-To:"
	 ("gentoo-\\(.\\+\\)@lists.gentoo.org" "%gentoo-\\1"))

	("From:"
	 (".*@ens.usgs.gov" "%usgs"))

	("From:"
	 ("bugzilla-daemon@gentoo.org" "%trash-bin")
	 (".*@.*wikimedia.org" "%trash-bin")
	 (".*@.*godaddy.com" "%trash-bin")
	 (".*@.*51job.com" "%trash-bin")
	 (".*@.*backupify.com" "%trash-bin")
	 (".*@.*citi.com" "%trash-bin")
	 (".*@.*qq.com" "%trash-bin")
	 (".*@.*aliyun.com" "%trash-bin")
	 (".*@.*linkedin.com" "%trash-bin")
	 (".*@.*digitalocean.com" "%trash-bin")
	 (".*@.*gitlab.com" "%trash-bin")
	 (".*@.*slack.com" "%trash-bin")
	 (".*@.*pixiv.net" "%trash-bin")
	 (".*@.*dmm.com" "%trash-bin")
	 (".*@.*gdgshanghai.com" "%trash-bin")
	 (".*@.*taobao.com" "%trash-bin")
	 (".*@.*segmentfault.com" "%trash-bin"))))






;;; (provide 'my-init-mew)
;;; my-init-mew.el ends here
