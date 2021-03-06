# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby30 ruby27 ruby26 ruby25"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC=""

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_GEMSPEC=""

inherit ruby-fakegem

DESCRIPTION="Step-by-step debugging and stack navigation in Pry"
HOMEPAGE="https://github.com/deivid-rodriguez/pry-byebug"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#ruby_add_bdepend ""

ruby_add_rdepend "
	>=dev-ruby/byebug-11.0
	>=dev-ruby/pry-0.13
	<dev-ruby/pry-0.15
"
