-- UI 增强
return {
  -- nvim-notify (禁用，让 snacks.notifier 接管)
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  -- 禁用 dressing，让 snacks.input 接管
  {
    "stevearc/dressing.nvim",
    enabled = false,
  },

  -- Noice 配置 (不覆盖 notify)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- 禁用 noice 的 notify，使用 snacks
      notify = {
        enabled = false,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = "mini",  -- 使用 mini 视图而不是 notify
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },
      routes = {
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "", find = "more lines" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "", find = "fewer lines" },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = "auto" },
          border = { style = "rounded", padding = { 0, 1 } },
        },
      },
    },
    keys = {
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "最后一条消息" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "消息历史" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "所有消息" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "关闭所有通知" },
    },
  },

  -- 启动界面
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " 查找文件", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " 新文件", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " 最近文件", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " 查找文本", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " 配置", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " 恢复会话", "<cmd>SessionRestore<cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " 退出", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function() require("lazy").show() end,
        })
      end
      require("alpha").setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- Lualine 增强
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if #buf_clients == 0 then return "LSP Inactive" end
          local buf_client_names = {}
          for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
              table.insert(buf_client_names, client.name)
            end
          end
          return "[" .. table.concat(vim.fn.uniq(buf_client_names), ", ") .. "]"
        end,
        icon = " ",
        color = { gui = "bold" },
      })
      return opts
    end,
  },

  -- 补全窗口美化 (blink.cmp)
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },
    },
  },
}
