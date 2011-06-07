
# Check for an interactive session
[ -z "$PS1" ] && return

if [ "$PS1" ]; then
    complete -cf sudo
fi

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export PATH=$PATH:~/bin

export EDITOR=vim

alias ll='ls -lAFh'
alias grep='grep --color'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias ssh='ssh -A'

export GNOME_DESKTOP_SESSION_ID=Default

function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}
PS1='\[\e[1;32m\]\u\[\e[m\]@\[\e[1;35m\]\h:\[\e[0m\e[1;34m\]\W\[\e[m\]$\[\e[1;31m\]$(parse_git_branch_and_add_brackets)\[\e[m\] '

/usr/bin/keychain $HOME/.ssh/anjuke/id_rsa
/usr/bin/keychain $HOME/.ssh/general/id_rsa
/usr/bin/keychain $HOME/.ssh/github/id_rsa
/usr/bin/keychain $HOME/.ssh/areverie.org/id_rsa
/usr/bin/keychain $HOME/.ssh/id_dsa
. $HOME/.keychain/$HOSTNAME-sh
