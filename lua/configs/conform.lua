local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 2000, 
    lsp_fallback = false,
  },
}
return options
