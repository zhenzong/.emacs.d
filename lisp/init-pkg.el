;; exec-path-from-shell
;; see: https://github.com/purcell/exec-path-from-shell
;; see: http://blog.galeo.me/path-environment-variable-on-mac-os-x-emacs-app.html
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; slime
(setq inferior-lisp-program LISP-PROGRAM-PATH)
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
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")

;; color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-matrix)
(color-theme-subtle-hacker)
;;(color-theme-dark-blue2)
;;(color-theme-dark-green)

;; web
(require 'web-mode)
(add-auto-mode 'web-mode "\\.html?\\'" "\\.[c|le]ss\\'" "\\.js[x]\\'")
;; template setting
(define-auto-insert "\.jsx" "jsx-template.jsx")
(define-auto-insert "\.html" "html-template.html")
(add-to-list 'auto-insert-alist '(("\\.jsx\\'" . "Facebook jsx") . ["jsx-template.jsx" my/auto-insert-yas-expand]))
(add-to-list 'auto-insert-alist '(("\\.html\\'" . "html") . ["html-template.html" my/auto-insert-yas-expand]))

;; python
(define-auto-insert "\.py" "python-template.py")
;;; 设置PYTHONPATH变量解决C-c C-z打开Python REPL没有正确路径的问题
;;; 设置PATH变量解决elpy-config中Syntax Checker没有发现flake8的问题
(exec-path-from-shell-copy-env "PYTHONPATH")
(add-to-list 'auto-insert-alist '(("\\.py" . "python") . ["python-template.py" my/auto-insert-yas-expand]))
(require 'elpy nil t)
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
;; 有时候啊，项目不是你一个人在开发的时候，为了不修改别人的，还是把这个关掉把
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;; 不知道默认的为什么不管用，自己重新绑定
;; 好像lisp mode里M-,也不管用
(define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)
;; see: https://github.com/jorgenschaefer/elpy/wiki/FAQ#q-how-to-solve-company-yasnippet-conflicts
(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))
(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))
;; see: https://github.com/jorgenschaefer/elpy/issues/887
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))
(setq python-shell-completion-native-enable nil)

;; text and font
(require 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; org
;;; Global set #+OPTIONS: ^:nil
(setq-default org-use-sub-superscripts nil)
(add-hook 'org-mode-hook
          (lambda ()
            (set-face-attribute 'org-level-1 nil :height 1.2)
            (set-face-attribute 'org-level-2 nil :height 1.2)
            (set-face-attribute 'org-level-3 nil :height 1.2)
            (set-face-attribute 'org-level-4 nil :height 1.2)))

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'init-pkg)
