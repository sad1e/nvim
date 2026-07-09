return {
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
        nvim_tree_darker = true,
      })
      vim.cmd.colorscheme("vscode_modern")
    end,
  },
  { "nivmdev/dashboard-nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local nvim_web_devicons = require("nvim-web-devicons")
      nvim_web_devicons.set_icon({
        cu = {
          icon = "",
          color = "#447028",
          cterm_color = "22",
          name = "Cuda",
        },
        ["F90"] = {
          icon = "󱈚",
          color = "#734f96",
          cterm_color = "97",
          name = "Fortran",
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        buffer_selected = {
          italic = false,
        },
        tab_selected = { italic = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        h = { "clang_format" },
        cpp = { "clang_format" },
        hpp = { "clang_format" },
        cuda = { "clang_format" },
        cuh = { "clang_format" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = { "cpp", "c", "lua", "markdown", "python" },
      },
    },
  },
}
