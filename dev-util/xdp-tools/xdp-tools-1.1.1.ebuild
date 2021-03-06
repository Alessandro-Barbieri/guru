# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info llvm multilib toolchain-funcs

# version v1.1.1 is not tagged, use commit
MY_COMMIT="69827a07b395b78a2b577c3e1af6075f8c47fdd8"

DESCRIPTION="Utilities and example programs for use with XDP"
HOMEPAGE="https://github.com/xdp-project/xdp-tools"
SRC_URI="https://github.com/xdp-project/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

# skip strip for eBPF object files
# tests have to be run as root
RESTRICT="strip test"

# skip QA check(s) for eBPF samples
QA_EXECSTACK="usr/lib*/bpf/*.o usr/share/xdp-tools/*.o"
QA_PREBUILT="usr/lib*/bpf/*.o usr/share/xdp-tools/*.o"

# XDP should be enabled
CONFIG_CHECK="~XDP_SOCKETS"

LLVM_MAX_SLOT=10

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	>=dev-libs/libbpf-0.0.7
	net-libs/libpcap
	sys-libs/zlib
	virtual/libelf
"
DEPEND="${RDEPEND}
	sys-devel/clang:10
	sys-devel/llvm:10
"

PATCHES=(
	"${FILESDIR}/${P}-install.patch"
	"${FILESDIR}/${P}-readelf.patch"
)

S="${WORKDIR}/xdp-tools-${MY_COMMIT}"

pkg_setup() {
	llvm_pkg_setup
}

src_configure() {
	./configure || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		READELF=$(tc-getREADELF) \
		PRODUCTION=1 \
		DYNAMIC_LIBXDP=1 \
		FORCE_SYSTEM_LIBBPF=1 \
		PREFIX=/usr \
		LIBDIR="/usr/$(get_libdir)" all
}

src_install() {
	emake PREFIX=/usr LIBDIR="/usr/$(get_libdir)" DESTDIR="${D}" install
}
