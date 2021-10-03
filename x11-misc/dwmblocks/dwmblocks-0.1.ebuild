# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit savedconfig toolchain-funcs

DESCRIPTION="Modular status bar for dwm written in c."
HOMEPAGE="https://github.com/torrinfail/dwmblocks"
SRC_URI="https://github.com/Linerre/dwmblocks/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="savedconfig"

RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND=""

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default

	# No need to modify the Makefile
	#sed -i -e 's/^.*cp blocks.def.h.*$//' \
	#	Makefile || die

	restore_config config.h
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	# No README or doc to install
	#dodoc README

	save_config config.h
}
