-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local LazyVimUtil = require("lazyvim.util")
local Ui = require("util.ui")

-------------------------------------- Delete default keymaps --------------------------------------
local del = vim.keymap.del

-- windows
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")

-- keywordprg
del("n", "<leader>K")

-- tabs
del("n", "<leader><tab>l")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")

-- trouble
del("n", "<leader>xl")
del("n", "<leader>xq")

-------------------------------------- Add custom keymaps --------------------------------------
local map = vim.keymap.set

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
-- select all
map({ "n", "v", "x", "i" }, "<C-a>", "ggVG", { desc = "Select All" })

-- quit
map({ "n", "v", "x" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map({ "n", "v", "x" }, "<leader>qw", "<cmd>exit<cr>", { desc = "Quit current window" })

-- goto line
map({ "n", "v", "x" }, "gls", "^", { desc = "Goto line start" })
map({ "n", "v", "x" }, "gle", "$", { desc = "Goto line end" })

-- better escape
map("i", "jj", "<esc>", { desc = "Better Escape" })
map("i", "jk", "<esc>", { desc = "Better Escape" })
map("i", "kk", "<esc>", { desc = "Better Escape" })

-- diagnostic
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })

-- formatting
map({ "n", "v" }, "<leader>fm", function()
  LazyVimUtil.format({ force = true })
end, { desc = "Format" })

-- split window
map("n", "\\", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "|", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() LazyVimUtil.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>uF", function() LazyVimUtil.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uS", function() LazyVimUtil.toggle("spell") end, { desc = "Toggle Spelling" })
-- map("n", "<leader>uC", ui.toggle_conceal, { desc = "Toggle conceal" })
map("n", "<leader>ub", Ui.toggle_background, { desc = "Toggle background" })
map("n", "<leader>us", Ui.toggle_signcolumn, { desc = "Toggle signcolumn" })
map("n", "<leader>ul", Ui.toggle_line_number, { desc = "Change line number" })
map("n", "<leader>uu", Ui.toggle_foldcolumn, { desc = "Toggle foldcolumn" })
map("n", "<leader>uH", Ui.toggle_ts_hightlight, { desc = "Toggle Treesitter Highlight" })
