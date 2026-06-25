------------------------------------------------------------------------------
-- Appearance
------------------------------------------------------------------------------
vim.opt.termguicolors = true
-- vim.cmd.colorscheme("habamax")

------------------------------------------------------------------------------
-- Filetype detection
------------------------------------------------------------------------------
-- vim.opt.nocompatible = true
-- vim.cmd("filetype on")
-- vim.cmd("filetype plugin on")
-- vim.cmd("filetype indent on")
-- vim.cmd("syntax on")

------------------------------------------------------------------------------
-- Search
------------------------------------------------------------------------------
-- vim.opt.hlsearch = true
-- vim.opt.incsearch = true
-- vim.opt.smartcase = true
-- vim.opt.ignorecase = true
-- vim.keymap.set("n", "<C-l>", ":set hls!<CR>", { desc = "Toggle highlight search", silent = true })

------------------------------------------------------------------------------
-- Mouse & wildmenu
------------------------------------------------------------------------------
-- vim.opt.mouse = "nv"
-- vim.opt.wildmode = "longest,list,full"
-- vim.opt.wildmenu = true

------------------------------------------------------------------------------
-- Line numbers & UI
----------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
-- vim.opt.laststatus = 2
-- vim.opt.ruler = true

------------------------------------------------------------------------------
-- Indentation
------------------------------------------------------------------------------
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
-- vim.opt.expandtab = true
-- vim.opt.softtabstop = 4
-- vim.opt.shiftround = true
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true

------------------------------------------------------------------------------
-- GUI options
------------------------------------------------------------------------------
-- vim.opt.guioptions:remove({ "m", "T", "r", "R", "l", "L" })

------------------------------------------------------------------------------
-- Filetype-specific overrides
------------------------------------------------------------------------------
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "htmldjango", "html" },
--   callback = function()
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.tabstop = 2
--   end,
--   desc = "HTML: use 2-space indents",
-- })
