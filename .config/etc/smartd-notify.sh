#!/bin/sh
# run by smartd (as root) when a drive reports a problem: show it as a critical
# notification in every logged-in user session

for bus in /run/user/*/bus; do
	[ -S "${bus}" ] || continue
	runuser -u "$(stat -c %U "${bus}")" -- env DBUS_SESSION_BUS_ADDRESS="unix:path=${bus}" \
		notify-send --urgency=critical --app-name=smartd "SMART: ${SMARTD_DEVICE}" "${SMARTD_MESSAGE}"
done
