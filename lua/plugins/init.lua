return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    enabled = false,
    -- stylua: ignore
    keys = {
      { mode = "i", "<C-g>", function() return vim.fn['codeium#Accept']() end,             expr = true, silent = true },
      { mode = "i", "<c-,>", function() return vim.fn['codeium#CycleCompletions'](1) end,  expr = true, silent = true },
      { mode = "i", "<c-.>", function() return vim.fn['codeium#CycleCompletions'](-1) end, expr = true, silent = true },
      { mode = "i", "<c-x>", function() return vim.fn['codeium#Clear']() end,              expr = true, silent = true },
    },
  },

  {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },

    -- you can specify also another config if you want
    config = function()
      require("gx").setup({
        open_browser_app = "powershell.exe", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
        -- open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
        handlers = {
          plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
          github = true, -- open github issues
          brewfile = true, -- open Homebrew formulaes and casks
          package_json = true, -- open dependencies from package.json
          search = true, -- search the web/selection on the web if nothing else is found
        },
        handler_options = {
          search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
          -- search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
        },
      })
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      })
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    event = "BufReadPost",
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

  {
    "folke/zen-mode.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = function()
          return math.min(120, vim.o.columns * 0.75)
        end, -- width of the Zen window
        height = 0.9, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = "no", -- disable signcolumn
          number = true, -- enable number column
          relativenumber = true, -- enable relative numbers
          cursorline = true, -- enable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win) end,
      -- callback where you cakn add custom code when the Zen window closes
      on_close = function() end,
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

    {
      "smjonas/inc-rename.nvim",
      cmd = "IncRename",
      keys = {
        { "<leader>rn", ":IncRename ", desc = "Rename" },
      },
      config = true,
    },
  },
}
