if not vim.g.vscode then
  return
end

local Vscode = require("vscode-neovim")

local action = Vscode.action
local call = Vscode.call
local map = vim.keymap.set

vim.notify = Vscode.notify

-- fold
map("n", "za", function()
  call("editor.toggleFold")
end)
map("n", "zR", function()
  call("editor.toggleAll")
end)
map("n", "zM", function()
  call("editor.foldAll")
end)
map("n", "zo", function()
  call("editor.unfold")
end)
map("n", "zc", function()
  call("editor.fold")
end)
map("n", "zC", function()
  call("editor.foldRecursively")
end)

-- code
map("n", "<leader>ca", function()
  call("editor.action.quickFix")
end)
map("n", "<leader>cr", function()
  call("editor.action.rename")
end)
map("n", "<leader>cf", function()
  call("editor.action.formatDocument")
end)
map("n", "<leader>cs", function()
  call("outline.focus")
  call("outline.collapse")
end)

-- find
map("n", "<leader>fc", function()
  call("workbench.action.openSettings")
end)
map("n", "<leader>fC", function()
  call("workbench.action.showCommands")
end)
map("n", "<leader>ff", function()
  call("workbench.action.quickOpen")
end)
map("n", "<leader>fk", function()
  call("workbench.action.openGlobalKeybindings")
end)
map("n", "<leader>fs", function()
  call("workbench.action.gotoSymbol")
end)
map("n", "<leader>fw", function()
  call("workbench.action.findInFiles")
end)
map("n", "<leader>uc", function()
  call("workbench.action.selectTheme")
end)

-- toggle
map("n", "<leader>e", function()
  call("workbench.action.toggleSidebarVisibility")
end)
map("n", "<leader>z", function()
  call("workbench.action.toggleZenMode")
end)
map("n", "<leader>ut", function()
  call("workbench.action.selectTheme")
end)
map("n", "<leader>up", function()
  call("workbench.actions.view.problem")
end)
map("n", "<leader>uw", function()
  call("workbench.action.toggleWordWrap")
end)

-- git
map("n", "<leader>g", function()
  call("workbench.scm.focus")
end)

-- goto
map("n", "gr", function()
  call("references-view.findReferences")
end)
map("n", "gi", function()
  call("editor.action.goToImplementation")
end)
