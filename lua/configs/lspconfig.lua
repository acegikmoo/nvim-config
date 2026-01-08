require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- Suppress deprecation warning
vim.deprecate = function() end

-- C++ LSP with clangd
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = lspconfig.util.root_pattern(
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git'
  ),
}

-- TypeScript/JavaScript LSP 
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Force hide virtual text after TS LSP attaches
    vim.diagnostic.config({ virtual_text = false })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { 
    "typescript", 
    "javascript", 
    "javascriptreact", 
    "typescriptreact" 
  },
  root_dir = lspconfig.util.root_pattern(
    "package.json", 
    "tsconfig.json", 
    "jsconfig.json", 
    ".git"
  ),
}
