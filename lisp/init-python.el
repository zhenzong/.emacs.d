;; python
(require-package 'elpy)
(require-package 'py-autopep8)
(require-package 'flycheck)
(require 'elpy)
(require 'py-autopep8)
(require 'flycheck)

(elpy-enable)
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)

;;; 设置PYTHONPATH变量解决C-c C-z打开Python REPL没有正确路径的问题
;;; 设置PATH变量解决elpy-config中Syntax Checker没有发现flake8的问题
(exec-path-from-shell-copy-env "PYTHONPATH")

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

(defconst PYTHON-BIN-PATH "/usr/local/bin/python")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-rpc-python-command PYTHON-BIN-PATH)
 '(python-shell-interpreter PYTHON-BIN-PATH)
 '(python-shell-prompt-detect-enabled nil)
 '(python-shell-prompt-detect-failure-warning nil)
 '(pyvenv-virtualenvwrapper-python PYTHON-BIN-PATH))

(provide 'init-python)
