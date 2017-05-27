(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))
(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))
(message "Powering up... Be patient, Master %s!" current-user)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

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
		   web-mode
		   yasnippet
		   elpy))
  (when (not (package-installed-p p))
	(package-install p)))
(add-hook 'after-init-hook (lambda () (require 'init-pkg)))
