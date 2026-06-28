# Custom Keybindings

> **IMPORTANT**: This file must be kept in sync with the actual config. If you add, change, or remove a keybinding anywhere in this repo, update this document accordingly.

---

## Neovim (`nvim/`)

### Leader keys — `nvim/init.lua`

| Key | Mode | Action |
|-----|------|--------|
| `Space` | All | `<leader>` |
| `\` | All | `<maplocalleader>` |

### Colorscheme cycling — `nvim/lua/config/colorscheme.lua:15-20`

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cc` | Normal | Cycle through all themes |
| `<leader>ck` | Normal | Set theme: Kanagawa |
| `<leader>cg` | Normal | Set theme: Gruvbox |
| `<leader>ch` | Normal | Set theme: Habamax |
| `<leader>cd` | Normal | Set theme: desert |
| `<leader>cs` | Normal | Set theme: slate |

### LSP — `nvim/lua/plugins/lsp.lua:49-57`

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `K` | Normal | Hover documentation |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | List references |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>e` | Normal | Show diagnostic float |

### Telescope — `nvim/lua/plugins/telescope.lua:15-22`

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | Normal | Find files |
| `<leader><leader>` | Normal | Git files |
| `<leader>fF` | Normal | Find files (incl. hidden, no_ignore) |
| `<leader>fj` | Normal | Live grep (search text) |
| `<leader>fk` | Normal | List buffers |

### nvim-cmp (autocomplete) — `nvim/lua/plugins/cmp.lua:22-26`

All in insert mode.

| Key | Action |
|-----|--------|
| `<C-b>` | Scroll completion docs backward |
| `<C-f>` | Scroll completion docs forward |
| `<C-l>` | Manually trigger completion |
| `<C-e>` | Abort / close completion menu |
| `<CR>` | Confirm selected completion item |
| `<F2>` | Toggle auto-complete on/off |

### Gitsigns — `nvim/lua/plugins/gitsigns.lua`

| Key | Mode | Action |
|-----|------|--------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Prev hunk |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk (floating window) |
| `<leader>hb` | Normal | Blame line |
| `<leader>hd` | Normal | Diff this |
| `<leader>htd` | Normal | Toggle deleted lines inline |

---

## Tmux (`tmux/tmux.conf`)

**Prefix**: `C-space` (set at line 7, replaces default `C-b`)

All bindings are used **after** pressing the prefix.

| Key | Action | Line |
|-----|--------|------|
| `C-space` | Send literal prefix to app | 8 |
| `-` | Split pane horizontally (current dir) | 14 |
| `\|` | Split pane vertically (current dir) | 15 |
| `o` | New window (current dir) | 18 |
| `O` | New window (default dir) | 19 |
| `h` | Select pane left | 29 |
| `j` | Select pane down | 30 |
| `k` | Select pane up | 31 |
| `l` | Select pane right | 32 |
| `r` | Reload tmux config | 43 |

---

## Zsh (`zsh/.zshrc`)

| Key | Mode | Action | Line |
|-----|------|--------|------|
| `^P` (Ctrl+P) | Emacs/viins | Up line or history | 26 |
| `^N` (Ctrl+N) | Emacs/viins | Down line or history | 27 |
| `\e.` (Alt+.) | viins (insert) | Insert last word | 29 |

Line 39: `bindkey -v` enables vi-mode keymaps (vicmd + viins).

---

## Keyd (keyboard-level remapping) — `keyd/default.conf`

| Key (hardware) | Effect | Line |
|----------------|--------|------|
| `capslock` | Control when held, Escape when tapped | 9 |
| `leftalt` | Super/Windows key | 12 |
| `leftmeta` (Super) | Alt | 13 |
| `rightmeta` (right Super) | Sends Ctrl+Space (your tmux prefix) | 15 |

---

## Lazygit (`lazygit/config.yml`)

No custom keybindings — all defaults.
