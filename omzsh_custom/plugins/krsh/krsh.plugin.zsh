function _krshStatus() {
	cat .ssh/config | grep -i 'kryptonite global' | awk '{ print $4 }'
}

function _krsh() {
	MYVAR="$(cat ~/.ssh/config | grep -i -e "[0-9a-z-A-Z]\+ #####$")]}"
	echo $MYVAR
}

alias krsh=_krsh

