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
	require("plugins/nvim-treesitter"),
	require("plugins/nvim-lspconfig"),

  	{'kaicataldo/material.vim'},
  	{'nvim-lualine/lualine.nvim'},
  	{'nvim-tree/nvim-tree.lua'},

})

vim.cmd.colorscheme('material')

require('config/lualine')
require('config/nvim-tree')

vim.keymap.set('n', '<F3>', ':NvimTreeToggle<cr>')


