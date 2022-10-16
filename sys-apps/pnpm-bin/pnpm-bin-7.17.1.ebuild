# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast, disk space efficient package manager"
HOMEPAGE="https://pnpm.io/"
SRC_URI="https://registry.npmjs.org/@pnpm/linux-x64/-/linux-x64-${PV}.tgz -> ${P}.tgz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="MIT"

DEPEND="
	net-libs/nodejs
	!sys-apps/pnpm
"

S="${WORKDIR}"/package

src_install() {
	dobin pnpm
}

pkg_postinst() {
	elog "Refer to pnpm's doc for setting up and configuring pnpm:"
	elog "	https://pnpm.io/pnpm-cli"
}
