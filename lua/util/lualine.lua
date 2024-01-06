local LazyVimUtil = require("lazyvim.util")
local Util = require("util")

local icons = Util.icons
local colors = Util.colors

local M = {}

function M.branch()
  return {
    "branch",
    on_click = function() vim.cmd([[Telescope git_branches]]) end,
  }
end

function M.codeium()
  return {
    "vim.fn[\"codeium#GetStatusString\"]()",
    fmt = function(str) return icons.misc .. str end,
    cond = function()
      -- return package.loaded["codeium"]
      return package.loaded["codeium"]
    end,
    color = { fg = colors.green1 },
    on_click = function()
      if vim.fn["codeium#GetStatusString"]() == "OFF" then
        vim.cmd([[CodeiumEnable]])
      else
        vim.cmd([[CodeiumDisable]])
      end
    end,
  }
end

function M.diagnostics()
  return {
    "diagnostics",
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warn,
      info = icons.diagnostics.Info,
      hint = icons.diagnostics.Hint,
    },
    -- always_visible = true,
    on_click = function() vim.cmd([[Telescope diagnostics bufnr=0]]) end,
  }
end

function M.diff()
  return {
    "diff",
    symbols = {
      added = icons.git.added,
      modified = icons.git.modified,
      removed = icons.git.removed,
    },
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
    on_click = function() vim.cmd("Telescope git_status") end,
  }
end

function M.indent()
  return {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return "Tab:" .. shiftwidth
    end,
    padding = 1,
  }
end

function M.lazy_status()
  return {
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    color = LazyVimUtil.ui.fg("Special"),
  }
end

function M.lsp_info()
  return {
    function()
      local names = {}
      for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return " " .. table.concat(names, " ")
    end,
    color = { fg = colors.green },
    on_click = function() vim.cmd([[LspInfo]]) end,
  }
end

local function get_current_season()
  local os = require("os")
  local currentMonth = tonumber(os.date("%m"))
  local seasons = { "winter", "spring", "summer", "autumn" }

  return seasons[math.floor((currentMonth % 12) / 3) + 1]
end

function M.season()
  return {
    function()
      local status = {
        spring = "🌴",
        summer = "🌊",
        autumn = "🎃",
        winter = "🏂",
      }
      local season = get_current_season()

      return status[season]
    end,
  }
end

return M
