return {
  { import = "lazyvim.plugins.extras.lang.python" },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.ty = opts.servers.ty or {}
      opts.servers.ty.enabled = true

      opts.servers.pyright = opts.servers.pyright or {}
      opts.servers.pyright.enabled = false

      opts.servers.basepyright = opts.servers.basepyright or {}
      opts.servers.basepyright.enabled = false

      opts.servers.ruff = opts.servers.ruff or {}
      opts.servers.ruff.enabled = true

      opts.setup = opts.setup or {}
      opts.setup.ruff = function()
        require("snacks").util.lsp.on({ name = "ruff" }, function(_, client)
          client.server_capabilities.hoverProvider = false
        end)
      end
    end,
  },
}
