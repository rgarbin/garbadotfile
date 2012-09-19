
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

parse_git_branch () {
    git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (\1)#'
}
parse_hg_branch() {
    hg branch 2>/dev/null | sed 's#\(.*\)# (\1)#'
}
parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print "("$1")" }'
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
        BRANCH=`cat CVS/TAG 2>/dev/null | cut -c 2- ` ; if [ "$BRANCH" != "" ] ; then echo "(cvs::$BRANCH)" ; fi
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

WHITE="\[\e[0m\]"
WHITE_1="\[\e[0;1m\]"
YELLOW="\[\e[33;1m\]"
GREEN="\[\e[32;1m\]"
BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"

export PS1="$WHITE_1[$YELLOW\u$WHITE_1@\h$BLUE\$(get_branch_information)$WHITE_1:$GREEN\w$WHITE_1]\$$WHITE "

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm
