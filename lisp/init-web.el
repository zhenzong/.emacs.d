;; web
(require-package 'web-mode)
(after-load 'web-mode
  (require 'web-mode)
  (add-auto-mode 'web-mode "\\.html?\\'" "\\.[c|le]ss\\'" "\\.js[x]\\'"))

(provide 'init-web)
