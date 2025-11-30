-- 编辑增强功能
return {
  -- 自动保存
  {
    "okuuva/auto-save.nvim",
    lazy = false,
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },  -- 修复拼写错误
      },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if fn.getbufvar(buf, "&modifiable") == 1
          and utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "gitrebase" })
        then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 1000,
    },
    keys = {
      { "<leader>ts", "<cmd>ASToggle<cr>", desc = "切换自动保存" },
    },
  },

  -- Todo 注释
  {
    "folke/todo-comments.nvim",
    lazy = false,
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev Todo" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },

  -- 代码截图
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("silicon").setup({
        font = "JetBrainsMono Nerd Font=34",
        theme = "Dracula",
        background = "#94e2d5",
        shadow_blur_radius = 16,
        shadow_offset_x = 8,
        shadow_offset_y = 8,
        line_offset = function(args) return args.line1 end,
        line_pad = 2,
        pad_horiz = 80,
        pad_vert = 100,
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
        end,
      })
    end,
    keys = {
      { "<leader>sc", ":Silicon<cr>", mode = "v", desc = "生成代码截图" },
    },
  },

  -- 彩虹括号
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- 缩进线 (v3 配置格式)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",  -- v3 使用 ibl 模块
    lazy = false,
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true, show_start = true, show_end = false },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "toggleterm" },
      },
    },
  },

  -- 平滑滚动
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      cursor_scrolls_alone = true,
      easing_function = "sine",
    },
  },

  -- 高亮相同单词
  {
    "RRethy/vim-illuminate",
    lazy = false,
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { "lsp" } },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end
      map("]]", "next")
      map("[[", "prev")
    end,
    keys = {
      { "]]", desc = "下一个引用" },
      { "[[", desc = "上一个引用" },
    },
  },
}
