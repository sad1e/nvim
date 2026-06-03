return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
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
        cu = { "clang_format" },
        cuh = { "clang_format" },
      },
    },
  },
}
