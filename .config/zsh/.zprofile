[ "$(tty)" = '/dev/tty1' ] && WLR_RENDERER=vulkan WLR_NO_HARDWARE_CURSORS=1 XWAYLAND_NO_GLAMOR=1 exec systemd-cat --identifier=sway sway --verbose --unsupported-gpu
