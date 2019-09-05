# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Make the prompt look like this:
# Mon Apr 02 12:06:50 ~/code/airbnb (master) $
export PS1="\[\033[01;32m\]\d \t \w\$(__git_ps1) \[\033[00m\]\$ "

if [ -f ~/.bashrc ]; then
   . ~/.bashrc
fi

# autocomplete git (http://code-worrier.com/blog/autocomplete-git/)
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# include branch name in terminal prompt
if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

