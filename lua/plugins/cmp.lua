local lspkind = require("lspkind")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

-- 下面会用到这个函数
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end


cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(), -- 取消补全，esc也可以退出
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        -- cmp.lua
        cmp.setup({
            -- 省略其他代码
            formatting = {
                completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
                documentation = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    scrollbar = "║",
                },
                format = lspkind.cmp_format({
                    mode = "symbol",
                    maxwidth = 20,
                    ellipsis_char = "...",
                    before = function(entry, vim_item)
                        -- Get the full snippet (and only keep first line)
                        local word = entry:get_insert_text()
                        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                            word = vim.lsp.util.parse_snippet(word)
                        end
                        word = str.oneline(word)
                        if
                            entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
                            and string.sub(vim_item.abbr, -1, -1) == "~"
                        then
                            word = word .. "~"
                        end
                        vim_item.abbr = word
                        return vim_item
                    end,
                }),
            }
            -- 省略其他代码
        })
    }),

    -- 这里重要
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    })
})
