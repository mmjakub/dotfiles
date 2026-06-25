# Neovim config

**Plugin manager**: lazy.nvim (bootstraps at startup)

## Structure

```
init.lua                        entrypoint (leader=space)
lua/config/lazy.lua             lazy.nvim bootstrap + plugin import
lua/config/options.lua          vim options
lua/config/colorscheme.lua      theme cycling
lua/config/keymaps.lua          window keymaps (all commented out)
lua/plugins/*.lua               per-plugin lazy.nvim specs
init.vim.bak                    stale VimL backup — not active
```

## Active options

`termguicolors`, `number`, `relativenumber`, `cursorline`

## Plugins

- telescope.nvim (branch `0.1.x`) + telescope-fzf-native
- nvim-treesitter (bash, python, lua, vim, vimdoc, query, markdown)
- which-key.nvim
- Colorschemes: kanagawa (default wave), nightfox/nordfox, tokyonight

## Keymaps (leader = space)

| Binding | Action |
|---|---|
| `<leader>pf` | Telescope find_files |
| `<leader>pg` / `<leader><leader>` | Telescope git_files |
| `<leader>ph` | Telescope find_files (hidden) |
| `<C-f>` | Telescope live_grep |
| `<C-b>` | Telescope buffers |
| `<leader>cc` | Cycle theme |
| `<leader>ck` | Kanagawa |
| `<leader>cn` | Nordfox |
| `<leader>ct` | Tokyonight |
| `<leader>ch` | Habamax |
