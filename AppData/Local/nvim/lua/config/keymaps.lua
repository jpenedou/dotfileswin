-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal toggle (fix tid estable, pwsh, horizontal split)
vim.keymap.set({ "n", "t" }, "<C-/>", function()
  Snacks.terminal(nil, { count = 1 })
end, { desc = "Toggle Terminal" })

vim.keymap.set({ "n", "t" }, "<C-_>", function()
  Snacks.terminal(nil, { count = 1 })
end, { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>T", function()
  Snacks.terminal(nil, { count = 1 })
end, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
if vim.g.vscode then
  local opts = { desc = "Find References (VSCode)" }
  vim.keymap.set("n", "gr", function()
    vim.cmd('call VSCodeNotify("editor.action.referenceSearch.trigger")')
  end, opts)

  vim.keymap.set("v", "gr", function()
    vim.cmd('call VSCodeNotify("editor.action.referenceSearch.trigger")')
  end, opts)

  opts = { desc = "Go to Implementation (VSCode)" }

  vim.keymap.set("n", "gI", function()
    vim.cmd('call VSCodeNotify("editor.action.goToImplementation")')
  end, opts)

  vim.keymap.set("v", "gI", function()
    vim.cmd('call VSCodeNotify("editor.action.goToImplementation")')
  end, opts)
end
