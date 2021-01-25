# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Colored symbols for various log levels."
HOMEPAGE="
	https://github.com/sindresorhus/log-symbols
	https://www.npmjs.com/package/log-symbols
"
LICENSE="MIT"
KEYWORDS="~amd64"
NODEJS_RDEPEND="
	dev-node/chalk
"