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

------------------------------------------------------------------------------
-- Auto-reload files on external changes (fs_event watcher)
------------------------------------------------------------------------------
vim.opt.autoread = true

local uv = vim.uv or vim.loop
local reload_watchers = {}

local function setup_reload_watcher()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" or vim.bo[buf].buftype ~= "" then
    return
  end
  if reload_watchers[file] then
    return
  end

  local w = uv.new_fs_event()
  if not w then
    return
  end
  reload_watchers[file] = w

  w:start(file, {}, function(err)
    if err then
      return
    end
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.cmd("checktime " .. vim.fn.fnameescape(file))
      end
    end)
  end)
end

local function clear_reload_watcher()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if reload_watchers[file] then
    reload_watchers[file]:close()
    reload_watchers[file] = nil
  end
end

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = setup_reload_watcher,
  desc = "Set up fs_event watcher for auto-reload",
})

vim.api.nvim_create_autocmd("BufWipeout", {
  pattern = "*",
  callback = clear_reload_watcher,
  desc = "Clean up fs_event watcher",
})

