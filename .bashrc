alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias vi='vim'
alias la='ls -la'
alias ll='ls -l'
alias reload!='source ~/.bashrc'

# ruby on rails
alias rc='rails c'
alias rs='rails s'
alias rvmi='rvm info'
alias rvmir='rvm info ruby'
alias rvmu='rvm use'

# heroku
alias h='heroku'
alias hl='heroku list'
alias hi='heroku info'
alias ho='heroku open'

function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

export PS1="\[\e[0;1m\][\[\e[33;1m\]\u\[\e[0;1m\]@\h\$(parse_git_branch_and_add_brackets):\[\e[32;1m\]\w\[\e[0;1m\]]$\[\e[0m\] "

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm
