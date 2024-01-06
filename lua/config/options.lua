-- NOTE:
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Available options can be found by ":options" command
-- If you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua

local LazyVimUtil = require("lazyvim.util")

local opt = vim.opt

opt.backup = false -- Don't keep a backup after overwriting a file
opt.list = false -- Don't show <Tab> and end-of-file
opt.swapfile = false -- Don't use a swap file for this buffer
-- opt.guicursor = -- Change cursor style
--   "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff50-blinkon75-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Spell
-- opt.spell = true -- Highlight spelling mistakes
-- opt.spelllang = "en_us" -- Set the list of accepted languages

-- Shell
if LazyVimUtil.is_win() then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "Powershell"
  vim.opt.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Disable some default providers
-- See `:h provider` for more info
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
