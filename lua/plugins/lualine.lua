return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function get_solarized_theme()
        local colors = require("solarized.utils").get_colors()
        local foreground = colors.base2

        if vim.o.background == "light" then
          foreground = colors.base02
        end

        local custom_theme = {
          normal = {
            a = { fg = colors.base04, bg = colors.blue },
            b = { fg = foreground, bg = colors.base1 },
            c = { fg = colors.base2, bg = colors.base04 },
          },
          insert = {
            a = { fg = colors.base04, bg = colors.green },
          },
          visual = {
            a = { fg = colors.base04, bg = colors.magenta },
          },
          replace = {
            a = { fg = colors.base04, bg = colors.red },
          },
          command = {
            a = { fg = colors.base03, bg = colors.red },
          },
          inactive = {
            a = { fg = foreground, bg = colors.base04 },
            b = { fg = colors.base2, bg = colors.base04 },
            c = { fg = colors.base04, bg = colors.base04 },
          },
        }

        return custom_theme,
          {
            branch = colors.magenta,
            added = colors.green,
            modified = colors.orange,
            removed = colors.red,
          }
      end

      local function get_zenburn_theme()
        local colors = require("zenburn.palette")
        local custom_zenburn_theme = {
          normal = {
            a = { fg = colors.SignColumn.fg, bg = colors.SpecialComment.fg, gui = "bold" },
            b = { fg = colors.Normal.fg, bg = colors.LineNr.bg },
            c = { fg = colors.Normal.fg, bg = colors.CursorLine.bg },
          },
          insert = {
            a = { fg = colors.SignColumn.fg, bg = colors.Function.fg, gui = "bold" },
          },
          visual = {
            a = { fg = colors.SignColumn.fg, bg = colors.Define.fg, gui = "bold" },
          },
          replace = {
            a = { fg = colors.SignColumn.fg, bg = colors.Number.fg, gui = "bold" },
          },
          command = {
            a = { fg = colors.SignColumn.fg, bg = colors.Boolean.fg, gui = "bold" },
          },
          inactive = {
            a = { fg = colors.LineNr.fg, bg = colors.CursorLine.bg },
            b = { fg = colors.LineNr.fg, bg = colors.CursorLine.bg },
            c = { fg = colors.CursorLine.bg, bg = colors.CursorLine.bg },
          },
        }

        return custom_zenburn_theme,
          {
            branch = colors.Define.fg,
            added = colors.DiffAdd.fg,
            modified = colors.Function.fg,
            removed = colors.String.fg,
          }
      end

      local function get_tokyonight_theme()
        local colors_name = vim.g.colors_name or ""
        local style = colors_name:match("^tokyonight%-(.+)$")
        local colors = require("tokyonight.colors").setup({
          style = style,
        })
        local custom_tokyonight_theme = {
          normal = {
            a = { fg = colors.black, bg = colors.blue },
            b = { fg = colors.blue, bg = colors.fg_gutter },
            c = { fg = colors.fg_sidebar, bg = colors.bg_statusline },
          },
          insert = {
            a = { fg = colors.black, bg = colors.green },
          },
          visual = {
            a = { fg = colors.black, bg = colors.magenta },
          },
          replace = {
            a = { fg = colors.black, bg = colors.red },
          },
          command = {
            a = { fg = colors.black, bg = colors.yellow },
          },
          inactive = {
            a = { fg = colors.blue, bg = colors.bg_statusline },
            b = { fg = colors.fg_gutter, bg = colors.bg_statusline },
            c = { fg = colors.bg_statusline, bg = colors.bg_statusline },
          },
        }

        return custom_tokyonight_theme,
          {
            branch = colors.magenta,
            added = colors.green,
            modified = colors.yellow,
            removed = colors.red,
          }
      end

      local function get_vscode_modern_theme()
        local ok_palette, palette = pcall(require, "vscode_modern.palette")
        local ok_themes, themes = pcall(require, "vscode_modern.themes")
        local ok_vscode_modern, vscode_modern = pcall(require, "vscode_modern")

        if not ok_palette or not ok_themes then
          return get_solarized_theme()
        end

        local config = {}
        if ok_vscode_modern and type(vscode_modern.config) == "table" then
          config = vscode_modern.config
        end

        local theme_name = vim.o.background == "light" and "light" or "dark"
        local theme = themes[theme_name](palette, config)
        local status_line = theme.ui.status_line

        local custom_vscode_modern_theme = {
          normal = {
            a = { fg = status_line.mode.fg, bg = status_line.mode.bg, gui = "bold" },
            b = { fg = status_line.fg, bg = status_line.medium.bg },
            c = { fg = status_line.fg, bg = status_line.bg },
          },
          insert = {
            a = { fg = palette.light_17, bg = theme.git.signs.add, gui = "bold" },
          },
          visual = {
            a = { fg = palette.dark_01, bg = theme.sintax.keyword_control_flow, gui = "bold" },
          },
          replace = {
            a = { fg = palette.light_17, bg = theme.lsp.diagnostics.error, gui = "bold" },
          },
          command = {
            a = { fg = palette.dark_01, bg = theme.lsp.diagnostics.warn, gui = "bold" },
          },
          inactive = {
            a = { fg = status_line.fg, bg = status_line.bg },
            b = { fg = status_line.fg, bg = status_line.bg },
            c = { fg = status_line.bg, bg = status_line.bg },
          },
        }

        return custom_vscode_modern_theme,
          {
            branch = status_line.icon.branch.fg,
            added = theme.git.signs.add,
            modified = theme.git.status.modified,
            removed = theme.git.signs.delete,
          }
      end

      local function get_lualine_theme()
        if vim.g.colors_name == "vscode_modern" then
          return get_vscode_modern_theme()
        end

        if vim.g.colors_name == "zenburn" or vim.g.colors_name == "zenburn.nvim" then
          return get_zenburn_theme()
        end

        if vim.g.colors_name ~= nil and vim.g.colors_name:match("^tokyonight") then
          return get_tokyonight_theme()
        end

        return get_solarized_theme()
      end

      local function setup_lualine()
        local custom_theme, theme_colors = get_lualine_theme()

        local hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end

        local sections = {}

        local icons = {
          vim = "",
          git = "",
          diff = { added = "󰐕", modified = "󰧞", removed = "󰍴" },
          default = { left = "", right = " " },
          round = { left = "", right = "" },
          block = { left = "█", right = "█" },
          arrow = { left = "", right = "" },
        }

        local function ins_config(location, component)
          sections["lualine_" .. location] = component
        end

        ins_config("a", {
          {
            "mode",
            icon = icons.vim,
            separator = { left = icons.block.left, right = icons.default.right },
            right_padding = 2,
          },
        })

        ins_config("b", {
          {
            "filename",
            fmt = function(filename)
              local icon = "󰈚"

              local devicons_present, devicons = pcall(require, "nvim-web-devicons")

              if devicons_present then
                local ft_icon = devicons.get_icon(filename)
                icon = (ft_icon ~= nil and ft_icon) or icon
              end

              return string.format("%s %s", icon, filename)
            end,
          },
        })

        ins_config("c", {
          {
            "branch",
            icon = { icons.git, color = { fg = theme_colors.branch } },
            cond = hide_in_width,
          },
          {
            "diff",
            symbols = icons.diff,
            colored = true,
            diff_color = {
              added = { fg = theme_colors.added },
              modified = { fg = theme_colors.modified },
              removed = { fg = theme_colors.removed },
            },
            cond = hide_in_width,
          },
        })

        ins_config("x", {})

        ins_config("y", {
          {
            "progress",
            fmt = function(progress)
              local spinners = { "󰚀", "󰪞", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰚀" }

              if string.match(progress, "%a+") then
                return progress
              end

              local p = tonumber(string.match(progress, "%d+"))

              if p ~= nil then
                local index = math.floor(p / (100 / #spinners)) + 1
                return "  " .. spinners[index]
              end
            end,
            separator = { left = icons.default.left },
            cond = hide_in_width,
          },
          {
            "location",
            cond = hide_in_width,
          },
        })

        ins_config("z", {
          {
            function()
              local clients = vim.lsp.get_clients({
                bufnr = 0,
              })

              for _, client in ipairs(clients) do
                if client.name ~= "null-ls" then
                  return client.name
                end
              end

              return "No Active Lsp"
            end,
          },
        })

        require("lualine").setup({
          options = {
            theme = custom_theme,
            component_separators = "",
            section_separators = { left = icons.default.right, right = icons.default.left },
            disabled_filetypes = {
              "NvimTree",
              "starter",
            },
            refresh = {
              statusline = 1000,
            },
          },
          sections = sections,
          inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" },
          },
          tabline = {},
          extensions = {},
        })
      end

      setup_lualine()

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("CustomLualineTheme", { clear = true }),
        callback = setup_lualine,
      })
    end,
  },
}
