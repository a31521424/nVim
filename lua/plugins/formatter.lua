local util = require("formatter.util")

require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			require("formatter.filetypes.lua").stylua,

			function()
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
		javascript = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = {
						util.escape_path(util.get_current_buffer_file_path()),
					},
				}
			end,
		},
		python = {
			function()
				return {
					exe = "autopep8",
					args = {
						"--in-place",
						"-–aggressive",
						"-–aggressive",
						util.escape_path(util.get_current_buffer_file_path()),
					},
				}
			end,
		},
	},
})

vim.cmd([[
 augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
