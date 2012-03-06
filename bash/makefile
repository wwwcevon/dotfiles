SHELL:=/bin/bash

.PHONY: clean
default: clean

clean:
	rm $(HOME)/.bash_functions
	if [ "$(OS)" == "mac" ]; then rm $(HOME)/.bashrc_mac fi
	if [ "$(OS)" == "arch" ]; then rm $(HOME)/.bashrc_archlinux fi
	if [ "$(OS)" == "gentoo" ]; then rm $(HOME)/.bashrc_gentoo fi

install:
	PWD=$(shell PWD)
	ln -s $(PWD)/bash_functions $(HOME)/.bash_functions
	[[ "$(OS)" == "mac" ]] && ln -s $(PWD)/bashrc_mac $(HOME)/.bashrc_mac
	[[ "$(OS)" == "arch" ]] && ln -s $(PWD)/bashrc_archlinux $(HOME)/.bashrc_archlinux
	[[ "$(OS)" == "gentoo" ]] && ln -s $(PWD)/bashrc_gentoo $(HOME)/.bashrc_gentoo

