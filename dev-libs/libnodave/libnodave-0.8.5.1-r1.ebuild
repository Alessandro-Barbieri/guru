# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic perl-module toolchain-funcs

DESCRIPTION="Connect to and exchange data with Siemens PLCs"
HOMEPAGE="https://sourceforge.net/projects/libnodave"
SRC_URI="mirror://sourceforge/libnodave/libnodave-${PV}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc perl"
RESTRICT="test" #no tests
DEPEND=""
RDEPEND="
	perl? ( dev-lang/perl:= )
"
BDEPEND=""
PATCHES=(
	"${FILESDIR}/makefile-${PV}.patch"
	"${FILESDIR}/perl-makefile.patch"
)
DOCS=( ChangeLog readme faq.txt FAQ.de.txt )

src_configure() {
	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_configure
	fi
	return
}

src_compile() {
	append-cflags "-L${S} -fPIC"
	emake clean
	emake CC="$(tc-getCC)" all
	ln -s libnodave.so.0 libnodave.so || die

	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_compile
	fi
}

src_install() {
	local programs=(
		testIBH
		testISO_TCP
		testMPI
		testPPI
		testPPIload
		testMPIload
		testISO_TCPload
		testMPI_IBHload
		testPPI_IBHload
		testPPI_IBH
		testNLpro
		testAS511
		isotest4
		ibhsim5
	)
	exeinto "/usr/libexec"
	doexe "${programs[@]}"

	dolib.so libnodave.so.0 libnodave.so
	doheader nodave.h
	use doc && HTML_DOCS=( doc/*.html )
	einstalldocs

	if use perl; then
		cd "${S}/PERL" || die
		perl-module_src_install
	fi
}
