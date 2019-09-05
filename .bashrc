# aliases
alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias jp='jupyter notebook'
alias less='less -R'
alias dot='cd ~/Documents/a-dotfiles'

# alias dockerkill='docker rm $(docker ps -a -q -f status=exited)'

# bash command tab completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

# upload dotfiles before sshing - only needs to be used on first connect
ssh_setup() {
  host=$1 ; shift
  scp ~/.remoterc $host:~/
  scp ~/.vimrc $host:~/
  scp ~/.tmux.conf $host:~/

  if [[ -n "$ITERM_SESSION_ID" ]]; then
    trap "tab-reset" INT EXIT
    tabc ssh-box
  fi
  ssh $host "$@"
}

function copy_data {
  if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <host> <dest_dir> <source_dir>"
    return 0
  fi

  remote_server=$1
  source_dir=$2
  dest_dir=$3
  rsync -av -e ssh --delete ${source_dir} ali_nahm@${remote_server}:${dest_dir}
}

# node downloads
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Adding humu config
if [ -f $HOME/.humurc ]; then
    . $HOME/.humurc
fi

