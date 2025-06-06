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

      -- Godot LSP configuration
      lspconfig['gdscript'].setup({
        capabilities = capabilities,
        cmd = function()
          -- Try different methods to connect to Godot LSP
          local godot_lsp_cmd = vim.fn.executable('nc') == 1 and { 'nc', 'localhost', '6005' }
            or vim.fn.executable('netcat') == 1 and { 'netcat', 'localhost', '6005' }
            or vim.fn.executable('ncat') == 1 and { 'ncat', 'localhost', '6005' }
            or nil
          
          if not godot_lsp_cmd then
            vim.notify("No netcat variant found. Please install netcat for Godot LSP support.", vim.log.levels.WARN)
            return nil
          end
          
          return godot_lsp_cmd
        end,
        filetypes = { 'gd', 'gdscript', 'gdscript3' },
        root_dir = lspconfig.util.root_pattern('project.godot', '.godot', '.git'),
        single_file_support = false,
        on_attach = function(client, bufnr)
          vim.notify("Godot LSP connected to " .. vim.fn.expand('%:t'), vim.log.levels.INFO)
          
          -- LSP keybindings for Godot
          local opts = { buffer = bufnr }
          
          -- Navigation
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          
          -- Add a keymap to jump back from definition
          vim.keymap.set('n', '<leader>gb', '<C-o>', { buffer = bufnr, desc = 'Jump back from definition' })
          
          -- Code actions
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>cf', function()
            vim.lsp.buf.code_action({
              context = {
                only = { 'quickfix', 'refactor', 'source.fixAll' },
                diagnostics = {},
              },
            })
          end, opts)
        end,
        settings = {},
      })

      -- Add Godot-specific keymaps when in GDScript files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gd", "gdscript", "gdscript3" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          -- Godot-specific keymaps
          vim.keymap.set('n', '<F5>', function()
            vim.cmd('!godot --path ' .. vim.fn.getcwd() .. ' --remote-debug tcp://127.0.0.1:6007 &')
          end, { buffer = buf, desc = 'Run Godot project with remote debug' })
          
          vim.keymap.set('n', '<leader>gr', function()
            vim.lsp.buf.execute_command({
              command = 'godot.run_scene',
              arguments = { vim.fn.expand('%:p') }
            })
          end, { buffer = buf, desc = 'Run current scene in Godot' })
        end,
      })

      -- General LSP keybindings for all filetypes
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          
          -- General LSP keybindings
          local opts = { buffer = bufnr }
          
          -- Navigation
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          
          -- Add a keymap to jump back from definition
          vim.keymap.set('n', '<leader>gb', '<C-o>', { buffer = bufnr, desc = 'Jump back from definition' })
          
          -- Code actions
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>cf', function()
            vim.lsp.buf.code_action({
              context = {
                only = { 'quickfix', 'refactor', 'source.fixAll' },
                diagnostics = {},
              },
            })
          end, opts)
          
          -- Rename
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          
          -- Signature help
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        end,
      })
    end,
  }
}
