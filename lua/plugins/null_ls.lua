local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
    },
})
