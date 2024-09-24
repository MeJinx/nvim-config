require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  automatic_installation = true,
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "bashls",
    "clangd",
    "cmake",
    "markdown_oxide",
    "pylsp",
    "pyright"
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}
