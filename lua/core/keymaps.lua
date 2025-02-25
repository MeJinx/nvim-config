vim.g.mapleader = " "

local keymap = vim.keymap

local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>") 
keymap.set("n", "qq", ":q<CR>")
keymap.set("n", "qw", ":wq<CR>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v", {desc = '水平新增窗口'}) -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s", {desc = '垂直新增窗口'}) -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = '取消搜索高亮'})

-- 切换buffer
keymap.set("n", "<C-N>", ":bnext<CR>")
keymap.set("n", "<C-P>", ":bprevious<CR>")

-- visual模式下缩进代码
keymap.set("v", "H", "<gv", opts)
keymap.set("v", "L", ">gv", opts)

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",{desc = '侧边文件栏'})

-- nvim-lazygit
keymap.set("n","<leader>lg", "<cmd>LazyGit<cr>", {desc = 'lazygit'})

-- LSP 相关快捷键
keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '跳转到声明' }))
keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '跳转到定义' }))
keymap.set('n', 'gh', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = '显示悬浮信息' }))
keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = '查看引用' }))
keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = '跳转到实现' }))
keymap.set('n', '<leader>r', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '重命名符号' }))
keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = '执行代码操作' }))
keymap.set("n", "<leader>=", function()
    vim.lsp.buf.format({ async = true })
end, vim.tbl_extend('force', opts, { desc = '格式化代码' }))

-- 诊断相关快捷键
keymap.set('n', '<leader>fl', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = '打开诊断浮动窗口' }))
keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = '跳转到上一个诊断' }))
keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = '跳转到下一个诊断' }))
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = '设置诊断位置列表' }))


keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

-- telescope 
local builtin = require('telescope.builtin')

--- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
keymap.set('n', '<leader>ff', builtin.find_files, { desc = '查找文件' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '实时搜索' })  -- 环境里要安装ripgrep
keymap.set('n', '<leader>fb', builtin.buffers, { desc = '切换缓冲区' })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '查找帮助文档' })

-- 放缩
keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
keymap.set('n', '<leader>re',":MundoToggle<CR>")
