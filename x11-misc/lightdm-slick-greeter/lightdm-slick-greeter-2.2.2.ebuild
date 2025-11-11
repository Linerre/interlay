# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

inherit  gnome2-utils meson python-single-r1 xdg vala

DESCRIPTION="A slick-looking LightDM greeter"
HOMEPAGE="https://github.com/linuxmint/slick-greeter"
SRC_URI="https://github.com/linuxmint/slick-greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/slick-greeter-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	x11-libs/cairo
	media-libs/freetype:2
	x11-libs/gtk+:3
	media-libs/libcanberra
	x11-libs/libXext
	x11-misc/lightdm[vala]
	x11-libs/pixman
	dev-lang/python:*
	x11-libs/xapp
	x11-base/xorg-server
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="
	$(vala_depend)
	dev-util/intltool
	gnome-base/gnome-common
	dev-build/meson
"

src_prepare() {
	default
	vala_setup
}

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

src_install() {
	meson_src_install

	# Rename desktop file exactly like Arch does
	mv "${ED}"/usr/share/xgreeters/slick-greeter.desktop \
		"${ED}"/usr/share/xgreeters/lightdm-slick-greeter.desktop || die
}
