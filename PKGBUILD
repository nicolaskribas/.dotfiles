pkgname=('etcfiles-common' 'etcfiles-spillway' 'etcfiles-archbtw')
arch=('x86_64')
pkgrel=0
pkgver=0
install=etcfiles.install
source=('home-ether.network'
	'home-wlan.network'
	'uni-ether.network'
	'uni-wlan.network'
	'dashbinsh.hook'
	'paccache-1.hook'
	'paccache-2.hook'
	'pacman.conf'
	'flatpak-update.service'
	'flatpak-update.timer'
	'locale.conf'
	'locale.gen'
	'sudoers'
	)
md5sums=('SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
)

package_etcfiles-spillway() {
	depends=('etcfiles-common')
	echo 'spillway' | install -Dm0644 /dev/stdin "$pkgdir"/etc/hostname
	install -Dm0644 uni-ether.network "$pkgdir"/etc/systemd/network/20-uni-ether.network
	install -Dm0644 uni-wlan.network "$pkgdir"/etc/systemd/network/20-uni-wlan.network
}

package_etcfiles-archbtw() {
	depends=('etcfiles-common')
	echo 'archbtw' | install -Dm0644 /dev/stdin "$pkgdir"/etc/hostname
	install -Dm0644 home-ether.network "$pkgdir"/etc/systemd/network/20-home-ether.network
	install -Dm0644 home-wlan.network "$pkgdir"/etc/systemd/network/20-home-wlan.network
}

package_etcfiles-common() {
	install -Dm0644 dashbinsh.hook "$pkgdir"/etc/pacman.d/hooks/dashbinsh.hook
	install -Dm0644 paccache-1.hook "$pkgdir"/etc/pacman.d/hooks/paccache-1.hook
	install -Dm0644 paccache-2.hook "$pkgdir"/etc/pacman.d/hooks/paccache-2.hook
	install -Dm0644 pacman.conf "$pkgdir"/etc/pacman.conf

	install -Dm0644 flatpak-update.service "$pkgdir"/etc/systemd/system/flatpak-update.service
	install -Dm0644 flatpak-update.timer "$pkgdir"/etc/systemd/system/flatpak-update.timer

	install -Dm0644 locale.conf "$pkgdir"/etc/locale.conf
	install -Dm0644 locale.gen "$pkgdir"/etc/locale.gen

	install -dm0750 "$pkgdir"/etc/sudoers.d
	install -Dm0440 sudoers "$pkgdir"/etc/sudoers.d/10-defaults
}
