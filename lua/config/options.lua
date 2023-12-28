-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Available options can be found by ":options" command
-- If you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua

local opt = vim.opt

opt.cmdheight = 0 -- Don't show command line unless it's being used
opt.background = "dark" -- Set the background color brightness
opt.backup = false -- Don't keep a backup after overwriting a file
opt.laststatus = 0 -- Never show default statusline
opt.list = false -- Don't show <Tab> and end-of-file
-- opt.spell = true -- Highlight spelling mistakes
-- opt.spelllang = "en_us" -- Set the list of accepted languages
opt.swapfile = false -- Don't use a swap file for this buffer

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
