return {
  -- {
  --   "maxmx03/solarized.nvim",
  --   branch = "main",
  --   lazy = false,
  --   name = "solarized",
  --   main = "solarized",
  --   priority = 1000,
  --   -- Display colors in a new buffer with command: `:Solarized colors`
  --   -- See: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
  --   opts = {
  --     palette = "selenized",
  --     variant = "default",
  --     styles = {
  --       keywords = { bold = false },
  --     },
  --   },
  --   config = function(plugin, opts)
  --     vim.o.background = "light"
  --     require(plugin.main).setup(opts)
  --     vim.cmd.colorscheme = "solarized"
  --   end,
  -- },

  {
    "phha/zenburn.nvim",
    lazy = false, -- Load immediately on startup
  },

  {
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

  -- configure LazyVim to load solarized
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
