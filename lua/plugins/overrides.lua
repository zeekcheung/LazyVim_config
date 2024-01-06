local LazyVimUtil = require("lazyvim.util")
local Util = require("util")
local Lualine_components = require("util.lualine")

local icons = Util.icons

local disabled_plugin_keys = function(keys)
  local disabled_keys = {}
  for i, key in ipairs(keys) do
    disabled_keys[i] = { key, false }
  end
  return unpack(disabled_keys)
end

return {
  -- Disable default plugins
  { "folke/neodev.nvim", enabled = false },
  { "nvim-pack/nvim-spectre", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },

  {
    "akinsho/bufferline.nvim",
    keys = {
      disabled_plugin_keys({ "<S-h>", "<S-l>" }),

      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
        diagnostics = "",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "",
        -- section_separators = '',
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          Lualine_components.branch(),
        },

        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename" },
          Lualine_components.diagnostics(),
          -- Lualine_components.diff(),
        },
        lualine_x = {
          Lualine_components.lazy_status(),
          Lualine_components.codeium(),
          { "fileformat" },
          { "encoding" },
          -- Lualine_components.indent(),
          Lualine_components.lsp_info(),
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 1 } },
          -- Lualine_components.season()
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    dependencies = "akinsho/bufferline.nvim",
    init = function()
      -- Hide the cmdline before DashboardLoaded
      -- vim.opt.cmdheight = 0

      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "DashboardLoaded",
      --   callback = function()
      --     vim.opt.cmdheight = 1
      --   end,
      -- })
    end,
    opts = function(_, opts)
      -- stylua: ignore
      local logo = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
  ]]

      -- padding-top: 2 * \n
      logo = string.rep("\n", 2) .. logo .. ""

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
        { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
        -- { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
        { action = "Telescope projects",                                       desc = " Projects",        icon = " ", key = "p" },
        { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
        { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
      }

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
      -- stylua: ignore
      disabled_plugin_keys({ "<leader>fe", "<leader>fE" }),

      {
        "<leader>e",
        function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end,
        desc = "Explorer",
      },
      { "<C-e>", "<leader>e", desc = "Explorer", remap = true },
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require("neo-tree") end
      end

      -- Disable netrw for Neo-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      enable_git_status = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
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
          -- ["H"] = "prev_source",
          -- ["L"] = "next_source",
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
    "L3MON4D3/LuaSnip",
    keys = function() return {} end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- opts.completion.completeopt = "menu,menuone,noselect"
      opts.completion.completeopt = "menu,menuone,noinsert"

      opts.window = {
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
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
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
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
    },
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
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
      -- stylua: ignore
      disabled_plugin_keys({
        "<leader>s", "<leader>sa", "<leader>sb", "<leader>sc", "<leader>sC", "<leader>sd", "<leader>sD",
        "<leader>ft", "<leader>fT", "<leader>sg", "<leader>sG", "<leader>sh", "<leader>sH", "<leader>sK",
        "<leader>sm", "<leader>sM", "<leader>so", "<leader>sR", "<leader>ss", "<leader>sS", "<leader>sw",
        "<leader>sW", "<leader>uC"
      }),

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
      { "<C-p>", "<leader>ff", remap = true, desc = "Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      -- { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      -- { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      {
        "<leader>ft",
        LazyVimUtil.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with preview",
      },
      -- git
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "branches" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "files" },
      { "<leader>gs", "<cmd>Telescope git_stash<CR>", desc = "statsh" },
      { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "status" },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      -- stylua: ignore
      disabled_plugin_keys({ "<leader>xt", "<leader>xT", "<leader>st", "<leader>sT" }),
      { "<leader>xT", false },

      { "<leader>uT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Toggle Todo" },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      -- stylua: ignore
      -- disabled_plugin_keys({ "<leader>xx", "<leader>xX", "<leader>xL", "<leader>xQ" }),
      { "<leader>xL", false },
      { "<leader>xQ", false },
      { "<leader>xX", false },
      { "<leader>xT", false },

      { "<leader>ut", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Toggle Trouble" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>f"] = { name = "+find" },
        ["<leader>q"] = { name = "+quit" },
        ["<leader>s"] = { name = "+session" },
        ["<leader>t"] = { name = "+terminal" },
      },
    },
  },

  {
    "folke/noice.nvim",
    enabled = false,
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
    -- stylua: ignore
    keys = {
      disabled_plugin_keys(
        {"<S-Enter>", "<leader>snl", "<leader>snh", "<leader>sna", "<leader>snd", "<c-f>", "<c-b>"}
      ),
    },
  },
}
