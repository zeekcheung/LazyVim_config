local icons = require("utils.icons")
local Util = require("lazyvim.util")

return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    { "<leader>fe", false },
    { "<leader>fE", false },
  },
  opts = {
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
        folder_closed = icons.FolderClosed,
        folder_open = icons.FolderOpen,
        folder_empty = icons.FolderEmpty,
        default = icons.DefaultFile,
      },
      modified = { symbol = icons.FileModified },
      git_status = {
        symbols = {
          added = icons.GitAdd,
          deleted = icons.GitDelete,
          modified = icons.GitChange,
          renamed = icons.GitRenamed,
          untracked = icons.GitUntracked,
          ignored = icons.GitIgnored,
          unstaged = icons.GitUnstaged,
          staged = icons.GitStaged,
          conflict = icons.GitConflict,
        },
      },
    },

    window = {
      mappings = {
        ["H"] = "prev_source",
        ["L"] = "next_source",
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
}
