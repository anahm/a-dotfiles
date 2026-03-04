# Keep CLI tools reachable even if plugin loading fails.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH"
case ":$PATH:" in
  *":/Applications/Codex.app/Contents/Resources:"*) ;;
  *) export PATH="$PATH:/Applications/Codex.app/Contents/Resources" ;;
esac

# Google Cloud SDK
if [ -f "$(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc" ]; then
  source "$(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc"
fi

# Antidote + plugin bundle list
export ANTIDOTE_HOME="$HOME/.antidote"
export ANTIDOTE_PLUGINS_FILE="$HOME/Documents/Code/a-dotfiles/.zsh_plugins.txt"
autoload -Uz compinit
compinit
if [[ -f "$ANTIDOTE_HOME/antidote.zsh" && -f "$ANTIDOTE_PLUGINS_FILE" ]]; then
  source "$ANTIDOTE_HOME/antidote.zsh"
  source <(antidote load "$ANTIDOTE_PLUGINS_FILE")
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Load bash config for legacy aliases/functions
if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/shims:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Final fallback in case PATH was clobbered by later scripts.
if ! command -v claude >/dev/null 2>&1 && [ -x /opt/homebrew/bin/claude ]; then
  alias claude='/opt/homebrew/bin/claude'
fi
if ! command -v codex >/dev/null 2>&1 && [ -x /opt/homebrew/bin/codex ]; then
  alias codex='/opt/homebrew/bin/codex'
fi

# Other keyboard shortcuts
alias claude-mcp="open ~/Library/Application\ Support/Claude/claude_desktop_config.json"
