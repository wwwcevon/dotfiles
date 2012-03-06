.PHONY: clean install
default: clean install

clean:
	rm -rf $(HOME)/.tmux.conf

install:
	PWD=`pwd`
	ln -s $(PWD)/tmux.conf $(HOME)/.tmux.conf
