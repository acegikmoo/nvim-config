require "nvchad.options"
-- add yours here!
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Force enable diagnostics and virtual text
vim.diagnostic.enable()
vim.opt.relativenumber = true
vim.g.gui_font_ligatures = 0
vim.opt.updatetime = 100
vim.opt.showtabline = 0

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "■",  -- or use "●", "▎", "█", ""
    -- Format function to add colors and styling
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format(" %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format(" %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format(" %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format(" %s", diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s: %s", diagnostic.source, diagnostic.message)
    end,
  },
})

-- Define custom diagnostic colors for Gruvbox
vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#fb4934 guibg=#3c3836 gui=italic
  highlight DiagnosticVirtualTextWarn guifg=#fabd2f guibg=#3c3836 gui=italic
  highlight DiagnosticVirtualTextInfo guifg=#83a598 guibg=#3c3836 gui=italic
  highlight DiagnosticVirtualTextHint guifg=#8ec07c guibg=#3c3836 gui=italic
  
  highlight DiagnosticError guifg=#fb4934
  highlight DiagnosticWarn guifg=#fabd2f
  highlight DiagnosticInfo guifg=#83a598
  highlight DiagnosticHint guifg=#8ec07c
  
  highlight DiagnosticUnderlineError gui=underline guisp=#fb4934
  highlight DiagnosticUnderlineWarn gui=underline guisp=#fabd2f
  highlight DiagnosticUnderlineInfo gui=underline guisp=#83a598
  highlight DiagnosticUnderlineHint gui=underline guisp=#8ec07c
]])

-- Competitive Programming: Append template to new C++ files
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    vim.cmd("0r /home/acegikmo/vimcp/Library/Template.cpp")
  end,
})

-- C++ specific settings (keep your preferences)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
  end,
})
