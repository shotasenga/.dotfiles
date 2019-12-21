;; -*- mode: Emacs-Lisp ; Coding: utf-8 -*-
;; TODOs
;; - setup yasnipet (shell-command "open https://github.com/magnars/.emacs.d" )
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
                      ace-jump-mode
                      ag
                      async
                      auto-complete
                      auto-complete-c-headers
                      autopair
                      blank-mode
                      coffee-mode
                      dash
                      deft
                      emmet-mode
                      epl
                      exec-path-from-shell
                      expand-region
                      fish-mode
                      flymake-cursor
                      flymake-easy
                      flymake-google-cpplint
                      ggtags
                      git-commit
                      git-gutter
                      go-mode
                      haml-mode
                      helm
                      helm-core
                      helm-descbinds
                      helm-emmet
                      helm-gtags
                      helm-projectile
                      highlight-indentation
                      iedit
                      jade-mode
                      js2-mode
                      json-mode
                      json-reformat
                      json-snatcher
                      magit
                      magit-popup
                      markdown-mode
                      multiple-cursors
                      php-mode
                      pkg-info
                      popup
                      powerline
                      projectile
                      rainbow-mode
                      redo+
                      restclient
                      rich-minority
                      sass-mode
                      slime
                      stylus-mode
                      sws-mode
                      web-mode
                      with-editor
                      yaml-mode
                      yasnippet
                      )
  "Default packages")

(defun my:packages-installed-p ()
  (loop for pkg in my:packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (my:packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my:packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))


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
;; git-gutter
(global-git-gutter-mode +1)

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
;; other-window
(global-set-key (kbd "C-<tab>") 'other-window)
;; move windows <SHIFT>-<ARROW>
(windmove-default-keybindings)
(setq windmoove-wrap-around t)
;; resize window M-<ARROW>
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<right>") 'shrink-window-horizontally)
;; magit
(global-set-key (kbd "C-x g") 'magit-status)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ theme & visual
;; show line numbers
(global-linum-mode t)
(setq linum-format "%5d ")
(setq column-number-mode t)

;; higlight current line
(global-linum-mode 0)
(global-hl-line-mode nil)
;;(set-face-background 'hl-line "#3a3a3a")
;;(set-face-foreground 'highlight nil)
;;(set-face-underline 'highlight nil)

;; powerline
;(setq ns-use-srgb-colorspace nil)
(require 'powerline)
(powerline-default-theme)


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
;; @ undo/redo
(when (require 'redo+ nil t)
  (setq undo-no-redo t)
  (global-set-key (kbd "C-?") 'redo)
  )

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
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#10505D")
(set-face-background 'highlight-indentation-current-column-face "#3f727d")
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(add-hook 'js2-mode-hook 'highlight-indentation-mode)
(add-hook 'ruby-mode-hook 'highlight-indentation-mode)
(add-hook 'sass-mode-hook 'highlight-indentation-mode)
(add-hook 'jade-mode-hook 'highlight-indentation-mode)
(add-hook 'stylus-mode-hook 'highlight-indentation-mode)
(add-hook 'coffee-mode-hook 'highlight-indentation-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-indentation-mode)
(add-hook 'web-mode-hook 'highlight-indentation-mode)


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
;; @ isearch region
(defadvice isearch-mode
    (around isearch-mode-default-string
            (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Rect
;; key-bindings -> http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)


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
;; @ auto complition
(when (require 'auto-complete-config nil t)
  (setq ac-use-menu-map t)
  (setq popup-use-optimized-column-computation nil)
  (ac-config-default)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ yasnippet
(require 'yasnippet)
(yas-global-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ i-edit
(define-key global-map (kbd "C-c ;") 'iedit-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-;") 'ace-jump-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ eshell
;; via http://syohex.hatenablog.com/entry/20130718/1374154709
;;(let ((envs '("PATH" "ANDROID_HOME" "GOROOT" "GOPATH")))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Ruby
(add-hook 'ruby-mode-hook
          (lambda ()
            (autopair-mode)))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfle" . ruby-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-hook 'markdown-mode-hook (lambda () (visual-line-mode t)))
(setq markdown-open-command "/usr/bin/marked")
(setq markdown-command "/usr/local/bin/pandoc")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ web-mode
(when (require 'web-mode)
  ;; extensions
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

  ;; engine
  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml\\'")
          ("ruby"  . "\\.erb\\."))
        )
  ;; indent
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-block-padding 0)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ emmet-mode
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode)
(add-hook 'html-mode-hook  'emmet-mode)
(add-hook 'js2-jsx-mode-hook  'emmet-mode)
(add-hook 'rjsx-mode-hook  'emmet-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ css-mode
(setq css-indent-offset 2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ js2-mode
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.babelrc$" . js2-mode))
(setq js2-basic-offset 2)
(setq sgml-basic-offset 2)
(setq js2-strict-missing-semi-warning nil)
(add-hook 'js-mode-hook 'js2-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ jade-mode
(add-to-list 'auto-mode-alist '("\\.pug$" . jade-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ html-mode
(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set (make-local-variable 'sgml-basic-offset) 4)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ PHP
(add-hook 'php-mode-user-hook 'semantic-default-java-setup)
(add-hook 'php-mode-user-hook
          (lambda ()
            (setq imenu-create-index-function
                  'semantic-create-imenu-index)
            ))


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
;; @ expand-region
;; bind keys
(global-set-key (kbd "C-2") 'er/expand-region)
(global-set-key (kbd "C-@") 'er/contract-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ multiple-cursors
;; bind keys
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)


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
(projectile-global-mode)
(setq projectile-completion-system 'helm)
;;(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; ag
;; (setq ag-executable "/usr/local/bin/rg")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ C/C++
;; auto complete headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.1.0/include"))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; google style guide
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
  )
(add-hook 'c++-mode-hook 'my:flymake-google-init)
(add-hook 'c-mode-hook 'my:flymake-google-init)

;; semantic
(semantic-mode 1)
(global-semantic-idle-scheduler-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Lisp environment ..?
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "sbcl")
;;(slime-setup '(slime-repl slime-fancy slime-banner))
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)
