return {
  {
    -- "rjshkhr/shadow.nvim",
    -- priority = 1000,
    -- config = function()
    --   vim.opt.termguicolors = true
    --   vim.cmd.colorscheme("shadow")
    -- end,

    -- "liuchengxu/space-vim-dark",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme space-vim-dark")
    -- end,
    --
    "tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        styles = {
          keywords = { italic = false },
          comments = { italic = false },
        },
      }
    end,
  },
}
