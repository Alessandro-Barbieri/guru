# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Fill in a range of numbers or letters, optionally passing an increment or step to use, or create a regex-compatible range with options.toRegex"
HOMEPAGE="
	https://github.com/jonschlinkert/fill-range
	https://www.npmjs.com/package/fill-range
"
LICENSE="MIT"
KEYWORDS="~amd64"
NODEJS_RDEPEND="
	dev-node/to-regex-range
"