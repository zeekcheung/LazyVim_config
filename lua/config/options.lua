-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Available options can be found by ":options" command

local opt = vim.opt

opt.backup = false -- Don't keep a backup after overwriting a file
opt.swapfile = false -- Don't use a swap file for this buffer
opt.list = false -- Don't show <Tab> and end-of-file
opt.background = "dark" -- Set the background color brightness
opt.foldtext = "v:lua.require('utils').foldtext()" -- Set the expression used to display the text of a closed fold
opt.spell = true -- Highlight spelling mistakes
opt.spelllang = "en_us" -- Set the list of accepted languages
opt.spellfile = "./spell/en.utf-8.add" -- Set the location of the spell file
opt.guicursor = "n-v-c:block,i-ci-ve:ver100/,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" -- Set the cursor style
opt.textwidth = 120 -- Set the width of text
opt.splitbelow = true -- Splitting a window will put it below the current
opt.splitright = true -- Splitting a window will put it to the right of the current

-- Disable netrw for Neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
