return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
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

            -- Disable semantic tokens for cleaner syntax highlighting
            client.server_capabilities.semanticTokensProvider = nil

            -- Format on save (conditional)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                if vim.g.format_on_save then
                  vim.lsp.buf.format { bufnr = bufnr }
                end
              end,
            })

            -- Hide virtual text
            vim.diagnostic.config { virtual_text = false }
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              checkOnSave = true,
              check = {
                command = "clippy",
              },
              imports = {
                group = {
                  enable = false,
                },
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
            },
          },
        },
        dap = {},
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
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
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup()
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },
  {
    "octol/vim-cpp-enhanced-highlight",
    ft = { "cpp", "c" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"

      conf.defaults.file_ignore_patterns = {
        "^%.git/",
        "%.git/",
        "node_modules/",
        "%.next/",
        "dist/",
        "build/",
        "target/",
        "%.cargo/",
        "package%-lock%.json",
        "yarn%.lock",
        "pnpm%-lock%.yaml",
      }

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

      conf.filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { "^.git$" },
      }

      conf.git = {
        enable = true,
        ignore = false,
      }

      conf.renderer = conf.renderer or {}
      conf.renderer.icons = conf.renderer.icons or {}
      conf.renderer.icons.show = conf.renderer.icons.show or {}
      conf.renderer.icons.show.git = false

      return conf
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- Prisma support
  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "cpp",
        "rust",
        "prisma",
      },
      -- CRITICAL: Enable Tree-sitter indentation
      indent = {
        enable = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
