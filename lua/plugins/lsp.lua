require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
-- -- 支持的语言LSP在这里配置
-- local server =  {
--   "sumneko_lua", -- lua
--   "pyright", -- python
--   "tsserver",  -- JS TS
--   "gopls", -- go
--   "html", 
-- }
-- require("mason-lspconfig").setup {
--   ensure_installed = server,
-- }
--  
-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local lspConfig = require("lspconfig")
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--
-- for _, lsp in ipairs(server) do
--   lspConfig[lsp].setup {
--     capabilities = capabilities
--   }
-- end

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
}

