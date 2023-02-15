local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- 将官网复制的 plugins.lua 修改为本地的 plugins-setup.lua
-- 将PakcerCompile 修改为 PakcerSync
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- 插件安装在此处
	use("folke/tokyonight.nvim") -- 主题插件
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- 状态栏图标
	}) -- 状态栏插件
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- 文档树图标
		},
		tag = "nightly",
	}) -- 文档树插件
	use("nvim-treesitter/nvim-treesitter") -- 语法高亮
	use("mrjones2014/nvim-ts-rainbow") -- 括号匹配色彩
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}) -- 插件包管理工具

	-- 代码补全插件配置
	-- nvim-cmp
	use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
	use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
	use("hrsh7th/cmp-path") -- { name = 'path' }
	use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
	use("hrsh7th/nvim-cmp")
	use("lukas-reineke/cmp-under-comparator")
	-- vsnip
	use("hrsh7th/cmp-vsnip") -- { name = 'vsnip' }
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	-- lspkind
	use("onsails/lspkind-nvim")

	use("numToStr/Comment.nvim") -- 注释插件
	use("windwp/nvim-autopairs") -- 括号补全

	use("akinsho/bufferline.nvim") -- 文件缓冲区

	use("mhartington/formatter.nvim") -- 代码格式化

	use({
		"nvim-telescope/telescope.nvim",
		-- module = "telescope",
		requires = { { "nvim-lua/plenary.nvim" } },
	}) -- 文件检索工具

	use("akinsho/toggleterm.nvim") -- 终端工具

	use("kylechui/nvim-surround") -- 添加环绕符号

	if packer_bootstrap then
		require("packer").sync()
	end
end)
