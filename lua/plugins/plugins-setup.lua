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


local plugins = {
    {
        'nvimdev/dashboard-nvim', --nvim的启动页
        'jasonccox/vim-wayland-clipboard',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    { "catppuccin/nvim",      name = "catppuccin",                                                priority = 1000 },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
    },
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>y",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                '<c-up>',
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = 'lp',
                open_file_in_horizontal_split = '<c-h>',
            },
        },
    },

    -----------------------------------

    ---debug the code.
    "mfussenegger/nvim-dap",
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    -- 安装 nvim-dap-telescope 插件 (集成调试与 telescope)
    {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap' }
    },
    -- Python 调试插件（可选，针对 Python 用户）
    "mfussenegger/nvim-dap-python",
    -- virtual-text
    "theHamsta/nvim-dap-virtual-text",

    -----------------------------------

    "nvim-tree/nvim-web-devicons", -- 文件树图标
    "github/copilot.vim",          --github copilot
    "nvim-lualine/lualine.nvim",   -- 状态栏
    "nvim-tree/nvim-tree.lua",     -- 文档树
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

    "nvim-treesitter/nvim-treesitter", -- 语法高亮
    "neovim/pynvim",                   --py的接口依赖
    "simnalamburt/vim-mundo",          --先前修改的列表
    "pocco81/auto-save.nvim",
    "nvimtools/none-ls.nvim",          --格式化代码
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
        "neovim/nvim-lspconfig"
    },

    -- 自动补全
    {"hrsh7th/nvim-cmp"},
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip", -- snippets引擎，不装这个自动补全会出问题
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-path",                -- 文件路径

    "numToStr/Comment.nvim",           -- gcc和gc注释
    "windwp/nvim-autopairs",           -- 自动补全括号
    "HiPhish/rainbow-delimiters.nvim", --彩色括号

    "akinsho/bufferline.nvim",         -- buffer分割线
    "lewis6991/gitsigns.nvim",         -- 左则git提示
    "onsails/lspkind.nvim",            --vscode式的自动补全框
    "christoomey/vim-tmux-navigator",  -- use "ctrl-hjkl" to switch between planes.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    }

}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
