return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader>o", function() require("oil").open() end, desc = "Open dir as buffer (oil)" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = false,
    view_options = { show_hidden = true },
    float = { padding = 2, max_width = 80, max_height = 40 },
  },
}
