return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      shell = "pwsh -NoLogo -ExecutionPolicy Bypass",
      win = {
        position = "bottom",
        height = 0.3,
      },
    },
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = false,
          exclude = { ".git" },
        },
        grep = {
          hidden = true,
          ignored = false,
          exclude = { ".git" },
        },
      },
    },
  },
}
