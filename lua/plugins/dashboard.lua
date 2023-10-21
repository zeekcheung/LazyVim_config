return {
  "nvimdev/dashboard-nvim",
  dependencies = "akinsho/bufferline.nvim",
  opts = {
    theme = "doom",
    hide = {
      -- this is taken care of by lualine
      -- enabling this messes up the actual laststatus setting after loading a file
      statusline = false,
      tabline = true,
      winbar = true,
    },
  },
}
