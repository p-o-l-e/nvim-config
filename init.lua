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
  require("lazy").setup("plugins", {}) 

  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	require("plugins/nvim-treesitter"),
	require("plugins/nvim-lspconfig"),
	require("plugins/telescope"),
	require("plugins/dashboard"),
	require("plugins/minimap"),
	require("plugins/aerial"),
	-- {'preservim/tagbar'},
	{'p-o-l-e/material.nvim'},
  	{'nvim-lualine/lualine.nvim'},
  	{'nvim-tree/nvim-tree.lua'},

})

require('config/material')
vim.cmd.colorscheme('material')

require('config/aerial')
require('config/telescope')
require('config/lualine')
require('config/nvim-tree')

-- vim.keymap.set('n', '<F8>', ':TagbarToggle<cr>')




