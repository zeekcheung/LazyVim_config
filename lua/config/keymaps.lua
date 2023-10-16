-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- split window
map("n", "\\", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "|", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
