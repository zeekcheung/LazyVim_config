return {
  {
    "folke/persistence.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>qs", false },
      { "<leader>ql", false  },
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>s"] = { name = "+search/session" },
        ["<leader>q"] = { name = "+quit" },
      },
    },
  },
}
