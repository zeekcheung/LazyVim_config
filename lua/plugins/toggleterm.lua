return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },
      { "<F7>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      {
        "<leader>tt",
        function()
          local cmd = tostring(math.floor(vim.fn.rand(vim.fn.srand()) % 1000 + 1)) .. "ToggleTerm"
          vim.cmd(cmd)
        end,
        desc = "ToggleTerm new",
      },

      { mode = "t", "<esc>", [[<C-\><C-n>]], buffer = 0 },
      { mode = "t", "<C-h>", [[<Cmd>wincmd h<CR>]], buffer = 0 },
      { mode = "t", "<C-j>", [[<Cmd>wincmd j<CR>]], buffer = 0 },
      { mode = "t", "<C-k>", [[<Cmd>wincmd k<CR>]], buffer = 0 },
      { mode = "t", "<C-l>", [[<Cmd>wincmd l<CR>]], buffer = 0 },
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      on_create = function()
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
      end,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = { border = "rounded" },
      hide_numbers = true,
      autochdir = true,
      start_in_insert = false,
      winbar = {
        enabled = false,
      },
      close_on_exit = true,
      auto_scroll = false,
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      plugins = { spelling = true },
      defaults = {
        ["<leader>t"] = { name = "+terminal" },
      },
    },
  },
}
