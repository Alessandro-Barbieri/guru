# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Detect whether a terminal supports color"
HOMEPAGE="
	https://github.com/chalk/supports-color
	https://www.npmjs.com/package/supports-color
"
SRC_URI="https://registry.npmjs.org/supports-color/-/supports-color-8.1.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/has-flag
"
