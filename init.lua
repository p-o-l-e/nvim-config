require("core/options")
require("core/keymap")
--require("lazy")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  --lazy.install(lazy.path)
  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)

  vim.g.plugins_ready = true
end


lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  	---
  	-- List of plugins
  	---
  	{
    	"nvim-treesitter/nvim-treesitter",
    	build = ":TSUpdate",
    	config = function () 
      	local configs = require("nvim-treesitter.configs")

      	configs.setup({
          	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
          	sync_install = false,
          	highlight = { enable = true },
          	indent = { enable = true },  
        	})
    	end
 	},

	{
	  "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
	  lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
	  dependencies = {
	    -- main one
	    { "ms-jpq/coq_nvim", branch = "coq" },

	    -- 9000+ Snippets
	    { "ms-jpq/coq.artifacts", branch = "artifacts" },

	    -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
	    -- Need to **configure separately**
	    { 'ms-jpq/coq.thirdparty', branch = "3p" }
	    -- - shell repl
	    -- - nvim lua api
	    -- - scientific calculator
	    -- - comment banner
	    -- - etc
	  },
	  init = function()
	    vim.g.coq_settings = {
	        auto_start = true, -- if you want to start COQ at startup
	        -- Your COQ settings here
	    }
	  end,
	  config = function()
	    -- Your LSP settings here
	  end,
	},
 	
  	{'kaicataldo/material.vim'},
  	{'nvim-lualine/lualine.nvim'},

  	{'ms-jpq/chadtree'},
	--{
    --	"nvim-neo-tree/neo-tree.nvim",
    --	branch = "v3.x",
   -- 	dependencies = {
    --  		"nvim-lua/plenary.nvim",
     -- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
     -- 		"MunifTanjim/nui.nvim",
      		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    --	}
	--},
    
  	--{'neoclide/coc.nvim'},  
})


vim.cmd.colorscheme('material')

require('config/lualine')


vim.keymap.set('n', '<F3>', ':CHADopen<cr>')
