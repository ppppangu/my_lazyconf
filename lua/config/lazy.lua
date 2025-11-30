local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 禁用 neotest（释放 <leader>t 给终端）
    { "nvim-neotest/neotest", enabled = false },
    { "nvim-neotest/neotest-python", enabled = false },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- 性能够：全部直接加载
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
    frequency = 3600,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    filter = true,
  },
  -- ============================================
  -- 强制直接加载的插件（覆盖 LazyVim 默认的懒加载）
  -- ============================================
  pkg = {
    enabled = true,
  },
})

-- ============================================
-- 强制加载常用插件（绕过 LazyVim 的懒加载设置）
-- ============================================
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- 这些插件在 VeryLazy 事件后立即加载
    local plugins_to_load = {
      "gitsigns.nvim",
      "todo-comments.nvim",
      "vim-illuminate",
      "rainbow-delimiters.nvim",
      "nvim-treesitter-context",
      "nvim-ts-autotag",
      "mini.hipatterns",
      "nvim-lint",
      "conform.nvim",
      "aerial.nvim",
      "diffview.nvim",
      "git-conflict.nvim",
      "multicursors.nvim",
      "refactoring.nvim",
      "lspsaga.nvim",
      "codeium.vim",
      "yanky.nvim",
      "leap.nvim",
      "flit.nvim",
      "dial.nvim",
      "grug-far.nvim",
      "render-markdown.nvim",
    }

    for _, plugin in ipairs(plugins_to_load) do
      pcall(function()
        require("lazy").load({ plugins = { plugin } })
      end)
    end
  end,
})
