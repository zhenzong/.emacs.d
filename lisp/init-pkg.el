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
(define-key yas-minor-mode-map (kbd "C-c C-i") 'yas-insert-snippet)

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
(define-auto-insert "\.jsx" ["jsx-template.jsx" my/auto-insert-yas-expand])
(define-auto-insert "\.html" ["html-template.html" my/auto-insert-yas-expand])

;; python
(define-auto-insert "test_.*\.py" ["test-python-template.py" my/auto-insert-yas-expand])
(define-auto-insert ".*_test\.py" ["test-python-template.py" my/auto-insert-yas-expand])
(define-auto-insert "__init__\.py" ["init-python-template.py" my/auto-insert-yas-expand])
(define-auto-insert "\.py" ["python-template.py" my/auto-insert-yas-expand] t)
;;; 设置PYTHONPATH变量解决C-c C-z打开Python REPL没有正确路径的问题
;;; 设置PATH变量解决elpy-config中Syntax Checker没有发现flake8的问题
(exec-path-from-shell-copy-env "PYTHONPATH")
(require 'elpy nil t)
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
;; 有时候啊，项目不是你一个人在开发的时候，为了不修改别人的，还是把这个关掉把
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
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

;; neotree
(require 'neotree)
(defun neotree-locate-file (project-dir file-name)
  "Open NeoTree and loocation file"
  (if project-dir
      (progn
        (neotree-dir project-dir)
        (neotree-find file-name))
    (message "Could not find git project root.")))
(defun neotree-ffip-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
    (neotree-locate-file project-dir file-name)))
(defun neotree-current-project-dir ()
  "Open NeoTree using the current root."
  (interactive)
  (let ((project-dir (file-name-directory (buffer-file-name)))
        (file-name (buffer-file-name)))
    (neotree-locate-file project-dir file-name)))

(global-set-key [f7] 'neotree-toggle)
(global-set-key [f8] 'neotree-ffip-project-dir)
(global-set-key [f9] 'neotree-current-project-dir)

(provide 'init-pkg)
