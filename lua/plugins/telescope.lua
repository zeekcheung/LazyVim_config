local icons = require("utils.icons")
local Util = require("lazyvim.util")
local telescope_builtin = require("telescope.builtin")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = icons.Selected .. " ",
        selection_caret = icons.Selected .. " ",
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
      { "<leader>fc", function() Util.telescope.config_files()() end, desc = "Config" },
      { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
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
      { "<leader>sg", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sG", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<c-f>", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<c-F>", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>uc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>f"] = { name = "+find" },
      },
    },
  },
}
