return {
  "folke/noice.nvim",
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
}
