.PHONY: clean install

default: clean install

clean:
	rm $(HOME)/.vimrc
	rm $(HOME)/.gvimrc
	rm -rf $(HOME)/.vim

install:
	PWD=`pwd`
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/gvimrc $(HOME)/.gvimrc
	ln -s $(PWD)/vim $(HOME)/.vim

