# Neovim config

**Plugin manager**: lazy.nvim (bootstraps at startup)

## Structure

```
init.lua                        entrypoint (leader=space, localleader=\)
lua/config/lazy.lua             lazy.nvim bootstrap + plugin import
lua/config/options.lua          vim options + auto-reload watcher
lua/config/colorscheme.lua      theme cycling keymaps
lua/plugins/*.lua               per-plugin lazy.nvim specs
```

## Conventions

- Plugin specs live one-per-file in `lua/plugins/`, auto-discovered via `import = "plugins"`. **To add a plugin: create a file there, done — no registration anywhere.**
- Each file returns either a single spec table or a list of tables (for related plugins, e.g. mason + lspconfig):

  ```lua
  {
    "author/repo",
    event = "VeryLazy",
    keys = { { "<leader>ff", desc = "..." } },
    opts = { ... },
    config = function()
      require("plugin").setup({ ... })
    end,
  }
  ```

- Lazy-load with `event`, `cmd`, or `keys`. See existing files in `lua/plugins/` for patterns.
- Keybindings live inside the relevant plugin spec (`keys`, `on_attach`, or `config`), not in a central keymaps file. After adding or changing one, update `docs/keybinds.md`.
- Include `desc` on every keymap for which-key integration.
- Shared non-plugin logic (options, theme cycling) goes in `lua/config/`.
