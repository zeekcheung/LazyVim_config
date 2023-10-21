-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
local ui = require("utils.ui")
local Util = require("lazyvim.util")

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

-- split window
map("n", "\\", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "|", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>uF", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uS", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
-- map("n", "<leader>uC", ui.toggle_conceal, { desc = "Toggle conceal" })
map("n", "<leader>ub", ui.toggle_background, { desc = "Toggle background" })
map("n", "<leader>us", ui.toggle_signcolumn, { desc = "Toggle signcolumn" })
map("n", "<leader>ul", ui.toggle_line_number, { desc = "Change line number" })
map("n", "<leader>uu", ui.toggle_foldcolumn, { desc = "Toggle foldcolumn" })
map("n", "<leader>uH", ui.toggle_ts_hightlight, { desc = "Toggle Treesitter Highlight" })
