/**
 *
 * @date `(format-time-string "%A, %e %B %Y.")`
 * @author `(getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))`
 *
 */
import React from 'react';

var ${1: `(let ((name (file-name-nondirectory (buffer-file-name))))(substring name 0 (- (length name) 4)))`$(capitalize yas-text)} = React.createClass({

	render: function() {
			$2
			return (
				   $3
			);
	}
});

module.exports = $1;
