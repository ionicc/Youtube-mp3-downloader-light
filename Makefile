# 
# Makefile for ytd.py
#
# author: alan jean
#         github.com/occupytheweb 
#
# usage: 
#         make              - display a help text describing the goals defined in this makefile
#         make install      - installs the dependencies required to run ytd.py
#         make install-dev  - installs the dependencies required to develop ytd.py
#         make test         - executes the test suite
#

# Edit these variables according to the package manager you use.

PKG_MANAGER=apt      # Your distro's package mgr. e.g.: Ubuntu/Debian -> apt,
	                 #                                  opensuse      -> zypper,
	                 #                                  fedora        -> yum, ...

INSTALL_CMD=install  # The package installation command for your package manager.

PKG_MANAGER_INSTALL_COMMAND=$(PKG_MANAGER) $(INSTALL_CMD)


# required to install python packages
installation-dependencies: ## install pip
	sudo $(PKG_MANAGER_INSTALL_COMMAND) python3-pip

# required to run ytd.py
runtime-dependencies: ## install youtube-dl
	sudo $(PKG_MANAGER_INSTALL_COMMAND) youtube-dl


##
install: installation-dependencies runtime-dependencies ## install dependencies required to run ytd.py
	pip install -r requirements/prod.txt

install-dev: installation-dependencies runtime-dependencies ## install development dependencies
	pip install -r requirements/dev.txt

test: ## run test suite
	pytest
##


# here be dragons
help: ## show this help text
	@echo
	@echo '  Usage:'
	@echo '    make <target>'
	@echo
	@echo '  Targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort |                     \
		awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: help

.DEFAULT_GOAL := help
