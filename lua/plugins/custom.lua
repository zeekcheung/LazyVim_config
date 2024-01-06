return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- configure LazyVim to load colorscheme
      colorscheme = "catppuccin",
    },
  },
  --
  -- { "rose-pine/neovim", name = "rose-pine" },

  {
    "sainnhe/gruvbox-material",
    config = function(_, opts)
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_show_eob = 0
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_statusline_style = "mix"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "LazyFile",
    config = true,
  },

  {
    "j-hui/fidget.nvim",
    event = "LazyFile",
    opts = {},
  },

  {
    "Exafunction/codeium.vim",
    event = "LazyFile",
    enabled = false,
    -- stylua: ignore
    keys = {
      { mode = "i", "<C-g>", function() return vim.fn['codeium#Accept']() end,             expr = true, silent = true },
      { mode = "i", "<c-,>", function() return vim.fn['codeium#CycleCompletions'](1) end,  expr = true, silent = true },
      { mode = "i", "<c-.>", function() return vim.fn['codeium#CycleCompletions'](-1) end, expr = true, silent = true },
      { mode = "i", "<c-x>", function() return vim.fn['codeium#Clear']() end,              expr = true, silent = true },
    },
  },

  -- {
  --   "Exafunction/codeium.nvim",
  --   event = "LazyFile",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function() require("codeium").setup({}) end,
  -- },

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
        open_browser_app = "powershell.exe",
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

    {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
    },

    -- {
    --   "b0o/incline.nvim",
    --   event = "BufReadPre",
    --   config = function()
    --     require("incline").setup({
    --       highlight = {
    --         groups = {
    --           InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
    --           InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
    --         },
    --       },
    --       window = { margin = { vertical = 0, horizontal = 1 } },
    --       render = function(props)
    --         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    --         local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    --         return { { icon, guifg = color }, { " " }, { filename } }
    --       end,
    --     })
    --   end,
    -- },

    -- {
    --   "cshuaimin/ssr.nvim",
    --   keys = {
    --     {
    --       "<leader>sr",
    --       function()
    --         require("ssr").open()
    --       end,
    --       mode = { "n", "x" },
    --       desc = "Structural Replace",
    --     },
    --   },
    -- },

    -- {
    --   "mg979/vim-visual-multi",
    --   event = { "BufReadPre", "BufNewFile" },
    -- },
  },
}
