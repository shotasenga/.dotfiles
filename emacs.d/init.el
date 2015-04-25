;; -*- mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ----------------------------------------------------------------------
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; add load-path
;; if add directory more than one -> (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ package
(when (require 'package nil t)
  ;; add repositry MELPA
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/"))
  ;; add repositry ELPA
  (add-to-list 'package-archives
               '("ELPA" . "http://tromey.com/elpa/"))
  ;; Marmalade
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ defaullt packages forked from http://www.aaronbedra.com/emacs.d/
(defvar my:packages '(ace-jump-mode
                      async
                      auto-complete
                      auto-complete-c-headers
                      autopair
                      blank-mode
                      coffee-mode
                      deft
                      flymake-cursor
                      flymake-easy
                      flymake-google-cpplint
                      git-commit-mode
                      git-rebase-mode
                      go-mode
                      haml-mode
                      helm
                      iedit
                      magit
                      markdown-mode
                      migemo
                      php-mode
                      popup
                      redo+
                      web-mode
                      yaml-mode
                      yasnippet
                      nyan-mode
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Encoding
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Global key set
; auto indent
(global-set-key (kbd "RET") 'newline-and-indent)
; C-h as delete
(keyboard-translate ?\C-h ?\C-?)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ theme & visual
(load-theme 'wombat t)
(setq column-number-mode t)
;; higlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3a3a3a")
(set-face-foreground 'highlight nil)
(set-face-underline 'highlight nil)

;; when runing with window system
(when window-system
  ;; hide each bars
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)

  ;; full screen (for MacBook Air 13inch display)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 202 56)
  )
;; frame-title
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))
;; default buffer
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Nyan-mode
(nyan-mode 1)
(nyan-start-animation)

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
                    :family "Menlo" ;; font
                    :height 120)    ;; font size

  ;; japanese
  (set-fontset-font
 nil 'japanese-jisx0208
 ;; (font-spec :family "Hiragino Mincho Pro")) ;; font
 (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font
  (setq face-font-rescale-alist
	'((".*Hiragino_Mincho_pro.*" . 1.2)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ undo/redo
(when (require 'redo+ nil t)
  (setq undo-no-redo t)
  (global-set-key (kbd "C-?") 'redo)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ indentation
;; indent size and type
(setq tab-width 4)
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
;; @ whitespace
;; for whitespace-mode
(require 'whitespace)
;; see whitespace.el for more details
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
;;      '((space-mark ?\u3000 [?\u25a1]) ; zenkaku-whitespace to white-square-mark
      '((space-mark 32 [46] [46]) ; 32 SPACE, 183 MIDDLE DOT ·, 46 FULL STOP .
        (newline-mark [10 13] [182]) ; 10 LINE FEED
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
;(setq whitespace-space-regexp "\\(\u3000+\\)")
;; 	aaa <- this line tabbed
(set-face-foreground 'whitespace-tab "#505050")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#505050")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)

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
;; @ ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-;") 'ace-jump-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ i-edit
(define-key global-map (kbd "C-c ;") 'iedit-mode)


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
;; @ Coffee
(defun coffee-custom ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 4))
(add-hook 'coffee-mode-hook 'coffee-custom)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-hook 'markdown-mode-hook (lambda () (visual-line-mode t)))
;; (setq markdown-command "pandoc --smart -f markdown -t html")
;; (setq markdown-css-path (expand-file-name "markdown.css" abedra/vendor-dir))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ web-mode
(when (require 'web-mode)
  ;; extensions
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
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
;; @ html-mode
(add-hook 'html-mode-hook
  (lambda ()
    ;; Default indentation is usually 2 spaces, changing to 4.
    (set (make-local-variable 'sgml-basic-offset) 4)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ PHP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Deft
(setq deft-directory "~/Dropbox/deft")
(setq deft-use-filename-as-title t)
(setq deft-extension "md")
(setq deft-text-mode 'markdown-mode)
(global-set-key (kbd "<f8>") 'deft)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ helm
(when (require 'helm-config nil t)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
  (helm-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ C/C++
; auto complete headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.1.0/include"))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; google style guide
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c++-mode-hook 'my:flymake-google-init)
(add-hook 'c-mode-hook 'my:flymake-google-init)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Emacs server
(when (require 'server)
 (unless (server-running-p)
   (server-start))
 ;;(defun iconify-emacs-when-server-is-done ()
 ;; (unless server-clients (iconify-frame)))
 (add-hook 'server-done-hook 'ns-do-hide-emacs)
 (global-set-key (kbd "C-x C-c") 'server-edit)
 (defalias 'exit 'save-bufferes-kill-emacs)
 )
(put 'upcase-region 'disabled nil)
