pkgname=(etcfiles)

arch=('x86_64')

pkgrel=1
pkgver=0.0.1

source=('20-dhcp-ethernet.network')

package_etcfiles() {
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo "$pkgdir"/etc/localtime

	install -Dm0644 20-dhcp-ethernet.network "$pkgdir"/etc/systemd/network/20-dhcp-ethernet.network
}
