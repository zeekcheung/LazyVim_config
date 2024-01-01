local Config = require("config")
local Util = require("util")

local icons = Config.icons
local colors = Config.colors

local M = {}

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
    on_click = function()
      vim.cmd("Telescope diagnostics bufnr=0")
    end,
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

function M.lsp_info()
  return {
    function()
      local names = {}
      for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return " " .. table.concat(names, " ")
    end,
    color = { fg = colors.green, bg = "" },
    on_click = function()
      vim.cmd("LspInfo")
    end,
  }
end

function M.codeium()
  return {
    'vim.fn["codeium#GetStatusString"]()',
    fmt = function(str)
      return icons.Codeium .. str
    end,
    cond = function()
      -- return package.loaded["codeium"]
      return package.loaded["codeium"]
    end,
    color = { fg = colors.green1 },
    on_click = function()
      if vim.fn["codeium#GetStatusString"]() == "OFF" then
        vim.cmd("CodeiumEnable")
      else
        vim.cmd("CodeiumDisable")
      end
    end,
  }
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
      local season = Util.current_season()

      return status[season]
    end,
  }
end

return M
