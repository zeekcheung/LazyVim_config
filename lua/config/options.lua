-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.swapfile = false -- Disable swap file

vim.g.dadbod_enabled = false -- Disable vim-dadbod(-ui)
vim.g.noice_enabled = true -- Enable noice.nvim
vim.g.indent_blankline_highlight_scope = false -- Enable indent-blankline.nvim highlight scope
