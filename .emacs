;;; XEmacs backwards compatibility file
(setq user-init-file
      (expand-file-name "init.el"
			(expand-file-name ".emacs.d" "~")))
(setq custom-file
      (expand-file-name "custom.el"
			(expand-file-name ".emacs.d" "~")))

(load-file user-init-file)
(load-file custom-file)
