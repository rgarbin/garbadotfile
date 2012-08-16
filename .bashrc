
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

function parse_git_branch_and_add_brackets 
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

export PS1="\[\e[0;1m\][\[\e[33;1m\]\u\[\e[0;1m\]@\h\$(parse_git_branch_and_add_brackets):\[\e[32;1m\]\w\[\e[0;1m\]]$\[\e[0m\] "

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm
