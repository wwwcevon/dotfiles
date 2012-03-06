.PHONY: clean install

default: clean install

clean:
	rm $(HOME)/.vimrc
	rm -rf $(HOME)/.vim

install:
	PWD=`pwd`
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/vim $(HOME)/.vim

