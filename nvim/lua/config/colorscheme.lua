local themes = { "kanagawa", "nordfox", "tokyonight" , "habamax" }
local theme_idx = 1

local function switch_colorscheme(name)
  vim.cmd.colorscheme(name)
  vim.notify("Theme: " .. name)
end

local function cycle_theme()
  theme_idx = (theme_idx % #themes) + 1
  local name = themes[theme_idx]
  if name == "nordfox" then
    require("nightfox").load(name)
  else
    switch_colorscheme(name)
  end
end

vim.keymap.set("n", "<leader>cc", cycle_theme, { desc = "Cycle theme" })
vim.keymap.set("n", "<leader>ck", function() switch_colorscheme("kanagawa") end, { desc = "Theme: Kanagawa" })
vim.keymap.set("n", "<leader>cn", function() switch_colorscheme("nordfox") end, { desc = "Theme: Nordfox" })
vim.keymap.set("n", "<leader>ct", function() switch_colorscheme("tokyonight") end, { desc = "Theme: Tokyonight" })
vim.keymap.set("n", "<leader>ch", function() switch_colorscheme("habamax") end, { desc = "Theme: Habamax" })
