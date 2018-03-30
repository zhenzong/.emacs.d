;; encoding
(setenv "LANG" "zh_CN.UTF-8")
(setenv "LC_ALL" "zh_CN.UTF-8")
(set-language-environment "UTF-8")
(set-locale-environment)
(prefer-coding-system 'utf-8-unix)

;; variable
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'indent-tabs-mode nil)
(set-default 'kill-whole-line t)
(set-default 'show-trailing-whitespace t)
(set-default 'inhibit-startup-screen t)
(setq
 backup-directory-alist `(("." . "~/.backups"))
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
;; 不知道为什么又可以使用了
;; (add-hook 'window-setup-hook 'desktop-read)

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
 '(
   ;;scroll-bar-mode
   tool-bar-mode
   menu-bar-mode))

;; show file name
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name)))
(global-set-key (kbd "C-c f") 'show-file-name)

;; buffer menu
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(defun sort-buffers ()
  "Put the buffer list in alphabetical order."
  (interactive)
  (dolist (buff (buffer-list-sorted)) (bury-buffer buff))
  (when (interactive-p) (list-buffers)))
(defun buffer-list-sorted ()
  (sort (buffer-list)
        (function
         (lambda (a b)
           (let ((name-a (downcase (buffer-name a)))
                 (name-b (downcase (buffer-name b))))
             (cond ((string-prefix-p "*" name-a) -1)
                   ((string-prefix-p "*" name-b) 1)
                   (t (string< name-a name-b))))))))
(global-set-key (kbd "C-c C-s") 'sort-buffers)

;; code comment
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)

(provide 'init-general)
