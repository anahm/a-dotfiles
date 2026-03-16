# Dotfiles Modernization Plan

## Current State Diagnosis

Solid macOS developer setup from roughly 2020-2022 era. Good bones (tmux, vim, git aliases, zsh), but several core tools are outdated or unmaintained.

**Critical issues:**
- ~~**Vundle** — essentially unmaintained since 2020. No lazy loading, no lockfile.~~ ✅ Replaced with vim-plug
- ~~**`.bashrc`/`.bash_profile`** — maintaining bash config alongside zsh adds dead weight. Contains dead aliases (Sublime Text 2, hardcoded `ali_nahm@` rsync, Humu company config).~~ ✅ Deleted
- ~~**iTerm2 plist in git** — binary plist diffs are unreadable; only `.itermcolors` configs matter.~~ ✅ Plist deleted
- ~~**Vim bundles committed** — `.vim/bundle/` contains plugin source code that should be gitignored.~~ ✅ Removed and gitignored
- ~~**`.tmux.conf`** — uses deprecated syntax throughout (`-t vi-copy`, `pane-border-fg`, `mode-mouse`, `reattach-to-user-namespace`). Will silently break or already broken on tmux 3.x.~~ ✅ Deleted
- ~~**`.viminfo` in git** — generated runtime file, should never be committed.~~ ✅ Deleted
- ~~**`.emacs` + `.emacs.d/`** — if you don't use Emacs, this is pure noise.~~ ✅ Deleted
- **No dotfiles management** — ~~files aren't symlinked~~ files are manually symlinked (confirmed Feb 2026); no automated bootstrap for new machines.

---

## Priority Order

| # | Action | Effort | Impact |
|---|--------|--------|--------|
| 1 | ~~Get rid of nvm + pyenv~~ ✅ | Low | High (faster shell init) |
| 2 | ~~delta — git diff pager~~ ✅ | Very Low | High (instant win) |
| 3 | ~~Delete dead files (viminfo, emacs, bash)~~ ✅ | Very Low | Medium (repo hygiene) |
| 4 | ~~Delete .tmux.conf~~ ✅ | Very Low | Medium |
| 5 | ~~eza / bat / fd / rg / zoxide~~ ✅ | Very Low | High |
| 6 | ~~Starship prompt~~ ✅ | Low | Medium |
| 7 | ~~vim-plug (replace Vundle)~~ ✅ | Very Low | Medium |
| 8 | ~~lazygit~~ ✅ skipped | Low | Medium |
| 9 | Ghostty terminal | Low | Medium |
| 10 | ~~Document dotfile deployment~~ ✅ | Medium | Medium |
| 11 | ~~Cleanup bash config + committed bundles~~ ✅ | Low | Low |

---

## Items

### 1. ~~Replace nvm + pyenv with `mise`~~ → Removed nvm + pyenv (no mise needed) ✅

**Status: Complete (2026-03-16)**

- [x] Removed nvm init block from `.zshrc` and `.bashrc`
- [x] Removed pyenv init blocks from `.zshrc`
- [x] Deleted `~/.pyenv` (was empty — no versions installed)
- [x] mise not installed — unnecessary since Node and Python are already managed by Homebrew

