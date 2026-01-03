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
    config = function()
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
            -- Force hide virtual text after LSP attaches
            vim.diagnostic.config({ virtual_text = false })
          end,
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
      require("crates").setup()
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
        dotfiles = false,
        git_ignored = false,
        custom = { "^.git$" },
      }
      
      conf.git = {
        enable = true,
        ignore = false,
      }
      
      return conf
    end,
  },
}
