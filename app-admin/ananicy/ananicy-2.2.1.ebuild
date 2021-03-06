# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit python-single-r1

DESCRIPTION="ANother Auto NICe daemon"
HOMEPAGE="https://github.com/Nefelim4ag/Ananicy"
SRC_URI="https://github.com/Nefelim4ag/Ananicy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	sys-process/schedtool
"

S="${WORKDIR}/${P^}"
DOCS=( README.md )
PATCHES=( "${FILESDIR}/fix-sysctl-path.patch" )

src_compile() {
	return
}

src_install() {
	emake PREFIX="${D}" install
	python_fix_shebang "${ED}/usr/bin/ananicy"
	einstalldocs
}
