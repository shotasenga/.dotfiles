;; load literate configuration :)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


;; load the legacy config file
;; TODO: delete after declutter the config
(load-file (expand-file-name "legacy.el" user-emacs-directory))
