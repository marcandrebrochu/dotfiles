-- Bootstrapping: ensure packer.nvim is installed on the machine.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'srcery-colors/srcery-vim'
  use 'neovimhaskell/haskell-vim'
  use 'neovim/nvim-lspconfig'
  use {
    'junegunn/fzf.vim',
    requires = {{'junegunn/fzf', run = function() fn['fzf#install']() end }}
  }
end)
