(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))
(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))
(message "Powering up... Be patient, Master %s!" current-user)
(add-to-list 'load-path (expand-file-name "lisp"))

;; install and setup useful package
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("popkit" . "http://elpa.popkit.org/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar my-packages
  '(slime
	auto-complete
	web-mode
	yasnippet))

(dolist (p my-packages)
  (when (not (package-installed-p p))
	(package-install p)))
(add-hook 'after-init-hook (lambda () (require 'init-pkg)))

;; utils
(require 'init-utils)

;; general setting
(require 'init-general)
