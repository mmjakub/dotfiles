# AGENTS.md

**What this is**: personal dotfiles collection.

## Currently tracked
- `nvim/` — Neovim config (see `docs/nvim/` for details)
- `tmux/` - Tmux config
- `zsh/` - Zsh config (`.zshenv`, `.zshrc`, `git-prompt.sh`)
- `aliases/` - Shell aliases (split into `aliases.d/` categories)
- `keyd/` - Keyd config (`default.conf`)
- `lazygit/` - Lazygit config (`config.yml`)

## Adding a new dotfile entry

1. Create the dir: `mkdir ~/dotfiles/<name>`
2. Populate it — either create config files fresh, or copy existing ones:
   `cp -r <config-path>/* ~/dotfiles/<name>/`
3. Register it in `install.sh` — see [`docs/install/README.md`](docs/install/README.md)
4. Run `./install.sh` — it backs up originals, then replaces with symlinks
5. Verify everything works, then remove backups with `./install.sh --clean`
6. List it in the tracked section above
