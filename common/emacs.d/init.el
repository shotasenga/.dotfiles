;; Configure package repositories
;; We need to configure it here, not in config.org. Otherwise, Emacs loads built-in version of org-mode to evaluate babel.
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


;; load literate configuration
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


;; load legacy config file
;; TODO: delete after declutter the config
(load-file (expand-file-name "legacy.el" user-emacs-directory))
(put 'downcase-region 'disabled nil)
