-- init.lua 或 LSP 配置文件
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local servers = {
    "lua_ls",
    "rust_analyzer",
    "bashls",
    "clangd",
    "markdown_oxide",
    "pylsp",
    "pyright",
    "cssls",
    "html",
    "biome",
}

require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = servers,
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local my_on_attach = function(client, bufnr)
    -- 启用通过 <c-x><c-o> 触发的自动补全
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- 配置每个 LSP 服务器
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = my_on_attach,
        capabilities = capabilities,
    }
end

