return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "folke/snacks.nvim", -- Recomendado pero opcional
  },
  keys = {
    {
      "<leader>fy",
      "<cmd>Yazi<cr>",
      desc = "Abrir Yazi en el directorio actual",
    },
    {
      "<leader>fY",
      "<cmd>Yazi cwd<cr>",
      desc = "Abrir Yazi en el directorio raíz del proyecto",
    },
    -- {
    --   "<C-Up>",
    --   "<cmd>Yazi toggle<cr>",
    --   desc = "Volver a la última sesión de Yazi",
    -- },
  },
  opts = {
    open_for_directories = true, -- Si quieres abrir carpetas directamente en Yazi
    keymaps = {
      -- Puedes personalizar atajos aquí si quieres
    },
  },
}
