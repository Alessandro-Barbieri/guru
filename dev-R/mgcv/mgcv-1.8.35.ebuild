# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Mixed GAM Computation Vehicle with automatic smoothness estimation'
KEYWORDS="~amd64"
SRC_URI="mirror://cran/src/contrib/mgcv_1.8-35.tar.gz"
LICENSE='GPL-2+'

DEPEND="
	virtual/nlme
	>=dev-lang/R-3.6.0
	virtual/Matrix
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"
