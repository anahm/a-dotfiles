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


# Final fallback in case PATH was clobbered by later scripts.
if ! command -v claude >/dev/null 2>&1 && [ -x /opt/homebrew/bin/claude ]; then
  alias claude='/opt/homebrew/bin/claude'
fi
if ! command -v codex >/dev/null 2>&1 && [ -x /opt/homebrew/bin/codex ]; then
  alias codex='/opt/homebrew/bin/codex'
fi

# Starship prompt
eval "$(starship init zsh)"

# Modern CLI tools
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='bat'
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# Other keyboard shortcuts
alias claude-mcp="open ~/Library/Application\ Support/Claude/claude_desktop_config.json"
