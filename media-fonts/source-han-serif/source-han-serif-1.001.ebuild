# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="Pan-CJK OpenType/CFF font family"
HOMEPAGE="https://github.com/adobe-fonts/source-han-serif/"
SRC_URI="
	l10n_ja? ( https://github.com/adobe-fonts/${PN}/raw/${PV}R/SubsetOTF/SourceHanSerifJP.zip -> ${PN}-ja-${PV}.zip )
	l10n_ko? ( https://github.com/adobe-fonts/${PN}/raw/${PV}R/SubsetOTF/SourceHanSerifKR.zip -> ${PN}-ko-${PV}.zip )
	l10n_zh-CN? ( https://github.com/adobe-fonts/${PN}/raw/${PV}R/SubsetOTF/SourceHanSerifCN.zip -> ${PN}-zh_CN-${PV}.zip )
	l10n_zh-TW? ( https://github.com/adobe-fonts/${PN}/raw/${PV}R/SubsetOTF/SourceHanSerifTW.zip -> ${PN}-zh_TW-${PV}.zip )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"
IUSE="l10n_ja l10n_ko +l10n_zh-CN l10n_zh-TW"
REQUIRED_USE="|| ( l10n_ja l10n_ko l10n_zh-CN l10n_zh-TW )"

S=${WORKDIR}
FONT_SUFFIX="otf"
RESTRICT="binchecks strip"

BDEPEND="app-arch/unzip"

src_install() {
	use l10n_ja && FONT_S="${S}/SourceHanSerifJP" font_src_install
	use l10n_ko && FONT_S="${S}/SourceHanSerifKR" font_src_install
	use l10n_zh-CN && FONT_S="${S}/SourceHanSerifCN" font_src_install
	use l10n_zh-TW && FONT_S="${S}/SourceHanSerifTW" font_src_install
}
