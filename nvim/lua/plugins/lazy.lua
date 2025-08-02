-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- init.lua:
	{
    	'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
     	dependencies = { 'nvim-lua/plenary.nvim' }
    	},
    --File tree
   	 {
 	"nvim-tree/nvim-tree.lua",
  	dependencies = { "nvim-tree/nvim-web-devicons" },
  	version = "*",
  	config = function()
    	require("nvim-tree").setup({})
 	end,
	},
	{'akinsho/bufferline.nvim', version = "*", dependencies =	 'nvim-tree/nvim-web-devicons'},

    {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    },
    {
	"terrortylor/nvim-comment",
      	config = function()
        require('nvim_comment').setup({
          -- Add a space b/w comment and the line
          marker_padding = true,
          -- Should comment out empty or whitespace only lines
          comment_empty = true,
          -- Should key mappings be created
          create_mappings = true,
          -- Normal mode mapping left hand side
          line_mapping = "gcc",
          -- Visual/Operator mapping left hand side
          operator_mapping = "gc",
          -- text object mapping, comment chunk
          comment_chunk_text_object = "ic",
        })
    end,
    },
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup({
          direction = "horizontal",
          size = 15,
        })
      end,
    }
  })
