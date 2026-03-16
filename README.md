a-dotfiles
==========

Personal dotfiles for macOS. Covers zsh, vim, and git config.

## What's in here

| File | Purpose |
|------|---------|
| `.zshrc` | Zsh config — PATH, aliases, plugins (Antidote), modern CLI tools, Starship prompt |
| `.vimrc` | Vim config — vim-plug, NERDTree, CtrlP, syntax/style settings |
| `.gitconfig` | Git aliases, delta as pager, editor config |
| `.vim/` | Vim runtime (autoload only — plugins installed locally, not committed) |
| `iterm2/` | iTerm2 color schemes (Smyck, Solarized Dark) |

## Setup on a new machine

### 1. Clone and symlink

```bash
git clone https://github.com/anahm/a-dotfiles.git ~/Documents/Code/a-dotfiles
cd ~/Documents/Code/a-dotfiles

ln -s "$PWD/.zshrc"      ~/.zshrc
ln -s "$PWD/.vimrc"      ~/.vimrc
ln -s "$PWD/.gitconfig"  ~/.gitconfig
ln -s "$PWD/.vim"        ~/.vim
```

### 2. Install Homebrew packages

```bash
# Core
brew install git

# Git pager
brew install git-delta

# Modern CLI tools
brew install eza bat ripgrep fd zoxide fzf

# Prompt
brew install starship
```

### 3. Install Zsh plugin manager (Antidote)

```bash
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
```

### 4. Install vim plugins

vim-plug is included in the repo. Just run:

```bash
vim +PlugInstall +qall
```

### 5. Open a new shell

Starship, zoxide, and fzf initialize on first shell load. Nothing else needed.

## iTerm2 color schemes

Import via iTerm2 → Settings → Profiles → Colors → Color Presets → Import. Files are in `iterm2/`.
