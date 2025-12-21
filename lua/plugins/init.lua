return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 0
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
      -- Configure rustaceanvim before it loads
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr)
            -- Disable inlay hints by default
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end
            -- Format on save with LSP
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              -- Disable the deprecated cmp completion
              completion = {
                cmp = {
                  enable = false  -- Try 'enable' instead of 'enabled'
                }
              },
              checkOnSave = true,
              check = {
                command = "clippy",
              },
              diagnostics = {
                enable = true,
                disabled = {},
                enableExperimental = true,
              },
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "always", useParameterNames = true },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "always" },
                renderColons = true,
                typeHints = { enable = true, hideNamedConstructor = false },
              },
            },
          },
        },
        dap = {},
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui', 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup()  -- Remove the completion config
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },
  {
    "octol/vim-cpp-enhanced-highlight",
    ft = { "cpp", "c" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"
      
      -- Show hidden and gitignored files, but hide .git folder
      conf.defaults.file_ignore_patterns = { "^%.git/", "%.git/" }
      conf.pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      }
      
      return conf
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      
      -- Show hidden and gitignored files, but hide .git
      conf.filters = {
        dotfiles = false,  -- Show dotfiles like .env
        git_ignored = false,  -- Show gitignored files
        custom = { "^.git$" },  -- Only hide .git folder
      }
      
      conf.git = {
        enable = true,
        ignore = false,  -- Don't ignore gitignored files
      }
      
      return conf
    end,
  },
}
