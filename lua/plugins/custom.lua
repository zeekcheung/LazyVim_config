vim.g.codeium_plugin_enabled = true
vim.g.codeium_enabled = false

return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- configure LazyVim to load colorscheme
      colorscheme = "everforest",
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      opts.integrations.treesitter_context = false

      opts.custom_highlights = {
        PmenuSel = { bg = "NONE", fg = mocha.green },
        -- CmpItemAbbrMatch = { fg = mocha.green, style = { "bold" } },
        -- CmpItemAbbrMatchFuzzy = { fg = mocha.green, style = { "bold" } },
      }

      require("catppuccin").setup(opts)
    end,
  },

  -- {
  --   "sainnhe/gruvbox-material",
  --   config = function(_, opts)
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_foreground = "material"
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_enable_italic = 1
  --     vim.g.gruvbox_material_dim_inactive_windows = 0
  --     vim.g.gruvbox_material_menu_selection_background = "green"
  --     vim.g.gruvbox_material_show_eob = 0
  --     vim.g.gruvbox_material_diagnostic_text_highlight = 1
  --     -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
  --     vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
  --     vim.g.gruvbox_material_statusline_style = "mix"
  --   end,
  -- },

  {
    "sainnhe/everforest",
    config = function()
      vim.o.background = "dark"
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_transparent_background = 2
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_show_eob = 0
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "colored"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "LazyFile",
    config = true,
  },

  {
    "j-hui/fidget.nvim",
    enabled = false,
    event = "LazyFile",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  {
    "Exafunction/codeium.vim",
    enabled = vim.g.codeium_plugin_enabled,
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { mode = "i", "<C-g>", function() return vim.fn['codeium#Accept']() end,             expr = true, silent = true },
      { mode = "i", "<c-,>", function() return vim.fn['codeium#CycleCompletions'](1) end,  expr = true, silent = true },
      { mode = "i", "<c-.>", function() return vim.fn['codeium#CycleCompletions'](-1) end, expr = true, silent = true },
      { mode = "i", "<c-x>", function() return vim.fn['codeium#Clear']() end,              expr = true, silent = true },
    },
  },

  {
    "CRAG666/code_runner.nvim",
    event = "LazyFile",
    cmd = { "RunCode", "RunFile", "RunClose", "RunProject" },
    keys = {
      { "<f5>", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rc", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    },
    opts = {},
  },

  {
    "mrjones2014/smart-splits.nvim",
    event = "LazyFile",
    keys = {
      { "<C-Up>", "<cmd>SmartResizeUp<cr>", "Resize Up" },
      { "<C-Down>", "<cmd>SmartResizeDown<cr>", "Resize Down" },
      { "<C-Left>", "<cmd>SmartResizeLeft<cr>", "Resize Left" },
      { "<C-Right>", "<cmd>SmartResizeRight<cr>", "Resize Right" },
    },
    opts = {
      -- Ignored filetypes (only while resizing)
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "qf",
        "prompt",
      },
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = { "nofile" },
    },
  },

  {
    "smjonas/inc-rename.nvim",
    event = "LazyFile",
    cmd = "IncRename",
    keys = {
      { "<leader>rn", ":IncRename ", desc = "Rename" },
    },
    config = true,
  },

  {
    "karb94/neoscroll.nvim",
    event = "LazyFile",
    enabled = not vim.g.neovide,
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-f>", "<C-b>" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = nil,
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
      })
    end,
  },

  {
    "chrishrb/gx.nvim",
    event = "LazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gx").setup({
        open_browser_app = require("lazyvim.util").is_win() and "powershell.exe" or "xdg-open",
        handlers = {
          plugin = true,
          github = true,
          brewfile = true,
          package_json = true,
          search = true,
        },
        handler_options = {
          search_engine = "google",
        },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    event = "LazyFile",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 1,
        width = function() return math.min(120, vim.o.columns * 0.75) end,
        height = 0.9,
        options = {
          signcolumn = "no",
          number = true,
          relativenumber = true,
          cursorline = true,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4",
        },
        alacritty = {
          enabled = false,
          font = "14",
        },
        wezterm = {
          enabled = false,
          font = "+4",
        },
      },
      on_open = function(win) end,
      on_close = function() end,
    },
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
}
