return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  enabled = false,
  -- stylua: ignore
  keys = {
    { mode = "i", "<C-g>", function() return vim.fn['codeium#Accept']() end, expr = true, silent = true },
    { mode = "i", "<c-,>", function() return vim.fn['codeium#CycleCompletions'](1) end, expr = true, silent = true },
    { mode = "i", "<c-.>", function() return vim.fn['codeium#CycleCompletions'](-1) end, expr = true, silent = true },
    { mode = "i", "<c-x>", function() return vim.fn['codeium#Clear']() end, expr = true, silent = true },
  },
}
