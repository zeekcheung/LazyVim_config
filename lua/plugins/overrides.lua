local LazyVimUtil = require("lazyvim.util")
local Config = require("config")
local Lualine_components = require("util.lualine")

local icons = Config.icons

return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- configure LazyVim to load colorscheme
      colorscheme = "rose-pine",
    },
  },

  { "rose-pine/neovim", name = "rose-pine" },

  { "folke/neodev.nvim", enabled = false },
  { "nvim-pack/nvim-spectre", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            on_click = function()
              vim.cmd("Telescope git_branches")
            end,
          },
        },

        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { LazyVimUtil.lualine.pretty_path() },
          { "filename" },
          -- {
          --   "diff",
          --   symbols = {
          --     added = icons.git.added,
          --     modified = icons.git.modified,
          --     removed = icons.git.removed,
          --   },
          --   source = function()
          --     local gitsigns = vim.b.gitsigns_status_dict
          --     if gitsigns then
          --       return {
          --         added = gitsigns.added,
          --         modified = gitsigns.changed,
          --         removed = gitsigns.removed,
          --       }
          --     end
          --   end,
          --   on_click = function()
          --     vim.cmd("Telescope git_status")
          --   end,
          -- },

          Lualine_components.diagnostics(),
        },
        lualine_x = {
          -- -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = LazyVimUtil.ui.fg("Statement"),
          -- },
          -- -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --   color = LazyVimUtil.ui.fg("Constant"),
          -- },
          -- -- stylua: ignore
          -- {
          --   function() return "  " .. require("dap").status() end,
          --   cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          --   color = LazyVimUtil.ui.fg("Debug"),
          -- },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = LazyVimUtil.ui.fg("Special"),
          },
          Lualine_components.codeium(),
          { "fileformat" },
          { "encoding" },
          Lualine_components.indent(),
          -- Lualine_components.lsp_info(),
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 1 } },
          -- Lualine_components.season()
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      extensions = { "neo-tree", "lazy" },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    dependencies = "akinsho/bufferline.nvim",
    init = function()
      -- Hide the cmdline before DashboardLoaded
      vim.opt.cmdheight = 0
  
      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function()
          vim.opt.cmdheight = 1
        end,
      })
    end,
    opts = function(_, opts)
      local logo = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
  ]]

      -- padding-top: 2 * \n
      logo = string.rep("\n", 2) .. logo .. "\n"

      opts.hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
        tabline = true,
        winbar = true,
      }

      opts.config.header = vim.split(logo, "\n")

      -- stylua: ignore
      opts.config.center = {
        { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
        { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
        { action = "Telescope oldfiles",                                       desc = " Old files",    icon = " ", key = "o" },
        -- { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
        { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
        { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
      }

      -- format dashboard center
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
    end,
  },

  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>x", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer",
      },
      { "<C-e>", "<leader>e", desc = "Explorer", remap = true },
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end

      -- Disable netrw for Neo-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      enable_git_status = true,
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = {
        winbar = false, -- toggle to show selector on winbar
        content_layout = "center",
        tabs_layout = "equal",
        show_separator_on_edge = true,
        sources = {
          { source = "filesystem", display_name = icons.FileSystem },
          { source = "buffers", display_name = icons.DefaultFile },
          { source = "git_status", display_name = icons.Git },
          -- { source = "document_symbols", display_name = icons.Symbol },
        },
      },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = false },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = icons.folder.closed,
          folder_open = icons.folder.open,
          folder_empty = icons.folder.empty,
          default = icons.file.default,
        },
        modified = { symbol = icons.file.modified },
        git_status = {
          symbols = {
            added = icons.git.added,
            deleted = icons.git.removed,
            modified = icons.git.modified,
            renamed = icons.git.renamed,
            untracked = icons.git.untracked,
            ignored = icons.git.ignored,
            unstaged = icons.git.unstaged,
            staged = icons.git.staged,
            conflict = icons.git.conflict,
          },
        },
      },

      window = {
        mappings = {
          ["H"] = "prev_source",
          ["L"] = "next_source",
          ["<Tab>"] = "prev_source",
          ["<S-Tab>"] = "next_source",
          ["s"] = "none", -- disable default mappings
          ["<leftrelease>"] = "open", -- open node with single left click
        },
      },

      -- define custom event handlers
      -- see: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/events/init.lua
      -- event_handlers = {
      --   -- start editing file after adding
      --   {
      --     event = "file_added",
      --     handler = function(file_path)
      --       -- vim.cmd("edit " .. file_path .. "| startinsert!")
      --       vim.cmd("edit " .. file_path .. "| Neotree Toggle")
      --     end,
      --   },
      -- },
    },
  },

  {
    "folke/noice.nvim",
    enabled = false,
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      lsp = {
        progress = {
          enabled = false,
        },
      },
      routes = {
        -- Hide written messages
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          opts = { skip = true },
        },
      },
    },
    keys = {
      { "<c-f>", false, mode = { "i", "n", "s" } },
      { "<c-b>", false, mode = { "i", "n", "s" } },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local border_opts = {
        border = "rounded",
        -- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }

      opts.completion.completeopt = "menu,menuone,noselect"

      opts.window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          header = false,
          border = "rounded",
          focusable = true,
        },
      },
      inlay_hints = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      -- options for vim.lsp.buf.format
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 2000,
      top_down = false,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    keys = {
      { "<leader>ut", false },
      {
        "<leader>uC",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
          if LazyVimUtil.inject.get_upvalue(tsc.toggle, "enabled") then
            LazyVimUtil.info("Enabled Treesitter Context", { title = "Option" })
          else
            LazyVimUtil.warn("Disabled Treesitter Context", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
    keys = {
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer" },
      -- stylua: ignore
      { "<leader>fc", function() LazyVimUtil.telescope.config_files()() end, desc = "Config" },
      { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>fd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document diagnostics",
      },
      {
        "<leader>fD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace diagnostics",
      },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      -- { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      -- { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>ft", false },
      { "<leader>fT", false },
      -- git
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "branches" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "files" },
      { "<leader>gs", "<cmd>Telescope git_stash<CR>", desc = "statsh" },
      { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>sk", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>so", false },
      { "<leader>sR", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>uC", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      {
        "<leader>ft",
        LazyVimUtil.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with preview",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>xt", false },
      { "<leader>xT", false },
      { "<leader>st", false },
      { "<leader>sT", false },
      { "<leader>uT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Toggle Todo" },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", false },
      { "<leader>xX", false },
      { "<leader>xL", false },
      { "<leader>xQ", false },
      { "<leader>ut", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Toggle Trouble" },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>f"] = { name = "+find" },
        ["<leader>q"] = { name = "+quit" },
        ["<leader>s"] = { name = "+session" },
        ["<leader>t"] = { name = "+terminal" },
      },
    },
  },
}
