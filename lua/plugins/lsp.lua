return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall', 'Mason' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      local map_lsp_keybinds = require('user.keymaps').map_lsp_keybinds -- Has to load keymaps before pluginslsp

      local default_handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
      }

      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(_client, buffer_number)
        map_lsp_keybinds(buffer_number)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        bashls = {},
        cssls = {},
        html = {},
        clangd = {},
        gopls = {
          gofumpt = true,
          codelenses = {
            generate = true,
          },
          analyses = {
            unusedparams = true,
            shadow = true,
          },
        },
        texlab = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        marksman = {},
        zls = {},
        jdtls = {},
        ocamllsp = {},
        nil_ls = {},
        pyright = {},
        sqlls = {},
        tailwindcss = {},
        yamlls = {},
      }

      local formatters = {
        prettierd = {},
        stylua = {},
      }

      local linters = {
        eslint_d = {},
      }

      local manually_installed_servers = { 'ocamllsp' }

      local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend('force', {}, servers, formatters, linters))

      local ensure_installed = vim.tbl_filter(function(name)
        return not vim.tbl_contains(manually_installed_servers, name)
      end, mason_tools_to_install)

      require('mason-tool-installer').setup {
        auto_update = true,
        run_on_start = true,
        ensure_installed = ensure_installed,
      }

      -- Iterate over our servers and set them up
      for name, config in pairs(servers) do
        require('lspconfig')[name].setup {
          capabilities = capabilities,
          filetypes = config.filetypes,
          handlers = vim.tbl_deep_extend('force', {}, default_handlers, config.handlers or {}),
          on_attach = on_attach,
          settings = config.settings,
        }
      end

      vim.g.zig_fmt_autosave = 0

      -- Setup mason so it can manage 3rd party LSP servers
      require('mason').setup {
        ui = {
          border = 'rounded',
        },
      }

      require('mason-lspconfig').setup()

      -- Configure borderd for LspInfo ui
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      -- Configure diagnostics border
      vim.diagnostic.config {
        float = {
          border = 'rounded',
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require 'conform'
      local formatters_by_ft = {
        javascript = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
        typescript = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        python = { 'black' },
        c = { 'clang-format' },
      }
      local opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
        formatters_by_ft = formatters_by_ft,
      }

      conform.setup(opts)

      vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
        conform.format(opts)
      end, { desc = 'Format code with Conform' })

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
  },
}
