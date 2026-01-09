require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")
map("i", "kk", "<ESC>")
map("i", "KK", "<ESC>")
-- Quick open file in same directory
map("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <CR>', { desc = "Open file in current dir" })

-- Always center search results
map("n", "n", "nzz", { silent = true, desc = "Next search result (centered)" })
map("n", "N", "Nzz", { silent = true, desc = "Prev search result (centered)" })
map("n", "*", "*zz", { silent = true, desc = "Search word under cursor (centered)" })
map("n", "#", "#zz", { silent = true, desc = "Search word backward (centered)" })

-- Jump to start and end of line using home row
map("", "H", "^", { desc = "Jump to first non-blank character" })
map("", "L", "$", { desc = "Jump to end of line" })

-- Arrow keys switch buffers
map("n", "<left>", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<right>", ":bn<CR>", { desc = "Next buffer" })

-- Move by visual line when text is wrapped
  map("n", "j", "gj")
map("n", "k", "gk")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- NvimTree navigation
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
map("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in tree" })

-- Toggle inlay hints
map("n", "<Leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- C++ competitive programming with build script
map("n", "<leader>bb", "<cmd>w | !build.sh %:r<CR>", { desc = "Build" })
map("n", "<leader>br", function()
  vim.cmd("w")
  vim.cmd("!build.sh " .. vim.fn.expand("%:r"))
  vim.cmd("split | terminal ./" .. vim.fn.expand("%:r"))
  vim.cmd("startinsert")
end, { desc = "Build and run" })

-- Select all with Ctrl+a
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select all" })

-- Live rg
map("n", "<C-p>", "<cmd>Telescope live_grep<CR>", { desc = "Search project (terminal safe)" })

-- Faster diagnostic hover (shows immediately without delay)
map("n", "K", function()
  local winid = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local row, col = unpack(vim.api.nvim_win_get_cursor(winid))
  
  -- Show diagnostics if on an error/warning
  local diag = vim.diagnostic.get(bufnr, { lnum = row - 1 })
  if #diag > 0 then
    vim.diagnostic.open_float(nil, { focus = false })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Hover or show diagnostic" })
