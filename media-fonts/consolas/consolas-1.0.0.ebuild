# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Consolas font for my personal use only"
HOMEPAGE="https://learn.microsoft.com/en-us/typography/font-list/consolas"
SRC_URI="${P}.tar.xz"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"
FONT_SUFFIX="ttf"
