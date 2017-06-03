;; slime
(setq inferior-lisp-program "~/Workspace/Repository/svn/ccl/dx86cl64")
(require 'slime-autoloads)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(setq ac-auto-show-menu 0.4)

;; auto-insert and yasnippet
(enable-mode '(auto-insert-mode yas-global-mode))
(defun my/auto-insert-yas-expand()
  "Replace text in yasnippet template."
  (yas/expand-snippet (buffer-string) (point-min) (point-max)))
(defvar template-dir "~/.emacs.d/templates")
(setq auto-insert-query nil)
(setq auto-insert-directory template-dir)
(add-to-list 'yas-snippet-dirs template-dir)

;; color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-matrix)
(color-theme-dark-blue2)
(color-theme-dark-green)

;; web
(require 'web-mode)
(add-auto-mode 'web-mode "\\.html?\\'" "\\.[c|le]ss\\'" "\\.js[x]\\'")
;; template setting
(define-auto-insert "\.jsx" "jsx-template.jsx")
(define-auto-insert "\.html" "html-template.html")
(add-to-list 'auto-insert-alist '(("\\.jsx\\'" . "Facebook jsx") . ["jsx-template.jsx" my/auto-insert-yas-expand]))
(add-to-list 'auto-insert-alist '(("\\.html\\'" . "html") . ["html-template.html" my/auto-insert-yas-expand]))

;; python
(require 'elpy nil t)
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(provide 'init-pkg)
