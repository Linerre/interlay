# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEEDED_EMACS=27.1

inherit elisp git-r3

DESCRIPTION="A pakcage that visualizes the undo tree."
HOMEPAGE="https://github.com/casouri/vundo"
EGIT_REPO_URI="https://github.com/casouri/vundo.git"
EGIT_MIN_CLONE_TYPE=shallow

LICENSE="GPL-3"
SLOT="0"

SITEFILE="60${PN}-gentoo.el"
DOCS=(
	README.txt
	NEWS.txt
)
