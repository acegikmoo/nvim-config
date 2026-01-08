require "nvchad.options"
-- add yours here!
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.relativenumber = true
vim.g.gui_font_ligatures = 0
vim.opt.updatetime = 100
vim.opt.showtabline = 0
vim.opt.scrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better diff algorithm
vim.opt.diffopt:append("iwhite")
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")

-- Hide diagnostics inline by default, show with keybinding
vim.diagnostic.config({
  virtual_text = false,  -- Hide inline
  signs = true,          -- Show signs in gutter
  underline = true,      -- Underline errors
  update_in_insert = false,
  severity_sort = true,
  float = {
      border = "rounded",
      source = "always",
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    },
})

-- Rust specific settings (standard Rust formatting)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- Auto-save when switching buffers/files
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent! write')
    end
  end,
})

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Jump to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      if not vim.fn.expand("%:p"):find(".git", 1, true) then
        vim.cmd('exe "normal! g\'\\\""')
      end
    end
  end,
})

-- Disable automatic comment continuation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Better command-line completion
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"

-- Competitive Programming: Append template to new C++ files
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    vim.cmd("0r /home/acegikmo/vimcp/Library/Template.cpp")
    vim.cmd("normal! 53G^i    ")
    vim.cmd("startinsert")
  end,
})

-- C++ specific settings
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
    vim.opt_local.indentexpr = "" 
  end,
})
