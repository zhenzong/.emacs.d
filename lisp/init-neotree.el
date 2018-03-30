;; neotree
(require-package 'neotree)

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

(provide 'init-neotree)
