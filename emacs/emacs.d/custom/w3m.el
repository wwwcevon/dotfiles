;; custom/w3m.el

(setq w3m-home-page "http://emacs-w3m.namazu.org/")
(setq browse-url-browser-function 'w3m-browse-url
      browse-url-new-window-flag t)
(autoload 'browse-url-interactive-arg "browse-url")
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key "\C-xm" 'browse-url-at-point)
(global-set-key "\C-xt" 'browse-url)
