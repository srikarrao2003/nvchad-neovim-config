require("nvchad.mappings")

local map = vim.keymap.set

-- General
map("n", ";", ":", { nowait = true, desc = "Command mode" })
map("n", "<Leader><Leader>", ":nohlsearch<CR>", { desc = "Clear search highlighting" })
map("n", "C-f", ":Format<CR>", { desc = "Format file" })
map("n", "<Leader>s", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch between header and source file" })

-- Telescope
map("n", "<C-p>", "<cmd>Telescope git_files<CR>", { desc = "Find files in version control" })
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map(
	"n",
	"<Leader>pfa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Find all files" }
)
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep files" })
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help page" })
map("n", "<Leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find oldfiles" })
map("n", "<Leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Show keymaps" })

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>d<space>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })


-- File tree
map("n", "<Leader>e", "<cmd>NvimTreeToggle<Cr>", { desc = "Toggle file tree" })
map("n", "<Leader>o", "<cmd> NvimTreeFocus <CR>", { desc = "Nvim tree focus" })
-- LSP config
map(
	"n",
	"gl",
	"<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', border = 'single' })<CR>",
	{ desc = "Lsp show diagnostic" }
)
map("n", "<Leader>X", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic" })
map("n", "<Leader>x", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic" })
map("n", "<Leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })
map("n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Lsp code action" })


-- Buffer delete
map("n", "<Leader>q", "<cmd>qa<CR>", { desc = "Close All" })
map("n", "<Leader>Q", "<cmd>BufDel!<CR>", { desc = "Close buffer ignore changes" })

-- Buffer line
map("n", "<TAB>", "<C-i>") -- Keep <C-i> for jump forward
map("n", "<Leader>bs", function()
	require("nvchad.tabufline").next()
end, { desc = "Go to next buffer" })

-- Plenary
map("n", "<Leader>p", "<Plug>PlenaryTestFile", { desc = "Run plenary test on file" })

-- Start and end movements
map("n", "H", "^", { desc = "Moves to first word" })
map("n", "L", "$", { desc = "Moves to last word" })

-- paragraph movements
map("n", "m", "}", { desc = "Moves to next paragraph" })
map("n", "M", "{", { desc = "Moves to prev paragraph" })
