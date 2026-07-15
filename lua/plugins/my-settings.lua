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
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal: float" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal: horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal: vertical" },
      { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "Terminal 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "Terminal 2" },
      { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "Terminal 3" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local function set_terminal_keymaps()
        local o = { buffer = 0 }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], o)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], o)
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], o)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], o)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], o)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], o)
        vim.keymap.set("t", "<C-u>", [[<C-\><C-n><C-u>]], o)
        vim.keymap.set("t", "<C-d>", [[<C-\><C-n><C-d>]], o)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = set_terminal_keymaps,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        hidden = true,
        float_opts = { border = "curved" },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      function _G._LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<leader>gg", "<cmd>lua _G._LAZYGIT_TOGGLE()<CR>", {
        noremap = true,
        silent = true,
        desc = "Toggle lazygit",
      })
    end,
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      autochdir = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    },
  },
}
