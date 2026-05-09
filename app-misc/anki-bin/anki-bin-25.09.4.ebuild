# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=no			# Use the included uv.amd64 as the build backend
PYTHON_COMPAT=( python3_{11..14} )

inherit desktop distutils-r1 optfeature pax-utils unpacker xdg

MY_PV=25.09
MY_PN="anki-launcher-${MY_PV}-linux"
DESCRIPTION="Smart spaced repetition flashcard program"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	https://github.com/ankitects/anki/releases/download/${MY_PV}/${MY_PN}.tar.zst -> ${P}.tar.zst
"
S="${WORKDIR}/${MY_PN}"

LICENSE="AGPL-3+ BSD public-domain CC0-1.0 CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	app-arch/zstd
	app-misc/ca-certificates
	dev-db/sqlite:3
	dev-libs/nss
	dev-util/desktop-file-utils
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-misc/shared-mime-info
"

RDEPEND="${DEPEND}"

QA_PREBUILT="/opt/${PN}/*"

src_unpack() {
	unpacker ${P}.tar.zst
}

src_install() {
	local destdir="/opt/${PN}"
	dodir "${destdir}"
	cp -a . "${ED}${destdir}" || die "Failed to install anki tree"

	# Set proper permission
	for b in anki launcher.amd64 uv.amd64 ; do
		[[ -f "${ED}${destdir}/${b}" ]] || die "Required ${b} not found"
		fperms +x "${destdir}/${b}"
		pax-mark m "${ED}${destdir}/${b}"
	done

	doicon anki.{png,xpm}
	doman anki.1
	domenu anki.desktop
	insinto /usr/share/mime/packages
	doins anki.xml
	dosym "${destdir}/anki" /usr/bin/anki
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "LaTeX in cards" "app-text/texlive[extra] app-text/dvipng"
	optfeature "sound support" media-video/mpv media-video/mplayer
	optfeature "recording support" "media-sound/lame[frontend] dev-python/pyqt6[multimedia]"
	optfeature "faster database operations" dev-python/orjson
}
