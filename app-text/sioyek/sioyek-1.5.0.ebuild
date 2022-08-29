# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a PDF viewer for research papers and technical books."
HOMEPAGE="https://sioyek.info/"
SRC_URI="https://github.com/ahrm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

license="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

#FIXME: need >=mupdf-1.20 and a patch
DEPEND="
	app-text/mupdf
	dev-libs/gumbo
	dev-qt/qtopengl:5
	dev-qt/qtcore:5
	dev-qt/qt3d:5
	media-libs/harfbuzz
	media-libs/jbig2dec
	media-libs/openjpeg
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i '/qmake/s/"CONFIG+=linux_app_image"//' "${S}"/build_linux.sh || die
	sed -i 's/qmake/qmake5/' "${S}"/build_linux.sh || die
	sed -i 's/-lmupdf-third//' pdf_viewer_build_config.pro || die

}

src_compile() {
	#FIXME: set up building instructions here to use emake and system mupdf lib
	./build_linux.sh || die
}

src_install() {
	#FIXME: install icon image, doc (tutorial.pdf) and configs
}
