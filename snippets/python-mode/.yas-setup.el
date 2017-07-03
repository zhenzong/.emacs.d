;;; .yas-setup.el --- Utility functions used by the snippets  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  zhenzong

;; Author: zhenzong <zhenzong.peng@icloud.com>

(defun get-test-file-name ()
  "获得测试文件的真实名称，eg: test_hello则返回hello，world_test则返回world"
  (let ((name (file-name-base)))
    (when (or (string-prefix-p "test_" name)
               (string-suffix-p "_test" name))
      (if (string-prefix-p "test_" name)
          (substring name 5 (length name))
        (substring name 0 (- (length name) 5))))))

;;; .yas-setup.el ends here
