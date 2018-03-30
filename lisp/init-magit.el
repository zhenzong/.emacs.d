;; magit
(require-package 'magit)
(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'init-magit)
