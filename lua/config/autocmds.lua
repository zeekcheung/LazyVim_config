-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Use Powershell as default shell on Windows
autocmd("VimEnter", {
  group = augroup("use_powershell_shell", { clear = true }),
  callback = function()
    local os_type = vim.loop.os_uname().sysname
    if string.match(os_type, "Windows") then
      vim.opt.shell = "pwsh -nologo"
      vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
      vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
      vim.opt.shellquote = ""
      vim.opt.shellxquote = ""
    end
  end,
})

-- Increase numberwidth for buffers
autocmd("BufEnter", {
  desc = "Increase numberwidth for buffers",
  group = augroup("increase_numberwidth", { clear = true }),
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 100 and line_count < 1000 then
      vim.opt_local.numberwidth = 5
    elseif line_count > 1000 and line_count < 10000 then
      vim.opt_local.numberwidth = 6
    elseif line_count >= 10000 then
      vim.opt_local.numberwidth = 7
    end
  end,
})
