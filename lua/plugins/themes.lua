-- 主题增强 - Catppuccin
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          Search = { bg = colors.yellow, fg = colors.base },
          IncSearch = { bg = colors.green, fg = colors.base },
          CurSearch = { bg = colors.red, fg = colors.base },
        }
      end,
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = true,
        dashboard = true,
        dap = true,
        dap_ui = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  -- 配置 LazyVim 使用 Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- bufferline 集成 (使用安全的方式)
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        -- 安全检查模块是否存在
        local ok, catppuccin_bufferline = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok then
          opts.highlights = catppuccin_bufferline.get()
        end
      end
    end,
  },
}
