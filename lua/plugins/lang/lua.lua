return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
                maxPreload = 10000,
                preloadFileSize = 2000,
              },
              completion = {
                callSnippet = "Replace",
              },
              telemetry = {
                enable = false,
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = true,
              },
            },
          },
        },
      },
    },
  },
}
