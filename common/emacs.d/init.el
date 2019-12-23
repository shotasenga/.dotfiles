;; Configure package repositories
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

;; load use-package here which is used to use 
(unless (or (package-installed-p 'use-package)
            (package-installed-p 'diminish))
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'diminish))


;; TODO: create and load config.org though org-babel
;; load literate configuration
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


;; load legacy config file
;; TODO: delete after declutter the config
(load-file (expand-file-name "legacy.el" user-emacs-directory))
