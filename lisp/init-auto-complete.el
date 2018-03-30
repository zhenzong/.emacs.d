;; auto-complete
(require-package 'auto-complete)
(require-package 'yasnippet)
(require 'auto-complete-config)
(require 'yasnippet)

;; auto-insert and yasnippet
(enable-mode '(auto-insert-mode yas-global-mode))

(defun my/auto-insert-yas-expand()
  "Replace text in yasnippet template."
  (yas/expand-snippet (buffer-string) (point-min) (point-max)))
(defvar template-dir "~/.emacs.d/templates")

(ac-config-default)
(setq ac-ignore-case nil)
(setq ac-auto-show-menu 0.4)
(setq auto-insert-query nil)
(setq auto-insert-directory template-dir)
(add-to-list 'yas-snippet-dirs template-dir)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(define-key yas-minor-mode-map (kbd "C-c C-i") 'yas-insert-snippet)

;; web
(define-auto-insert "\.jsx" ["jsx-template.jsx" my/auto-insert-yas-expand])
(define-auto-insert "\.html" ["html-template.html" my/auto-insert-yas-expand])

;; python
(define-auto-insert "\.py" ["python-template.py" my/auto-insert-yas-expand] t)

(provide 'init-auto-complete)
