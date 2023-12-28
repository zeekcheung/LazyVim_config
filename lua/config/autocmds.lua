-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local Util = require("lazyvim.util")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Use Powershell as default shell on Windows
if Util.is_win() then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "Powershell"
  vim.opt.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Increase numberwidth for buffers
-- autocmd("BufEnter", {
--   desc = "Increase numberwidth for buffers",
--   group = augroup("increase_numberwidth", { clear = true }),
--   callback = function()
--     local line_count = vim.api.nvim_buf_line_count(0)
--     if line_count >= 100 and line_count < 1000 then
--       vim.opt_local.numberwidth = 5
--     elseif line_count > 1000 and line_count < 10000 then
--       vim.opt_local.numberwidth = 6
--     elseif line_count >= 10000 then
--       vim.opt_local.numberwidth = 7
--     end
--   end,
-- })

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})
