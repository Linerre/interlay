# Copyright 1999-2025 Gentoo Go Overlay Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature go-module

DESCRIPTION="Load and unload environment variables depending on the current directory."
HOMEPAGE="http://direnv.net"
SRC_URI="
	https://github.com/direnv/direnv/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Linerre/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="
	>=dev-lang/go-1.24
	doc? ( dev-go/go-md2man )
"

DEPEND="${BDEPEND}"

RESTRICT="test"
DOCS=( {CHANGELOG,README}.md )

src_compile() {
	local go_ldflags="-X 'main.version=${PV} (Gentoo)'"
	go_ldflags+=" -X 'main.buildTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"

	ego build -o "${PN}" -ldflags "${go_ldflags}"

	if use doc; then
		emake man
	fi
}

src_install() {
	dobin "${PN}"

	if use doc; then
		doman man/*.1
	fi
}

pkg_postinst() {
	elog "Use 'man 1 direnv' to check how to hook direnv to your shell."
	optfeature "To run the test scripts:" dev-util/shellcheck  dev-util/shellcheck-bin
}
