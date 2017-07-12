# coding: utf-8
# @author `(getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))`
# @date `(format-time-string "%A, %e %B %Y.")`
import unittest
from unittest import TestCase


class ${1:`(get-test-file-name)`$(capitalize yas/text)}Test(TestCase):
    """Documentation for $1Test
    """

    def setUp(self):
        $2
        pass

    def tearDown(self):
        $3
        pass

    def test_`(get-test-file-name)`(self):
        $4
        pass


if __name__ == '__main__':
    unittest.main()
