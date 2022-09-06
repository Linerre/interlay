# Copyright 1999-2022 Go Overlay Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="Load and unload environment variables depending on the current directory."
HOMEPAGE="http://direnv.net"
SRC_URI="https://github.com/direvn/direnv/archive/refs/tag/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Linerre/direnv-vendor/archive/refs/tags/v${PV}.tar.gz -> ${P}-vendor.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc shellcheck"

BDEPEND="
	>=dev-lang/go-1.16
	shellcheck? ( dev-util/shellcheck-bin )
"
DEPEND="${BDEPEND}"

src_prepare() {
	mv ../${PN}-vendor-${PV}/vendor ./ || die
	default
}

src_compile() {
	ego build -mod=vendor -v -work -o "bin/direnv" -trimpath -ldflags "-s -w" ./main.go
}

src_install() {
	dobin bin/direnv
	use doc && dodoc docs/*.md
	doman man/direnv.1
	doman man/direnv-stdlib.1
	doman man/direnv.toml.1
}

pkg_postinst() {
	elog "Use 'man 1 direnv' to check how to hook direnv to your shell."
}
