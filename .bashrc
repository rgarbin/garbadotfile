
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

parse_git_branch () {
    git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'
}
parse_hg_branch() {
    hg branch 2>/dev/null | sed 's#\(.*\)# (hg::\1)#'
}
parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn::"$1")" }'
}
parse_svn_url() {
    if [ -e .svn ] ; then
        svn info 2>/dev/null | sed -ne 's#^URL: ##p' | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print ""$1"" }'
    fi
}
parse_svn_repository_root() {
    if [ -e .svn ] ; then
        svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
    fi
}
parse_cvs_branch() {
    if [ -e CVS ] ; then
        #cat CVS/TAG | cut -c 2- 2>/dev/null | sed '#\(.*\)# (cvs::\1)#'
        BRANCH=`cat CVS/TAG 2>/dev/null | cut -c 2- ` ; if [ "$BRANCH" != "" ] ; then echo " (cvs::$BRANCH)" ; fi
    fi
}
 
get_branch_information() {
    if [ -e .svn ] ; then
        parse_svn_branch
    elif [ -e CVS ] ; then
        parse_cvs_branch
    else
        parse_git_branch
        parse_hg_branch
    fi
}

function jornadas
{
    GIT_USER="Garbin"
    DATE_INI=`date +%Y-%m-01`
    DATE_FIM=`date +%Y-%m-31`
    echo -e "git whatchanged --since=$DATE_INI --before=$DATE_FIM --author=$GIT_USER"
}

export PS1="\[\e[0;1m\][\[\e[33;1m\]\u\[\e[0;1m\]@\h\$(get_branch_information):\[\e[32;1m\]\w\[\e[0;1m\]]$\[\e[0m\] "

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm
