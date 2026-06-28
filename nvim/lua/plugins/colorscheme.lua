return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = true,
        theme = "wave",
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    cmd = { "Gruvbox" },
    config = function()
      require("gruvbox").setup({})
    end,
  },
}
