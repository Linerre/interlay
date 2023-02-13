# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEEDED_EMACS=27.1

inherit elisp git-r3

DESCRIPTION="Yet another modal editing on Emacs"
HOMEPAGE="https://github.com/meow-edit/meow"
EGIT_REPO_URI="https://github.com/meow-edit/meow.git"
EGIT_MIN_CLONE_TYPE=shallow

LICENSE="GPL-3"
SLOT="0"

SITEFILE="60${PN}-gentoo.el"
DOCS=(
	GET_STARTED.org
	CUSTOMIZATIONS.org
	COMMANDS.org
	EXPLANATION.org
	FAQ.org
	KEYBINDING_COLEMAK.org
	KEYBINDING_DVORAK.org
	KEYBINDING_DVP.org
	KEYBINDING_QWERTY.org
	README.org
	TUTORIAL.org
)
