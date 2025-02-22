local dap = require("dap")
local dapui = require("dapui")
local opt = {
	noremap = true,
	silent = true,
}
-- 本地变量
local map = vim.api.nvim_set_keymap

require("nvim-dap-virtual-text").setup({
    enabled = true,
    enable_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = '<module',
    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
})

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, })

local dap_breakpoint = {
    error = {
        text = "🛑",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
    },
    condition = {
        text = '󰟃',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint',
    },
    rejected = {
        text = "󰃤",
        texthl = "DapBreakpint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
    },
    logpoint = {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint',
    },
    stopped = {
        text = '󰜴',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped',
    },
}

vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)


dapui.setup({
  element_mappings = {
    scopes = {
      edit = "e",
      repl = "r",
    },
    watches = {
      edit = "e",
      repl = "r",
    },
    stacks = {
      open = "g",
    },
    breakpoints = {
      open = "g",
      toggle = "b",
    },
  },

  layouts = {
    {
      elements = {
        "scopes",
        "stacks",
        "breakpoints",
        "watches",
      },
      size = 0.2, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    {
      elements = {
        "console",
      },
      size = 0.2,
      position = "right",
    },
  },

  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
require("plugins.dap.py")
require("plugins.dap.c")
require("plugins.dap.cpp")

map(
		"n",
		"<S-F5>",
		":lua require'dap'.terminate()<CR>"
			-- ":lua require'dap'.disconnect()<CR>"
			.. ":lua require'dap'.close()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. ":lua require('dap').clear_breakpoints()<CR>"
			.. "<C-w>o<CR>",
		opt
	)
-- 开始/继续
map("n", "<C-F5>", ":lua require'dap'.continue()<CR>", opt)
-- 设置断点
map("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", opt)
map("n", "<S-F6>", ":lua require'dap'.clear_breakpoints()<CR>", opt)
--  stepOver, stepOut, stepInto
map("n", "<F12>", ":lua require'dap'.step_over()<CR>", opt)
map("n", "<S-F7>", ":lua require'dap'.step_out()<CR>", opt)
map("n", "<F7>", ":lua require'dap'.step_into()<CR>", opt)
-- 弹窗
map("n", "<S-F12>", ":lua require'dapui'.eval()<CR>", opt)
-- 重启
map("n", "<F10>", ":lua require'dap'.restart()<CR>", opt)
map("n", "<S-F10>", ":lua require'dap'.terminate()<CR>", opt)
