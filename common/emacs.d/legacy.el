;; -*- mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ----------------------------------------------------------------------
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ load-path
(add-to-list 'load-path "~/.emacs.d/elisp")

;; exec-path
(add-to-list 'exec-path "/usr/local/bin")


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ package
;; (when (require 'package nil t)
;;   ;; add repositry ELPA
;;   (add-to-list 'package-archives
;;                '("ELPA" . "http://tromey.com/elpa/"))
;;   ;; Marmalade
;;   (add-to-list 'package-archives
;;                '("marmalade" . "http://marmalade-repo.org/packages/"))
;;   (package-initialize))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ defaullt packages forked from http://www.aaronbedra.com/emacs.d/
;; NOTE show current activated packages
;;     `C-h v` (describe-variable) package-activated-list
(defvar my:packages '(
                      ag
                      async
                      autopair
                      blank-mode
                      coffee-mode
                      dash
                      deft
                      epl
                      exec-path-from-shell
                      flymake-cursor
                      flymake-easy
                      flymake-google-cpplint
                      ggtags
                      haml-mode
                      helm
                      helm-core
                      helm-descbinds
                      helm-gtags
                      highlight-indentation
                      json-reformat
                      json-snatcher
                      pkg-info
                      popup
                      powerline
                      rainbow-mode
                      restclient
                      rich-minority
                      sass-mode
                      slime
                      stylus-mode
                      sws-mode
                      with-editor
                      )
  "Default packages")

;; (defun my:packages-installed-p ()
;;   (loop for pkg in my:packages
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))

;; (unless (my:packages-installed-p)
;;   (message "%s" "Refreshing package database...")
;;   (package-refresh-contents)
;;   (dolist (pkg my:packages)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Startup screen
(setq inhibit-splash-screen t
      initial-scratch-message nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ disable beep
(setq ring-bell-function 'ignore)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ text marking
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ misc
(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)
;; save cursor position
(setq-default save-place t)
;; echo area
(setq echo-keystrokes 0.1)
;; dired-dwim-target
(setq dired-dwim-target t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Encoding
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(define-coding-system-alias 'UTF-8 'utf-8)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Global key set
;; auto indent
(global-set-key (kbd "RET") 'newline-and-indent)
;; C-h as delete
(keyboard-translate ?\C-h ?\C-?)
(global-set-key [?\C-c ?h] 'help-command)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Screen swap
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen-with-cursor)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ font
(when window-system
  ;; http://d.hatena.ne.jp/minus9d/20131103/1383475472
  ;; default
  (set-face-attribute 'default nil
                      :family "Hack" ;; font
                      :height 125)    ;; font size

  ;; japanese
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; (font-spec :family "Hiragino Mincho Pro")) ;; font
   (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font
  (setq face-font-rescale-alist
        '((".*Hiragino_Mincho_pro.*" . 1.2))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ indentation
;; indent size and type
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq sgml-basic-offset 4)
(setq js-indent-level 2)

;; indent cleanup
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))
(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))
(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))
(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (replace-regexp re "" nil beg end))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-M-l") 'cleanup-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ hilight indentation
;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#10505D")
;; (set-face-background 'highlight-indentation-current-column-face "#3f727d")
;; (add-hook 'python-mode-hook 'highlight-indentation-mode)
;; (add-hook 'js2-mode-hook 'highlight-indentation-mode)
;; (add-hook 'ruby-mode-hook 'highlight-indentation-mode)
;; (add-hook 'sass-mode-hook 'highlight-indentation-mode)
;; (add-hook 'jade-mode-hook 'highlight-indentation-mode)
;; (add-hook 'stylus-mode-hook 'highlight-indentation-mode)
;; (add-hook 'coffee-mode-hook 'highlight-indentation-mode)
;; (add-hook 'emacs-lisp-mode-hook 'highlight-indentation-mode)
;; (add-hook 'web-mode-hook 'highlight-indentation-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ whitespace
;; for whitespace-mode
;; (require 'whitespace)
;; ;; see whitespace.el for more details
;; (setq whitespace-style '(face tabs tab-mark spaces space-mark))
;; (setq whitespace-display-mappings
;;       ;;      '((space-mark ?\u3000 [?\u25a1]) ; zenkaku-whitespace to white-square-mark
;;       '(
;;         ;; (space-mark 32 [46] [46]) ; 32 SPACE, 183 MIDDLE DOT ·, 46 FULL STOP .
;;         ;; (newline-mark [10 13] [182]) ; 10 LINE FEED
;;         ;; WARNING: the mapping below has a problem.
;;         ;; When a TAB occupies exactly one column, it will display the
;;         ;; character ?\xBB at that column followed by a TAB which goes to
;;         ;; the next TAB column.
;;         ;; If this is a problem for you, please, comment the line below.
;;         (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
;;(setq whitespace-space-regexp "\\(\u3000+\\)")
;;      aaa <- this line tabbed
;; (set-face-foreground 'whitespace-tab "#505050")
;; (set-face-background 'whitespace-tab 'nil)
;; (set-face-underline  'whitespace-tab t)
;; (set-face-foreground 'whitespace-space "#505050")
;; (set-face-background 'whitespace-space 'nil)
;; (set-face-bold-p 'whitespace-space t)
;(global-whitespace-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ copy current file name to clipboard
;; from http://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ eshell
;; via http://syohex.hatenablog.com/entry/20130718/1374154709
;;(let ((envs '("PATH" "ANDROID_HOME" "GOROOT" "GOPATH")))
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ html-mode
;; (add-hook 'html-mode-hook
;;           (lambda ()
;;             ;; Default indentation is usually 2 spaces, changing to 4.
;;             (set (make-local-variable 'sgml-basic-offset) 4)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ rainbow-mode
(setq rainbow-html-colors t)
(setq rainbow-x-colors t)
(setq rainbow-latex-colors t)
(setq rainbow-ansi-colors t)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ ReST restructuredtext
(add-hook 'rst-mode-hook 'turn-on-orgtbl)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Deft
;; http://jblevins.org/projects/deft/
(setq deft-directory "~/Dropbox/Notes")
(setq deft-use-filename-as-title t)
;; TODO include "taskpaper" ?
(setq deft-extensions '("md" "markdown" "txt" "text" "org"))
(setq deft-text-mode 'markdown-mode)
(global-set-key (kbd "<f8>") 'deft)
(setq deft-recursive t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ helm
(require 'helm)
(require 'helm-config nil t)

;; set helm command prefix as "C-c c"
(global-set-key (kbd "C-c c") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; buffer switching
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;; find-file
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; use ack instead of grep on find-file
(when (executable-find "ack")
  (setq helm-grep-default-command "ack -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack -H --no-group --no-color %e %p %f"))
;; helm-M-x
(global-set-key (kbd "M-x") 'helm-M-x)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

;; rebind tab to do persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; make TAB works in terminal
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; list actions using C-z
(define-key helm-map (kbd "C-z")  'helm-select-action)
;;
(setq helm-ff-file-name-history-use-recentf t)
;; killing history
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; occur
(global-set-key (kbd "C-c c o") 'helm-occur)

;; google suggest
(global-set-key (kbd "C-c c g") 'helm-google-suggest)

;; all-mark-ring
(global-set-key (kbd "C-c c SPC") 'helm-all-mark-rings)

;; auto-resize
(helm-autoresize-mode t)

;; fuzzy-match
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(setq helm-M-x-fuzzy-match t)
(setq helm-locate-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

(helm-mode 1)

(when (require 'helm-descbinds)
  (helm-descbinds-mode 1)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Projectile
;; enable projectile + helm!
;(projectile-global-mode)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; ag
;; (setq ag-executable "/usr/local/bin/rg")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Emacs server
(when (require 'server)
  (unless (server-running-p)
    (server-start))
  ;;(defun iconify-emacs-when-server-is-done ()
  ;; (unless server-clients (iconify-frame)))
  ;;(add-hook 'server-done-hook 'ns-do-hide-emacs)
  (global-set-key (kbd "C-x C-c") 'server-edit)
  (defalias 'exit 'save-bufferes-kill-emacs)
  )
(put 'upcase-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ gtag and helm
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'web-mode-hook 'helm-gtags-mode)
(add-hook 'js-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key global-map (kbd "<s-mouse-1>") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)


(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

;; user site local
(load (expand-file-name "local.el" user-emacs-directory) 'no-error)
