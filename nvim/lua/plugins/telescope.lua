return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  keys = {
    { "<leader>ff",  function() require("telescope.builtin").find_files()  end, desc = "Find files" },
    { "<leader><leader>",  function() require("telescope.builtin").git_files()  end, desc = "Find files (git)" },
    { "<leader>fF",  function() require("telescope.builtin").find_files({
	    hidden = true,
	    no_ignore = true
    })  end, desc = "Find files (include hidden)" },
    { "<leader>fj",  function() require("telescope.builtin").live_grep()   end, desc = "Live grep" },
    { "<leader>fk",  function() require("telescope.builtin").buffers()     end, desc = "List buffers" },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}
