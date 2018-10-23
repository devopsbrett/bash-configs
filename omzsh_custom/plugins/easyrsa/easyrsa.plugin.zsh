# Plugin for highlighting file content
# Plugin highlights file content based on the filename extension.
# If no highlighting method supported for given extension then it tries
# guess it by looking for file content.

alias easyrsa='easy_rsa'

easy_rsa() {
	export EASYRSA_OPENSSL="/usr/local/Cellar/openssl@1.1/1.1.0f/bin/openssl"
	/Users/brettmack/personal/easy-rsa/easyrsa3/easyrsa $@
}
