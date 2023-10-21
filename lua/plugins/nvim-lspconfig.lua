return {
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
}
