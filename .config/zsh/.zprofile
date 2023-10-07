if [ "$(tty)" = '/dev/tty1' ]; then
	export XDG_CURRENT_DESKTOP=sway
	exec sway 2> .sway.log
fi
