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
    "EdenEast/nightfox.nvim",
    lazy = true,
    cmd = { "Nightfox", "Dayfox", "Dawnfox", "Duskfox", "Nordfox", "Terafox", "Carbonfox" },
    config = function()
      require("nightfox").setup({})
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    cmd = { "Tokyonight" },
    config = function()
      require("tokyonight").setup({
        style = "storm",
      })
    end,
  },
}
