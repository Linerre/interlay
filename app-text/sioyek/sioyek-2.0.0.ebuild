# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="a PDF viewer for research papers and technical books."
HOMEPAGE="https://sioyek.info/"
SRC_URI="https://github.com/ahrm/sioyek/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-text/mupdf
	dev-libs/gumbo
	dev-qt/qtopengl:5
	dev-qt/qtcore:5
	dev-qt/qt3d:5
	media-libs/harfbuzz
	media-libs/jbig2dec
	media-libs/openjpeg
"

BDEPEND="${DEPEND}"

src_prepare() {
	# thanks to aexl from AUR: https://aur.archlinux.org/packages/sioyek
	# eapply --forward --strip=1 "${FILESDIR}/mupdf-1.20.patch"

	default

	# Use system libs instead of the third-party ones
	sed -i 's/-lmupdf-third/-lfreetype -lgumbo -ljbig2dec -lopenjp2 -ljpeg/' \
	pdf_viewer_build_config.pro || die "sed config.pro failed"
	sed -i 's/-lmupdf-threads//' pdf_viewer_build_config.pro || die "sed config.pro failed"
	sed -i '/#define LINUX_STANDARD_PATHS/s/\/\///' pdf_viewer/main.cpp || die "sed main.cpp failed"
}

src_compile() {
	qmake5 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro || die "qmake failed"
	emake
}

src_install() {
	dobin sioyek

	insinto /usr/share/icons/${PN}
	doins resources/sioyek-icon-linux.png

	domenu resources/${PN}.desktop

	insinto /usr/share/${PN}/shaders
	doins pdf_viewer/shaders/*

	insinto /etc/${PN}
	doins pdf_viewer/keys.config
	doins pdf_viewer/prefs.config

	dodoc resources/${PN}.1
	insinto /usr/share/${PN}
	doins tutorial.pdf
}

pkg_postinst() {
	elog "A PDF tutorial is placed in /usr/share/${PN}"
	elog
	elog "Default configs for keybindings and preferences are "
	elog "/etc/${PN}/keys.config and /etc/${PN}/prefs.config respectively."
	elog
	elog "For more info about configuration, visit "
	elog "https://sioyek-documentation.readthedocs.io/en/latest/configuration.html"
}
