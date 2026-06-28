return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "│" },
      delete = { text = "▐" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", gitsigns.next_hunk, "Next hunk")
      map("n", "[h", gitsigns.prev_hunk, "Prev hunk")

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
      map("n", "<leader>hb", gitsigns.blame_line, "Blame line")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>htd", gitsigns.toggle_deleted, "Toggle deleted lines")
    end,
  },
}
