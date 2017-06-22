(defconst BACKUP-DIR "~/.backups"
  "Define backup directory")
(defconst LISP-PROGRAM-PATH "~/Workspace/Repository/svn/ccl/dx86cl64"
  "Define lisp program path")
(defconst PYTHON "/usr/local/bin/python"
  "Define Python bin path")
(defconst PYTHONPATH
  (funcall (lambda()
             (mapconcat
              'identity
              `(,(getenv "PYTHONPATH")) ;; Add other python path before (getenv ...)
              ":")))
  "Define python paths")

(provide 'init-constants)
