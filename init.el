(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))
(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))
(message "Powering up... Be patient, Master %s!" current-user)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; variables
(require 'init-constants)

;; utils
(require 'init-utils)

;; general setting
(require 'init-general)

;; install and setup useful package
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("popkit" . "http://elpa.popkit.org/packages/")))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p
		 '(slime
		   auto-complete
		   yasnippet
		   color-theme
		   web-mode
		   elpy
		   flycheck
		   py-autopep8
		   default-text-scale
		   session))
  (unless (package-installed-p p)
	(package-install p)))
(add-hook 'after-init-hook (lambda () (require 'init-pkg)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 ;; 当你当电脑上安装有多个python的时候，
 ;; 您可能需要设置以下三个变量，避免出现elpy配置问题
 ;; 检查elpy配置使用 M-x elpy-config
 '(python-shell-interpreter PYTHON-PATH)
 '(pyvenv-virtualenvwrapper-python PYTHON-PATH)
 '(elpy-rpc-python-command PYTHON-PATH)
 '(safe-local-variable-values (quote ((no-byte-compile t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
