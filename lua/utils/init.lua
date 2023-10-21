local M = {}

-- Check if the plugin is available
---@param plugin string check lazy-lock.json
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

-- Opens a floating terminal (interactive by default)
function M.float_term(Terminal, cmd, opts)
  opts = opts or {}
  local default_opts = {
    cmd = cmd,
    direction = "float",
    float_opts = { border = "curved" },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<F7>", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  }

  for key, value in pairs(opts) do
    default_opts[key] = value
  end

  return Terminal:new(default_opts)
end

function M.foldtext()
  local text = vim.treesitter.foldtext()

  local n_lines = vim.v.foldend - vim.v.foldstart
  local text_lines = " lines"

  if n_lines == 1 then
    text_lines = " line"
  end

  -- stylua: ignore
  table.insert(
---@diagnostic disable-next-line: param-type-mismatch
    text,
    { " ··········· " .. n_lines .. text_lines .. " folded ···········" }
  )

  return text
end

-- Get current season
function M.current_season()
  local os = require("os")
  local currentMonth = tonumber(os.date("%m"))
  local seasons = { "winter", "spring", "summer", "autumn" }

  return seasons[math.floor((currentMonth % 12) / 3) + 1]
end

return M
