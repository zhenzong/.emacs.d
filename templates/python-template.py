# coding: utf-8
# @author `(getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))`
# @date `(format-time-string "%A, %e %B %Y.")`

def ${1: `(let ((name (file-name-nondirectory (buffer-file-name))))(substring name 0 (- (length name) 3)))`}():
    $2
    pass

if __name__ == '__main__':
    $1()
