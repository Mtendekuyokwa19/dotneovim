return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    config = function(_, opts)
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require('lspconfig')

      -- Auto-discover installed servers
      local servers = require('mason-lspconfig').get_installed_servers()

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- Optional: If you want **custom configs** for specific servers, you could add them here
      if lspconfig['lua_ls'] then
        lspconfig['lua_ls'].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        })
      end
    end,
  }
}

