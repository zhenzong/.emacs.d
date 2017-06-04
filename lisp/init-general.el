;; encoding
(setenv "LANG" "zh_CN.UTF-8")
(setenv "LC_ALL" "zh_CN.UTF-8")
(set-language-environment "UTF-8")
(set-locale-environment)
(prefer-coding-system 'utf-8-unix)

;; variable
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'tab-width 4)
(set-default 'kill-whole-line t)
(set-default 'show-trailing-whitespace t)
(set-default 'inhibit-startup-screen t)
(setq
 backup-directory-alist '(("." . "~/.backups"))
 delete-old-versions t
 kept-new-versions 3
 kept-old-versions 2
 version-control t)
(setq
 desktop-path (list user-emacs-directory)
 desktop-auto-save-timeout 600)

;; hook
(add-hook 'before-save-hook 'whitespace-cleanup)
;; 不知道为什么我设置（desktop-save-mode）启动时不自动加载
;; 启动后调用(desktop-read)
(add-hook 'window-setup-hook 'desktop-read)

;; enable and disable some mode
(enable-mode
 '(column-number-mode
   show-paren-mode
   size-indication-mode
   auto-insert-mode
   global-linum-mode
   global-hi-lock-mode
   global-hl-line-mode
   semantic-mode
   electric-indent-mode
   electric-pair-mode
   subword-mode
   desktop-save-mode))

(disable-mode
 '(scroll-bar-mode
   tool-bar-mode))

(provide 'init-general)
