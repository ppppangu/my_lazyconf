-- 终端管理 - VSCode 风格 + 分屏支持
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,

    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.3
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
      shell = vim.fn.has("win32") == 1 and "pwsh.exe" or vim.o.shell,
      open_mapping = [[<c-`>]], -- VSCode 风格: Ctrl+`
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      persist_mode = true,
      direction = "horizontal", -- 默认底部面板
      close_on_exit = false,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.8) end,
        winblend = 3,
      },
    },

    keys = {
      -- ====== VSCode 风格：底部面板，切换不同终端 ======
      { "<C-`>", "<cmd>ToggleTerm<cr>", desc = "切换终端", mode = { "n", "t" } },
      { "<leader>ts", "<cmd>TermSelect<cr>", desc = "选择终端 (Tab列表)" },
      { "<leader>tn", function()
        local terms = require("toggleterm.terminal").get_all()
        local next_id = #terms + 1
        vim.cmd(next_id .. "ToggleTerm")
      end, desc = "新建终端" },

      -- 快速切换终端 1-4（都在底部同一位置，像 VSCode tab）
      { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "终端 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "终端 2" },
      { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "终端 3" },
      { "<leader>t4", "<cmd>4ToggleTerm<cr>", desc = "终端 4" },

      -- 终端内快速切换：Ctrl+Shift+[ 和 ]
      { "<C-S-[>", function()
        local terms = require("toggleterm.terminal").get_all()
        if #terms == 0 then return end
        local current = require("toggleterm.terminal").get_focused_id() or 1
        local prev = current > 1 and current - 1 or #terms
        vim.cmd(prev .. "ToggleTerm")
      end, desc = "上一个终端", mode = { "n", "t" } },
      { "<C-S-]>", function()
        local terms = require("toggleterm.terminal").get_all()
        if #terms == 0 then return end
        local current = require("toggleterm.terminal").get_focused_id() or 1
        local next = current < #terms and current + 1 or 1
        vim.cmd(next .. "ToggleTerm")
      end, desc = "下一个终端", mode = { "n", "t" } },

      -- ====== 特殊布局 ======
      { "<leader>tf", function() require("toggleterm").toggle(nil, nil, nil, "float") end, desc = "浮动终端" },
      { "<leader>tt", function() require("toggleterm").toggle(nil, nil, nil, "tab") end, desc = "全屏终端(Tab)" },

      -- ====== 分屏模式 ======
      { "<leader>t-", function()
        -- 水平分屏：显示所有已存在的终端
        local terms = require("toggleterm.terminal").get_all()
        if #terms == 0 then
          vim.notify("没有终端，先用 <leader>tn 创建", vim.log.levels.WARN)
          return
        end
        -- 先关闭所有，再以 horizontal 方向打开
        for _, term in ipairs(terms) do
          term:close()
        end
        for _, term in ipairs(terms) do
          term:open(nil, "horizontal")
        end
        vim.notify("已分屏显示 " .. #terms .. " 个终端", vim.log.levels.INFO)
      end, desc = "水平分屏所有终端" },
      { "<leader>t|", function()
        -- 垂直分屏：显示所有已存在的终端
        local terms = require("toggleterm.terminal").get_all()
        if #terms == 0 then
          vim.notify("没有终端，先用 <leader>tn 创建", vim.log.levels.WARN)
          return
        end
        for _, term in ipairs(terms) do
          term:close()
        end
        for _, term in ipairs(terms) do
          term:open(nil, "vertical")
        end
        vim.notify("已分屏显示 " .. #terms .. " 个终端", vim.log.levels.INFO)
      end, desc = "垂直分屏所有终端" },

      -- ====== 终端管理 ======
      { "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", desc = "隐藏所有终端" },
      { "<leader>tk", function()
        -- 关闭当前终端
        local id = require("toggleterm.terminal").get_focused_id()
        if id then
          require("toggleterm.terminal").get(id):shutdown()
          vim.notify("终端 " .. id .. " 已关闭", vim.log.levels.INFO)
        end
      end, desc = "关闭当前终端" },
      { "<leader>tK", function()
        -- 关闭所有终端
        local terms = require("toggleterm.terminal").get_all()
        for _, term in ipairs(terms) do
          term:shutdown()
        end
        vim.notify("已关闭 " .. #terms .. " 个终端", vim.log.levels.INFO)
      end, desc = "关闭所有终端" },

      -- ====== 运行代码 ======
      { "<leader>rp", "<cmd>TermExec cmd='python %:p'<cr>", desc = "运行 Python" },
      { "<leader>rn", "<cmd>TermExec cmd='node %:p'<cr>", desc = "运行 Node" },
    },

    config = function(_, opts)
      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal

      -- LazyGit
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        float_opts = {
          border = "double",
          width = function() return math.floor(vim.o.columns * 0.95) end,
          height = function() return math.floor(vim.o.lines * 0.95) end,
        },
        hidden = true,
      })
      vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "LazyGit" })

      -- Python REPL
      local python_repl = Terminal:new({ cmd = "python", direction = "float", hidden = true })
      vim.keymap.set("n", "<leader>py", function() python_repl:toggle() end, { desc = "Python REPL" })

      -- 在终端模式下的额外快捷键
      function _G.set_terminal_keymaps()
        local buf_opts = { buffer = 0 }
        -- 退出终端模式
        vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], buf_opts)
        vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], buf_opts)
        -- 窗口导航
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], buf_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], buf_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], buf_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], buf_opts)
      end

      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
    end,
  },
}
