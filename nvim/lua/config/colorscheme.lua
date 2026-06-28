local themes = { "kanagawa", "gruvbox", "habamax", "desert", "slate" }
local theme_idx = 1

local function switch_colorscheme(name)
  vim.cmd.colorscheme(name)
  vim.notify("Theme: " .. name)
end

local function cycle_theme()
  theme_idx = (theme_idx % #themes) + 1
  local name = themes[theme_idx]
  switch_colorscheme(name)
end

vim.keymap.set("n", "<leader>cc", cycle_theme, { desc = "Cycle theme" })
vim.keymap.set("n", "<leader>ck", function() switch_colorscheme("kanagawa") end, { desc = "Theme: Kanagawa" })
vim.keymap.set("n", "<leader>cg", function() switch_colorscheme("gruvbox") end, { desc = "Theme: Gruvbox" })
vim.keymap.set("n", "<leader>ch", function() switch_colorscheme("habamax") end, { desc = "Theme: Habamax" })
vim.keymap.set("n", "<leader>cd", function() switch_colorscheme("desert") end, { desc = "Theme: desert" })
vim.keymap.set("n", "<leader>cs", function() switch_colorscheme("slate") end, { desc = "Theme: slate" })
