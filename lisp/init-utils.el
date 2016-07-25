;; define some useful function and macro
;; see purcell[https://github.com/purcell/emacs.d]

;; Delete the current file
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
							 (file-name-nondirectory buffer-file-name)))
	(delete-file (buffer-file-name))
	(kill-this-buffer)))

;; Rename the current file
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
		(filename (buffer-file-name)))
	(unless filename
	  (error "Buffer '%s' is not visiting a file!" name))
	(progn
	  (when (file-exists-p filename)
		(rename-file filename new-name 1))
	  (set-visited-file-name new-name)
	  (rename-buffer new-name))))

(defun enable-mode (modes)
  "enable modes"
  (dolist (m modes)
	(funcall m 1)))

(defun disable-mode (modes)
  "disable modes"
  (dolist (m modes)
	(funcall m -1)))

(provide 'init-utils)
