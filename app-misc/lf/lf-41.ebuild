# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion desktop xdg

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"

SRC_URI="
	https://github.com/gokcehan/lf/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Linerre/gentoo-deps/releases/download/${PN}-r${PV}/${PN}-r${PV}-vendor.tar.xz
"
S="${WORKDIR}/${PN}-r${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build -v \
		-buildmode=pie \
		-mod=vendor \
		-ldflags="-compressdwarf=false \
				  -linkmode external \
				  -extldflags '${LDFLAGS}' \
				  -X main.gVersion=r${PV}" \
		-o "${PN}" .
}

src_install() {
	local DOCS=( README.md etc/lfrc.example )

	dobin "${PN}"

	einstalldocs

	doman "${PN}.1"

	# bash & zsh cd script
	insinto "/usr/share/${PN}"
	doins "etc/${PN}cd.sh"

	# bash-completion
	newbashcomp "etc/${PN}.bash" "${PN}"

	# zsh-completion
	newzshcomp "etc/${PN}.zsh" "_${PN}"

	# fish-completion
	dofishcomp "etc/${PN}.fish"
	dofishcomp "etc/${PN}cd.fish"

	domenu "${PN}.desktop"
}
