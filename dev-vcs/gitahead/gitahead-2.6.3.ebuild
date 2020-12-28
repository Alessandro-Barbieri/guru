# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg cmake wrapper

DESCRIPTION="Graphical Git client to help understand and manage source code history"
HOMEPAGE="https://github.com/gitahead/gitahead"
SRC_URI="
	https://github.com/gitahead/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/d1c28d791a7391a8dc101713cd8646df96491d03.tar.gz -> ${P}-dep_openssl_openssl.tar.gz
	https://github.com/stinb/libgit2/archive/90af68bbe2690998f015f18b7c890f5868bcd3ee.tar.gz -> ${P}-dep_libgit2_libgit2.tar.gz
	https://github.com/libssh2/libssh2/archive/42d37aa63129a1b2644bf6495198923534322d64.tar.gz -> ${P}-dep_libssh2_libssh2.tar.gz
	https://github.com/git/git/archive/0d0ac3826a3bbb9247e39e12623bbcfdd722f24c.tar.gz -> ${P}-dep_git_git.tar.gz
	https://github.com/commonmark/cmark/archive/f0793895eefc8ca14499831a24abee549a5af53e.tar.gz -> ${P}-dep_cmark_cmark.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
IUSE="gnome-keyring"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
	gnome-keyring? (
		app-crypt/libsecret
	)
"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}" || die
	local i list=(
		dep_openssl_openssl
		dep_libgit2_libgit2
		dep_libssh2_libssh2
		dep_git_git
		dep_cmark_cmark
	)
	for i in "${list[@]}"; do
		[ ! -f "${DISTDIR}/${P}-${i}.tar.gz" ] && die "The file ${DISTDIR}/${P}-${i}.tar.gz doesn't exist"
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" || die "Failed to unpack ${P}-${i}.tar.gz"
	done
}

src_prepare() {
	if ! use gnome-keyring; then
		sed -i 's/add_subdirectory(git)//' ./dep/CMakeLists.txt || die
	fi
	default
	cmake_src_prepare
}

src_install() {
	cd "${BUILD_DIR}" || die

	eninja package
	cd ./_CPack_Packages/Linux/STGZ || die
	mkdir -p "${D}"/usr/share || die
	bash ./GitAhead-2.6.3.sh --prefix="${D}"/usr/share --include-subdir || die
	rm -fr "${D}"/usr/share/GitAhead/*.so.* || die

	cd "${D}"/usr/share/GitAhead/Resources/GitAhead.iconset || die
	local res
	for res in 16 32 64 128 256 512; do
		newicon -s "${res}" "icon_${res}x${res}.png" "${PN}.png"
	done

	make_wrapper "${PN}" "${EPREFIX}/usr/share/GitAhead/GitAhead"
	make_desktop_entry "/usr/share/GitAhead/GitAhead" "GitAhead" "${PN}" "Development"
}

pkg_postinst() {
	xdg_pkg_postinst

	ewarn "${P} collects some statistical usage data."
	ewarn "To permanently opt-out of reporting:"
	ewarn "toggle a button in Help -> About GitAhead -> Privacy"
	ewarn "or write to ~/.config/gitahead.com/GitAhead.conf those lines:"
	ewarn "[tracking]"
	ewarn "enabled=false"
}
