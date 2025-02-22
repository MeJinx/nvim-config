local db = require("dashboard")
db.setup({
    theme = 'hyper',
    config = {
        header = {
            '          ▀████▀▄▄              ▄█ ',
            '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
            '    ▄        █          ▀▀▀▀▄  ▄▀  ',
            '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
            '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
            '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
            '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
            '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
            '   █   █  █      ▄▄           ▄▀   ', }, --your header
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Yazi',
                key = 'y',
            },
            {
                icon = '󰌋 ',
                icon_hl = '@variable',
                desc = 'Word',
                group = 'Label',
                action = 'Telescope ',
                key = 'w',

            }
        },
        packages = { enable = true },
        project = { enable = true },
        mru = { enable = true, limit = 5, icon = '󰈙', label = 'Recent Files', cwd_only = false },

        footer = {
            '',
            '',
            '忘掉根本，生有何欢',
        }, --your footer
    }
})
