# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

MY_PN=LXGWMarkerGothic
DESCRIPTION="A Simplified Chinese font derived from Tanugo"
HOMEPAGE="https://fonts.google.com/specimen/Roboto+Mono"
SRC_URI="https://github.com/lxgw/${MY_PN}/releases/download/v${PV}/${MY_PN}-Regular.ttf"
LICENSE="OFL-1.1"
KEYWORDS="~amd64"
SLOT="0"
S="${DISTDIR}"
FONT_SUFFIX="ttf"
