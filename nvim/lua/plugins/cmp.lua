return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        completion = {
          autocomplete = false,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      local auto_complete = false

      local function toggle_auto()
        auto_complete = not auto_complete
        if auto_complete then
          cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter } } })
        else
          cmp.abort()
          cmp.setup({ completion = { autocomplete = false } })
        end
        vim.schedule(function()
          vim.notify("Auto-complete: " .. (auto_complete and "ON" or "OFF"))
        end)
      end

      vim.api.nvim_create_user_command("CmpToggleAuto", toggle_auto, {})
      vim.keymap.set("i", "<F2>", toggle_auto, { desc = "Toggle cmp auto-complete" })
    end,
  },
}
