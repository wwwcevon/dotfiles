;;; package --- Summary:

;;; Commentary:

;;; Code:

(defun mew-summary-auto-or-manually-refile-region (func &optional arg)
  "refile region."
  (interactive "P")
  ;; * -> $
  (mew-summary-mark-escape)
  (when (mew-mark-active-p) (setq arg t))
  (if arg
      (let ((begend (mew-summary-get-region)))
	(mew-summary-mark-all-region (car begend) (cdr begend))
	(funcall func))
    (message "No region to refile"))
  ;; $ -> *
  (mew-summary-mark-review))

(defun mew-summary-auto-refile-region (&optional arg)
  "auto refile region."
  (interactive "P")
  (mew-summary-auto-or-manually-refile-region #'(lambda ()(mew-summary-auto-refile t)) arg))

(defun mew-summary-refile-region (&optional arg)
  "refile region selectively."
  (interactive "P")
  (mew-summary-auto-or-manually-refile-region #'mew-summary-mark-refile arg))


(setq mew-refile-guess-alist
      '(("Reply-To:"
	 ("cnpycon-volunteer@googlegroups.com" "%python-cn"))

        ("Reply-To:"
	 ("god-rb@googlegroups.com" "%god-rb"))

        ("Reply-To:"
	 ("arch-linux@googlegroups.com" "%archlinux"))

        ("Reply-To:"
	 ("mogile@googlegroups.com" "%mogilefs"))

        ("Reply-To:"
	 ("zh_wikipedia@googlegroups.com" "%wikipedia"))

        ("Reply-To:"
	 ("sinatrarb@googlegroups.com" "%sinatrarb"))

	("Reply-To:"
	 ("gentoo-\\(.\\+\\)@lists.gentoo.org" "%gentoo-\\1"))

	("From:"
	 ("billing@linode.com" "%billing"))

	("From:"
	 (".*@ens.usgs.gov" "%usgs"))

	("From:"
	 ("rw@peterc.org" "%ruby-weekly"))

	("From:"
	 ("jsw@peterc.org" "%javascript-weekly"))

	("From:"
	 ("bugzilla-daemon@gentoo.org" "%trash-bin")
	 ("notifications@github.com" "%trash-bin")
	 ("noreply@github.com" "%trash-bin")
	 ("support@github.com" "%trash-bin")
	 (".*@.*mbga.jp" "%trash-bin")
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


(require 'mew)
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(autoload 'mew-user-agent-compose "mew" nil t)

(setq read-mail-command 'mew)
(setq mail-user-agent 'mew-user-agent)
(define-mail-user-agent
  'mew-user-agent
  'mew-user-agent-compose
  'mew-draft-send-message
  'mew-draft-kill
  'mew-send-hook)

(setq read-mail-command 'mew)
(setq mew-name "80x24")
(setq mew-user "80x24")
(setq mew-mail-domain "momoka.net")
(setq mew-mail-path "~/.mail")

(setq mew-proto "%")
(setq mew-ssl-cert-directory "/etc/ssl/certs")
(setq mew-imap-user "80x24@momoka.net")
(setq mew-imap-server "mail.momoka.net")
(setq mew-imap-auth t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "80x24@momoka.net")
(setq mew-smtp-server "mail.momoka.net")
(setq mew-fcc "%sent")

(setq mew-use-unread-mark t)
(setq mew-summary-form '((5 type) " " (5 date) " " (5 time) "  " (25 from) " " t (0 subj)))
(setq mew-summary-form-extract-rule '(address))

(setq mew-use-cached-passwd t)
(setq mew-imap-trash-folder "%trash-bin")

;;; (provide 'my-init-mew)
;;; my-init-mew.el ends here
