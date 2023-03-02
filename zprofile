# DOTFILESDIR SHOULD BE DEFINED FOR THIS TO RUN PROPERLY
DOTFILESDIR=$( cd "$( dirname "${(%):-%N}" )" && pwd )
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/bin" # Add bin
export PATH="$DOTFILESDIR:$PATH" # add this folder

# restart ssh-agent
eval "$(ssh-agent -s)"

#CLI

alias ls=exa

# GO
export GOPATH="$HOME/WORK/gocode" # add the gopath var
export PATH=$PATH:/usr/local/opt/go/libexec/bin # add the gopath var
export PATH="$PATH:$GOPATH/bin" # add executable

# Kubernetes kubectl
# source <(kubectl completion bash)

#JAVA openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# # PYTHON
alias python='python3'
# alias pip='pip3'
# export PATH=$PATH:/Users/bravomartin/Library/Python/3.6/bin
# source /usr/local/bin/virtualenvwrapper.sh
#
# # RUBY
# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#
# export RBENV_ROOT=/usr/local/var/rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# POSTGRES
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/13/bin

# NODE
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# PHP / COMPOSER


export PATH="$(brew --prefix php@7.4)/bin:$PATH"
# export PATH="$PATH:~/.composer/vendor/bin" # add composer to executable

# Convert TTF/OTF font to @font-face font stack
# alias fontstack='~/bin/css3FontConverter/convertFonts.sh'

# GIT

git config --global alias.ac '!git add -A && git commit -m'
git config --global push.default current
git config --global alias.undo 'reset --soft HEAD^'
git config --global alias.cleanup '!git branch --merged | egrep -v "(^\*|master|main|staging)" | xargs !git branch -d'

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# some options for prompt
# PS1="\n\e[0;33m\w\e[m\n\u@\h  sez:\n"
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# PS1='\n\e[0;33m\w\e[m\n\u@\h $(__git_ps1 "(on \e[0;35m\]%s\[\e[0m\])"):\n'
# PS1='\n\e[0;34m\w/\e[m $(__git_ps1 "(on \e[0;91m\]%s\[\e[0m\])"):\n'

git config --global color.ui true
alias gl="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"
alias gstat="git status -s"
alias git_cleanup='git branch --merged | egrep -v "(^\*|master|main|staging)" | xargs git branch -d'
alias git_cleanup_remote="git branch -r --merged master |grep origin | grep -v '>' | grep -v master | awk '{split($0,a,"/"); print a[2]}'| xargs git push origin --delete"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# from https://github.com/git/git/tree/master/contrib/completion
# source $DOTFILESDIR/git-completion.sh

# from https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
# source $DOTFILESDIR/git-prompt.sh

# VAGRANT
# alias vgs='vagrant global-status'

# Atom
alias a=atom

# VS Code

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"



# chrome
alias chromium-browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# HELPERS
# usage `whichp 4000`
function whichp(){
  for var in "$@"
  do
    lsof -n -i :$var | grep LISTEN
  done
}

# usage `killp 4000`
function killp(){
  for var in "$@"
  do
    lsof -n -i :$var | grep LISTEN | awk '{print $2}' | xargs kill -9
  done
}

# usage `openp 4000`
function openp(){
  open http://localhost:$1
}

# GENERAL
alias ls='ls -F'
alias ll='ls -l -h'
alias la='ls -a'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias atom='/Applications/Atom.app/Contents/Resources/app/atom.sh'


# if ! grep -Fxq "set completion-ignore-case On" ~/.inputrc; then
#   echo "set completion-ignore-case On" >> ~/.inputrc
# fi

# Move to trash.
function rrm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}


# QPDF / GhostScript

function pdfoo(){
  echo "optimizing pdf(s) with ebook settings"
  for var in "$@"
  do
    name=$var:r
    ps2pdf -dPDFSETTINGS=/ebook "$name.pdf" "$name-ebook.pdf"
  done
}

function pdfo(){
  echo "optimizing pdf(s) with printer settings"
  for var in "$@"
  do
    name=$var:r
    ps2pdf -dPDFSETTINGS=/printer "$name.pdf" "$name-printer.pdf"
  done
}

function qpdfsplit(){
  for var in "$@"
  do
    name=$var:r
    qpdf --split-pages=1 "$name.pdf" "$name-%d.pdf"
  done
}
