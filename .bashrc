
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

function parse_git_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

function parse_svn_branch
{
   parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print "["$1"]" }'
}

function parse_svn_url
{
   svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}

function parse_svn_repository_root
{
   svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

export PS1="\[\e[0;1m\][\[\e[33;1m\]\u\[\e[0;1m\]@\h\$(parse_git_branch)\$(parse_svn_branch):\[\e[32;1m\]\w\[\e[0;1m\]]$\[\e[0m\] "

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm
