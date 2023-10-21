---@diagnostic disable: undefined-field, deprecated, unused-local
return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local utils = require("utils")
    local icons = require("utils.icons")
    local colors = require("utils.colors")
    local colors_default = colors.default

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode" },
        },
        lualine_b = {
          {
            "branch",
            icon = { icons.GitConflict },
            on_click = function()
              vim.cmd("Telescope git_branches")
            end,
            color = { fg = colors_default.magenta, bg = "" },
            padding = { left = 2, right = 1 },
          },
        },
        lualine_c = {
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { "filename", path = 0, symbols = { modified = icons.FileModified, readonly = "", unnamed = "" } },
          {
            "diff",
            symbols = {
              added = icons.GitAdd .. " ",
              modified = icons.GitChange .. " ",
              removed = icons.GitDelete .. " ",
            },
            diff_color = {
              -- Same color values as the general color option can be used here.
              added = { fg = colors_default.green }, -- Changes the diff's added color
              modified = { fg = colors_default.yellow }, -- Changes the diff's modified color
              removed = { fg = colors_default.red1 }, -- Changes the diff's removed color you
            },
            on_click = function()
              vim.cmd("Telescope git_status")
            end,
          },
          {
            "diagnostics",
            symbols = {
              error = icons.DiagnosticError .. " ",
              warn = icons.DiagnosticWarn .. " ",
              info = icons.DiagnosticInfo .. " ",
              hint = icons.DiagnosticHint .. " ",
            },
            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = { fg = colors_default.red1 }, -- Changes diagnostics' error color.
              warn = { fg = colors_default.yellow }, -- Changes diagnostics' warn color.
              info = { fg = colors_default.blue }, -- Changes diagnostics' info color.
              hint = { fg = colors_default.green }, -- Changes diagnostics' hint color.
            },
            on_click = function()
              vim.cmd("Telescope diagnostics bufnr=0")
            end,
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = utils.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = utils.fg("Debug"),
          },
          -- stylua: ignore
          -- {
          --   'vim.fn["codeium#GetStatusString"]()',
          --   fmt = function(str) return icons.Codeium .. str end,
          --   cond = function() return package.loaded["codeium"] end,
          --   color = { fg = colors_default.green1 },
          --   on_click = function()
          --     if vim.fn["codeium#GetStatusString"]() == "OFF" then
          --       vim.cmd("CodeiumEnable")
          --     else
          --       vim.cmd("CodeiumDisable")
          --     end
          --   end,
          -- },
          {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
              return "Tab:" .. shiftwidth
            end,
            color = utils.fg("Special"),
            padding = 1,
          },
          { "encoding", color = utils.fg("Special") },
          {
            "filetype",
            icon_only = false,
            color = utils.fg("Special"),
            separator = "",
            padding = 1,
          },
          -- {
          --   require("lazy.status").updates,
          --   cond = require("lazy.status").has_updates,
          --   color = utils.fg("Special"),
          --   on_click = function()
          --     vim.cmd("Lazy")
          --   end,
          -- },
          -- {
          --   function()
          --     local status = {
          --       spring = "🌴",
          --       summer = "🌊",
          --       autumn = "🎃",
          --       winter = "🏂",
          --     }
          --     local season = utils.current_season()
          --
          --     return status[season]
          --   end,
          -- },
        },
        lualine_y = {
          {
            function()
              local names = {}
              for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                table.insert(names, server.name)
              end
              return icons.ActiveLSP .. " " .. table.concat(names, " ")
            end,
            color = { fg = colors_default.green, bg = "" },
            on_click = function()
              vim.cmd("LspInfo")
            end,
          },
        },
        lualine_z = {
          {
            "location",
            separator = " ",
            padding = 1,
          },
          -- {
          --   "progress",
          --   padding = 1,
          -- },
        },
      },
      extensions = {
        "aerial",
        "lazy",
        "man",
        "neo-tree",
        "quickfix",
        "toggleterm",
        "trouble",
      },
    }
  end,
}
