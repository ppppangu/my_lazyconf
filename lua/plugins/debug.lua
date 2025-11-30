-- 调试器 (DAP) 配置
return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "切换断点" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("断点条件: ")) end, desc = "条件断点" },
      { "<leader>dc", function() require("dap").continue() end, desc = "继续/开始调试" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "运行到光标" },
      { "<leader>di", function() require("dap").step_into() end, desc = "步进" },
      { "<leader>do", function() require("dap").step_over() end, desc = "单步跳过" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "步出" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "终止调试" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "切换调试 UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "计算表达式", mode = { "n", "v" } },
      { "<leader>dE", function() require("dapui").eval(vim.fn.input("表达式: ")) end, desc = "计算输入表达式" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "运行上次配置" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "切换 REPL" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.30 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.30 },
              { id = "watches", size = 0.20 },
            },
            size = 50,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = " ", play = " ", step_into = " ", step_over = " ",
            step_out = " ", step_back = " ", run_last = " ", terminate = " ",
          },
        },
        floating = { max_height = 0.9, max_width = 0.5, border = "rounded" },
      })

      require("nvim-dap-virtual-text").setup({
        enabled = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
        virt_text_pos = "eol",
      })

      require("dap-python").setup("python")

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
      })

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "DiagnosticHint", linehl = "Visual" })
    end,
  },
}
