;; exec-path-from-shell
;; see: https://github.com/purcell/exec-path-from-shell
;; see: http://blog.galeo.me/path-environment-variable-on-mac-os-x-emacs-app.html
(require-package 'exec-path-from-shell)
(require 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)
