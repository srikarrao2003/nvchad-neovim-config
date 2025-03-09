local overrides = require("configs.overrides")

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
			},
		},
		config = function()
			require("nvchad.configs.lspconfig").defaults() -- nvchad defaults for lua
			require("configs.lsp")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = overrides.telescope,
	},

	-- add telescope-fzf-native
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			lazy = false,
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.cmp,
	},

	-- Additional plugins

	-- escape using key combo (currently set to jk)
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		lazy = false,
	},

	{
		"mfussenegger/nvim-dap",
		config = function()
			require("configs.dap")
		end,
		lazy = false,
	},

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		dependencies = { "mfussenegger/nvim-dap", "nvim-dap-ui" },
	},

	-- better bdelete, close buffers without closing windows
	{
		"ojroques/nvim-bufdel",
		lazy = false,
	},

	{
		"nvim-lua/plenary.nvim",
	},
	{
		"vimwiki/vimwiki",
	},

	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup(require("configs.copilot"))
		end,
	},

	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		version = "*",
		config = function()
		  require("toggleterm").setup({
			size = function(term)
			  if term.direction == "horizontal" then
				return 15
			  elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			  else
				return 20
			  end
			end,
			open_mapping = [[<c-\>]], -- Default mapping, we'll create our custom 't' command separately
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
			  border = "curved",
			  winblend = 0,
			  highlights = {
				border = "Normal",
				background = "Normal",
			  },
			  width = function()
				return math.floor(vim.o.columns * 0.8)
			  end,
			  height = function()
				return math.floor(vim.o.lines * 0.8)
			  end,
			},
		  })
	  
		  -- Create custom mapping for 't' to toggle floating terminal
		  vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>ToggleTerm direction=float<CR>", {noremap = true, silent = true})
		  
		  -- Add Terminal Escape Mapping (Escape terminal mode with Esc)
		  function _G.set_terminal_keymaps()
			local opts = {buffer = 0}
			vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
			vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
			vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
		  end
	  
		  -- Auto-command to set terminal keymaps when terminal is opened
		  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
		  
		  -- Add function to send commands to terminal if needed
		  local Terminal = require("toggleterm.terminal").Terminal
		  
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
		  bigfile = { enabled = true },
		  dashboard = { enabled = true },
		  explorer = { enabled = false },
		  indent = { enabled = true },
		  input = { enabled = true },
		  notifier = {
			enabled = true,
			timeout = 3000,
		  },
		  picker = { enabled = false },
		  quickfile = { enabled = true },
		  scope = { enabled = true },
		  scroll = { enabled = false },
		  statuscolumn = { enabled = true },
		  words = { enabled = true },
		  styles = {
			notification = {
			  -- wo = { wrap = true } -- Wrap notifications
			}
		  }
		},
		keys = {
		  -- Top Pickers & Explorer
		  { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		  { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		  { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		  { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		--   { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
		  -- find
		--   { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		--   { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		--   { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		--   { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		  -- git
		  { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		  { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
		  -- Grep
		  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		  { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		  { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
		  { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		  -- search
		  { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		  { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
		  { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		  { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
		  { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		  { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		  { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		  { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		  { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		  { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		  { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		  { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		  { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		  { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
		  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		  { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		  { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		  { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		  -- LSP
		  { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		  { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		  { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		  { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		  { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		  { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		  { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		  -- Other
		  { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		  { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		  { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		  { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		  { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		  { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		  { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		  { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
		  { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		  { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		  { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
		  { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
		  { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		  { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
		  {
			"<leader>N",
			desc = "Neovim News",
			function()
			  Snacks.win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = {
				  spell = false,
				  wrap = false,
				  signcolumn = "yes",
				  statuscolumn = " ",
				  conceallevel = 3,
				},
			  })
			end,
		  }
		},
		init = function()
		  vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
			  -- Setup some globals for debugging (lazy-loaded)
			  _G.dd = function(...)
				Snacks.debug.inspect(...)
			  end
			  _G.bt = function()
				Snacks.debug.backtrace()
			  end
			  vim.print = _G.dd -- Override print to use snacks for `:=` command
	  
			  -- Create some toggle mappings
			  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
			  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
			  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
			  Snacks.toggle.diagnostics():map("<leader>ud")
			  Snacks.toggle.line_number():map("<leader>ul")
			  Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
			  Snacks.toggle.treesitter():map("<leader>uT")
			  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
			  Snacks.toggle.inlay_hints():map("<leader>uh")
			  Snacks.toggle.indent():map("<leader>ug")
			  Snacks.toggle.dim():map("<leader>uD")
			end,
		  })
		end,
	},

	{
		"Pocco81/auto-save.nvim",
		config = function()
		  require("auto-save").setup {
			enabled = true,
			execution_message = {
			  message = function()
				return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
			  end,
			  dim = 0.18,
			  cleaning_interval = 1250,
			},
			trigger_events = {"InsertLeave", "TextChanged"},
			condition = function(buf)
			  local fn = vim.fn
			  local utils = require("auto-save.utils.data")
			  
			  if fn.getbufvar(buf, "&modifiable") == 1 and
				 utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
				return true
			  end
			  return false
			end,
			write_all_buffers = false,
			debounce_delay = 135,
			callbacks = {
			  enabling = nil,
			  disabling = nil,
			  before_asserting_save = nil,
			  before_saving = nil,
			  after_saving = nil
			}
		  }
		end,
	},
	
}
