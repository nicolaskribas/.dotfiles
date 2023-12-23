pkgname=('etcfiles-common' 'etcfiles-spillway' 'etcfiles-archbtw')
arch=('x86_64')
pkgrel=0
pkgver=0
source=('dhcp-eth-domain.network'
	'dhcp-eth-dnssec.network'
	'locale.conf'
	'locale.gen'
	'sudoers'
	)
md5sums=('SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
)

package_etcfiles-spillway() {
	depends=('etcfiles-common')
	echo 'spillway' | install -Dm0644 /dev/stdin "$pkgdir"/etc/hostname
	install -Dm0644 dhcp-eth-domain.network "$pkgdir"/etc/systemd/network/20-dhcp-ethernet.network
}

package_etcfiles-archbtw() {
	depends=('etcfiles-common')
	echo 'archbtw' | install -Dm0644 /dev/stdin "$pkgdir"/etc/hostname
	install -Dm0644 dhcp-eth-dnssec.network "$pkgdir"/etc/systemd/network/20-dhcp-ethernet.network
}

package_etcfiles-common() {
	install -Dm0644 locale.conf "$pkgdir"/etc/locale.conf
	install -Dm0644 locale.gen "$pkgdir"/etc/locale.gen

	install -dm0750 "$pkgdir"/etc/sudoers.d
	install -Dm0440 sudoers "$pkgdir"/etc/sudoers.d/10-defaults

	ln -sf /usr/share/zoneinfo/America/Sao_Paulo "$pkgdir"/etc/localtime
	ln -sf /run/systemd/resolve/stub-resolv.conf "$pkgdir"/etc/resolv.conf
}
