# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Convert a dash/dot/underscore/space separated string to camelCase or PascalCase"
HOMEPAGE="
	https://github.com/sindresorhus/camelcase
	https://www.npmjs.com/package/camelcase
"
SRC_URI="https://registry.npmjs.org/camelcase/-/camelcase-6.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
