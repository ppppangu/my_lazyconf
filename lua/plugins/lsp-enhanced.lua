-- LSP 增强配置
return {
  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      autoformat = true,
      format_timeout = 3000,
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
      inlay_hints = { enabled = true },
    },
  },

  -- LSP Saga
  {
    "glepnir/lspsaga.nvim",
    lazy = false,
    opts = {
      ui = {
        theme = "round",
        border = "rounded",
        code_action = "💡",
      },
      hover = { max_width = 0.6, max_height = 0.8 },
      diagnostic = { show_code_action = true, show_source = true },
      code_action = { num_shortcut = true, extend_gitsigns = true },
      lightbulb = { enable = true, sign = true, virtual_text = false },
      symbol_in_winbar = { enable = true, separator = " ", show_file = true },
      finder = {
        max_height = 0.6,  -- 最大高度 60%
        left_width = 0.4,  -- 左侧列表宽度 40%
        right_width = 0.4, -- 右侧预览宽度 40%
        default = "def+ref+imp", -- 同时显示定义、引用、实现
        layout = "float",  -- 浮动窗口
        filter = {},
        silent = false,
      },
    },
    keys = {
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "查找符号" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "代码操作" },
      { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "重命名" },
      { "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "行诊断" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "大纲" },
      { "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", desc = "悬停文档" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "上一个诊断" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "下一个诊断" },
      { "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "预览定义" },
      { "gD", "<cmd>Lspsaga goto_definition<cr>", desc = "跳转到定义" },
      { "gt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "预览类型定义" },
    },
  },

  -- 内置 inlay hints 切换
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>li",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        desc = "切换内联提示",
      },
    },
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = { auto_close = true, use_diagnostic_signs = true },
  },
}
