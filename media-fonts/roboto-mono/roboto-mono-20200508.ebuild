# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font git-r3


DESCRIPTION="A monospaced addition to the Roboto type family (Google version)"
HOMEPAGE="https://fonts.google.com/specimen/Roboto+Mono"

EGIT_REPO_URI="https://github.com/googlefonts/RobotoMono.git"
EGIT_MIN_CLONE_TYPE="single"


LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

# By default, emerge will look for *.ttf files in ${WORKDIR}/${P}(?)
# But not all font-repos will store such files in the top level
# FONT_S tells emerge where to find them if no *.ttf in the ${WORKDIR}/${P}

# For example, in this case, *.ttf files are stored in
# FONT_S=(
# 	"${S}/fonts/ttf"
# 	"${S}/fonts/variable"
# )

# If a user defines their own phase-fns and move all the font files to
# the ${WORKDIR}/${P} then FONT_S is not necessary.


S="${WORKDIR}/${P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

# No need to check for binary and to test
RESTRICT="binchecks strip test"


# In the following case, *.ttf files are stored in fonts and variable dirs, so
# I move all the font files to ${WORKDIR} to prevent portage from copying
# `ttf` and `variable` dirs to /usr/share/fonts/roboto-mono/{ttf,variable}

src_prepare() {
	default

	if [[ -d fonts ]]; then
		for font in fonts/ttf/*; do
			cp "$font" "${S}"/$(basename "$font") || die
		done

		# The `[]` in file name will cause trouble
		# Changes in the filenames are made according to the Roboto_Mono.zip
		# that can be downloaded from google fonts
		cp 'fonts/variable/RobotoMono-Italic[wght].ttf' \
		   "${S}/RobotoMono-ItalicVariableFont_wght.ttf" || die

		cp 'fonts/variable/RobotoMono[wght].ttf' \
		   "${S}/RobotoMono-VariableFont_wght.ttf" || die
	else
		echo "fonts dir does not exit" || die
	fi
}