**What we found:** nvm was never installed (`~/.nvm` didn't exist), pyenv had no versions. Node v24.3.0 and Python 3.13.5 are both installed via Homebrew. No multi-version management needed.

---

### 2. ~~Add `delta` as git pager~~ ✅

**Status: Complete (2026-03-16)**

- [x] Install: `brew install git-delta`
- [x] Add to `.gitconfig`

---

### 3. ~~Delete dead files~~ ✅

**Status: Complete (2026-03-16)**

- [x] `git rm .viminfo` — generated runtime file
- [x] `git rm -r .emacs .emacs.d/` — Emacs config + plugins (OCaml tuareg mode, color themes, etc.)
- [x] `git rm .git-completion.bash` — replaced by zsh native completions
- [x] `git rm .git-prompt.sh` — replaced by Starship (item 6)

**Bash cleanup complete (2026-03-16):**
- Deleted `.bashrc` entirely — all contents were dead weight: Sublime Text 2 alias, `tabc()`/`tab-reset()` iTerm2 functions (unused), `ssh_setup()` (referenced non-existent files), `copy_data()` (hardcoded `ali_nahm@`), Humu company config, wrong `dot` alias path
- Deleted `.bash_profile` entirely — macOS uses zsh; only useful content was terminal color exports and PS1 (both superseded by zsh config and Starship)
- Removed `source ~/.bashrc` line from `.zshrc`

---

### 4. ~~Delete .tmux.conf~~ ✅

**Status: Complete (2026-03-16)**

- [x] `git rm .tmux.conf` — not currently using tmux; can add a fresh config later if needed

---

### 5. ~~Add modern CLI tool aliases~~ ✅

**Status: Complete (2026-03-16)**

- [x] Install: `brew install eza bat ripgrep fd zoxide fzf`
- [x] Add to `.zshrc`:
  ```zsh
  alias ls='eza --icons'
  alias ll='eza -la --icons'
  alias cat='bat'
  eval "$(zoxide init zsh)"
  source <(fzf --zsh)
  ```

**Note:** `fd` and `rg` are available as native commands but not aliased over `find`/`grep` — shadowing standard names can break scripts.

**Why:** These are strict improvements — faster, git-aware, syntax-highlighted versions of familiar commands. No workflow change needed.

| Old | New | Why |
|-----|-----|-----|
| `ls` | eza | Git-aware, icons, tree mode |
| `cat` | bat | Syntax highlighting, git diff markers |
| `grep` | ripgrep (`rg`) | 10x+ faster, respects `.gitignore` |
| `find` | fd | Intuitive syntax, respects `.gitignore` |
| `cd` | zoxide (`z`) | Frecency-based jump, learns your dirs |
| `ctrl+r` | fzf | Fuzzy history search |

---

### 6. ~~Switch to Starship prompt~~ ✅

**Status: Complete (2026-03-16)**

- [x] Install: `brew install starship`
- [x] Add `eval "$(starship init zsh)"` to `.zshrc`
- [ ] Optionally: create `~/.config/starship.toml` and version-control it in dotfiles

**Note:** `.git-prompt.sh` and `.git-completion.bash` were already deleted in item 3.

**Why:** Cross-shell, actively maintained, configurable via TOML. Powerlevel10k is on life support (author announced maintenance halt in 2024). Starship is the 2025 consensus winner.

---

### 7. ~~Replace Vundle with vim-plug + plugin audit~~ ✅

**Status: Complete (2026-03-16)**

- [x] Install vim-plug: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
- [x] Rewrite `.vimrc` plugin section: replace `Bundle '...'` calls with `Plug '...'` inside `call plug#begin() / call plug#end()`
- [x] `git rm -r .vim/bundle/` — stop tracking committed plugin source code
- [x] Add `.vim/bundle/` to `.gitignore`
- [x] Apply plugin audit changes (remove dead plugins, replace deprecated ones, add ruff)
- [x] Run `:PlugInstall` inside Vim after changes

**Why:** Vundle is unmaintained. vim-plug is a near-identical drop-in with parallel installs and active maintenance.

**On new machines:** The curl command above bootstraps vim-plug in one shot.

#### Plugin audit

| Plugin | Status | Action |
|--------|--------|--------|
| `ctrlpvim/ctrlp.vim` | Active fork, works fine | Keep |
| `scrooloose/nerdtree` | Maintained | Keep |
| `tpope/vim-fugitive` | Unused | **Remove** |
| `vim-scripts/trailing-whitespace` | Redundant — `.vimrc` already has manual trailing whitespace highlighting (lines 92–97) doing the same thing | **Remove** |
| `majutsushi/tagbar` | Unused | **Remove** |
| `psf/black` | psf dropped the vim plugin — deprecated, won't install | **Remove** |
| `tell-k/vim-autopep8` | Superseded by ruff | **Remove** |
| `tpope/vim-git` | Unused | **Remove** |
| `tpope/vim-markdown` | Unused | **Remove** |
| `posva/vim-vue` | Unused | **Remove** |
| `leafgarland/typescript-vim` | Unused | **Remove** |
| `mxw/vim-jsx` | Archived/unmaintained | **Remove** |

**Ruff** replaces both black and autopep8 — faster, actively maintained, linter + formatter in one. No plugin needed; use an external command mapping:
- [ ] Install: `brew install ruff`
- [ ] Remove `psf/black`, `tell-k/vim-autopep8`, their config blocks, and `<leader>ap` mapping from `.vimrc`
- [ ] Add to `.vimrc`: `nnoremap <leader>rf :w<CR>:!ruff format %<CR><CR>`

---

### 8. ~~Add `lazygit`~~ — Skipped

**Decision: Not worth it (2026-03-16)**

lazygit is only valuable if you regularly stage individual hunks or do interactive rebases and find the CLI friction annoying. Workflow here is mostly `git add . && git commit` — existing git aliases cover it. Skip.

---

### 9. Consider Ghostty over iTerm2

- [ ] Download Ghostty from https://ghostty.org
- [ ] Migrate color scheme: Ghostty supports Solarized Dark natively
- [ ] Config lives at `~/.config/ghostty/config` (plain text, version-controllable)
- [ ] Remove `com.googlecode.iterm2.plist` from the repo; keep only `.itermcolors` files for reference

**Why:** GPU-accelerated, ~2ms key-to-screen latency vs iTerm2's ~15ms. Config is plain text rather than binary plist. Built by Mitchell Hashimoto.

---

### 10. ~~Document dotfile deployment~~ ✅

**Status: Complete (2026-03-16)**

- [x] Rewrote README with full new-machine setup instructions (symlinks, brew packages, Antidote, vim-plug)
- [x] Removed dangling symlinks from `~` for deleted files (`.emacs`, `.emacs.d`, `.git-completion.bash`, `.git-prompt.sh`, `.tmux.conf`)
- [x] Skipped GNU Stow — manual `ln -s` is simple enough for a single-machine setup

---

### 11. ~~Final cleanup~~ ✅

**Status: Complete (2026-03-16)**

- [x] `git rm .viminfo` — generated file, never commit
- [x] `git rm -r .emacs .emacs.d/` — Emacs unused
- [x] `git rm .git-completion.bash .git-prompt.sh` — replaced by zsh native + Starship
- [x] `git rm -r .vim/bundle/` — plugin source code doesn't belong in dotfiles
- [x] `git rm .bash_profile .bashrc` — deleted, all useful content migrated to `.zshrc`
- [x] `git rm com.googlecode.iterm2.plist` — binary file, unreadable diffs
- [x] Updated `.gitignore`: `.vim/bundle/`, `*.plist`, `.viminfo`

---

## Notes

- All items complete or skipped. **Item 9 (Ghostty)** is the only remaining optional item.
- Items can be done independently in any order.
