local LazyVimUtil = require("lazyvim.util")

local M = {}

local function bool2str(bool)
  return bool and "on" or "off"
end

-- Toggle conceal
function M.toggle_conceal()
  local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
  LazyVimUtil.toggle("conceallevel", false, { 0, conceallevel })
end

-- Toggle Treesitter Highlight
function M.toggle_ts_hightlight()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
  else
    vim.treesitter.start()
  end
end

--- Toggle background="dark"|"light"
---@param silent? boolean if true then don't sent a notification
function M.toggle_background(silent)
  vim.go.background = vim.go.background == "light" and "dark" or "light"
  vim.notify(string.format("background=%s", vim.go.background))
end

--- Toggle showtabline=2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_tabline(silent)
  vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
  vim.notify(string.format("tabline %s", bool2str(vim.opt.showtabline:get() == 2)))
end

--- Toggle laststatus=3|2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_statusline(silent)
  local laststatus = vim.opt.laststatus:get()
  local status
  if laststatus == 0 then
    vim.opt.laststatus = 2
    status = "local"
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
    status = "global"
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
    status = "off"
  end
  vim.notify(string.format("statusline %s", status))
end

--- Toggle signcolumn="auto"|"no"
---@param silent? boolean if true then don't sent a notification
function M.toggle_signcolumn(silent)
  if vim.wo.signcolumn == "no" then
    vim.wo.signcolumn = "yes"
  elseif vim.wo.signcolumn == "yes" then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  vim.notify(string.format("signcolumn=%s", vim.wo.signcolumn))
end

local last_active_foldcolumn
--- Toggle foldcolumn=0|1
---@param silent? boolean if true then don't sent a notification
function M.toggle_foldcolumn(silent)
  local curr_foldcolumn = vim.wo.foldcolumn
  if curr_foldcolumn ~= "0" then
    last_active_foldcolumn = curr_foldcolumn
  end
  vim.wo.foldcolumn = curr_foldcolumn == "0" and (last_active_foldcolumn or "1") or "0"
  vim.notify(string.format("foldcolumn=%s", vim.wo.foldcolumn))
end

--- Change the number display modes
---@param silent? boolean if true then don't sent a notification
function M.toggle_line_number(silent)
  local number = vim.wo.number -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if not number and not relativenumber then
    vim.wo.number = true
  elseif number and not relativenumber then
    vim.wo.relativenumber = true
  elseif number and relativenumber then
    vim.wo.number = false
  else -- not number and relativenumber
    vim.wo.relativenumber = false
  end
  vim.notify(string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber)))
end

return M
