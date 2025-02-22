local dap = require("dap")

dap.configurations.cpp = {
  -- 启动调试 C++ 程序
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing", -- 启用 GDB 的漂亮打印功能
        description = "Enable pretty printing for gdb",
        ignoreFailures = true
      },
    },
    args = {},
  },

  -- 选择并附加到正在运行的 C++ 进程
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },

  -- 附加到 gdbserver，调试远程 C++ 程序
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },
}
