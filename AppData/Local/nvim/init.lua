-- Set CC environment variable for tree-sitter compilation
vim.env.PATH = "C:/tools/msys64/mingw64/bin;" .. vim.env.PATH
vim.env.CC = "gcc"
vim.env.CXX = "g++"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
