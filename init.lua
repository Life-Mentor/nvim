----自定义---------------------------------------------------------------------------------------------------------------------------------------
vim.o.incsearch = true
vim.opt.clipboard = "unnamedplus"
vim.g.indentLine_fileTypeExclude = { "dashboard", "markdown", "veil", "txt", "pdf" }
vim.wo.colorcolumn = "146"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.wo.relativenumber = true
vim.o.scrolloff = 15
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
vim.o.hlsearch = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.g.navic_silence = true
if vim.g.neovide then
	vim.o.guifont = "Iosevka Nerd Font:h10"
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_cursor_vfx_mode = "ripple"
	vim.neovide_confirm_quit = true
end
--包管理器---------------------------------------------------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- { "Bekaboo/dropbar.nvim" , },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"xiyaowong/transparent.nvim",
	},
	---顶部文件标签----------------------------------------------------------------------------------------------------------------------------------
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require('lualine').setup()
		end,
	},
	---文件树----------------------------------------------------------------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = { width = 30 },
				renderer = { group_empty = true },
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			vim.cmd.colorscheme("gruvbox")
			-- transparent_mode = true
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			-- transparent_background = true,
			integrations = {
				telescope = true,
				harpoon = true,
				mason = true,
				neotest = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			-- vim.cmd.colorscheme 'catppuccin-mocha'
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {},
				rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
			})
		end,
	},
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981",
			})
		end,
	},
	---nvim 格式化-----------------------------------------------------------------------------------------------------------------------------------
	{
		"mhartington/formatter.nvim",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = "zz",
					block = "lz",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				extra = {
					above = "gcO",
					below = "gco",
					eol = "gcA",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "onsails/lspkind-nvim" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-path" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")
			vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				show_trailing_blankline_indent = false,
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod" },
		},
	},
	{
		"kristijanhusak/vim-dadbod-completion",
	},
	{
		"rcarriga/nvim-notify",
		config = function(_, opts)
			require("notify")("主其实很在乎，你今天写代码了没有？")
			-- require("notify")("主其实很在乎，你今天玩原神了没有？")
			vim.notify = require("notify")
			require("notify").setup(vim.tbl_extend("keep", {
				background_colour = "#000000",
			}, opts))
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
			{
				"folke/neodev.nvim",
				opts = {},
			},
		},
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function() end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
	},
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-navic").setup()
			on_attach = on_attach
		end,
	},
	{
		"SmiteshP/nvim-navbuddy",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim", -- Optional
			"nvim-telescope/telescope.nvim", -- Optional
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	{
		"preservim/tagbar",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
})
---按键映射--------------------------------------------------------------------------------------------------------------------------------------
--映射jk作为Esc
vim.api.nvim_set_keymap("i", "jk", "<esc>", { silent = true, noremap = true })

-- lspsaga
--[[ vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "ac", "<cmd>Lspsaga code_action<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "hd", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "lf", "<cmd>Lspsaga lsp_finder<CR>" , { noremap = true, silent = true }) ]]

-- 打开大纲
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>SymbolsOutline<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>TagbarToggle<CR>", { noremap = true, silent = true })
-- 打开文件树
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
-- 顶部文件左右移动 --
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bc", ":bdelete %<CR>", { noremap = true, silent = true })
-- 打开一个浮动终端 --
-- vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
-- 文件查找 --
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
-- nvim 代码调试
-- 开始调试
vim.keymap.set("n", "<leader>de", function()
	require("dap").continue()
end, { noremap = true, silent = true })
-- 打断点
vim.keymap.set("n", "<leader>dn", function()
	require("dap").toggle_breakpoint()
end, { noremap = true, silent = true })
-- 通过此步
vim.keymap.set("n", "<leader>dr", function()
	require("dap").step_over()
end, { noremap = true, silent = true })
-- 单独运行此代码
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { noremap = true, silent = true })
-- 输出？
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_out()
end, { noremap = true, silent = true })
-- 直接退出dap
vim.keymap.set("n", "<leader>dt", function()
	require("dap").disconnect()
end, { noremap = true, silent = true })
-- nvim 格式化代码
vim.keymap.set("n", "fr", "<cmd>Format<CR>")
vim.keymap.set("n", "fw", "<cmd>FormatWrite<CR>")

vim.keymap.set("n", "<C-o>", "<cmd>TransparentToggle<CR>")
---配置区----------------------------------------------------------------------------------------------------------------------------------------
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"bashls",
		-- "clangd",
		-- "html",
		"pyright",
		"vimls",
	},
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local lspkind = require("lspkind")
local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
cmp.setup({
	mapping = {
		-- 补全的一些设置，具体不清楚
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-l>"] = cmp.mapping.complete(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
	},
	--让nvim根据name里面的参数进行补全
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				ultisnips = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})
local cmp = require("cmp")
--------------------------------------------文件类型进行补全，作用未知 -----------------------------------------------------
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})
------------------------------------------------ nvim命令补全--------------------------------------------------------------
--nvim命令行补全
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

--文件内容搜索补全

cmp.setup.cmdline({ "/" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- ----------------------------- 这个小插件为neovim内置的lsp添加了类似vscode的象形图------------------------------
local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})
---打开lazygit-----------------------------------------------------------------------------------------------------------------------------------

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})
function _lazygit_toggle()
	lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

---nvim dap-ui-----------------------------------------------------------------------------------------------------------------------------------
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
---dap python -----------------------------------------------------------------------------------------------------------------------------------
local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
	{
		type = "python",
		request = "attach",
		name = "Attach remote",
		connect = function()
			local host = vim.fn.input("Host [127.0.0.1]: ")
			host = host ~= "" and host or "127.0.0.1"
			local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
			return { host = host, port = port }
		end,
	},
}
--- dpa cpp -------------------------------------------------------------------------------------------------------------------------------------
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/home/duck/.local/share/nvim/mason/bin/OpenDebugAD7",
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		MIDebuggerServerAddress = "localhost:1234",
		MIDebuggerPath = "/home/duck/.local/share/nvim/mason/bin/OpenDebugAD7",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}
dap.configurations.c = dap.configurations.cpp

-- nvim 格式化
local util = require("formatter.util")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
