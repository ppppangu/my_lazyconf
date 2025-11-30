-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- ===== 性能优化 =====
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- ===== 文件管理 =====
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- ===== Session 选项 (修复 auto-session 警告) =====
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- 文件被外部修改时自动加载
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("文件已被外部修改并重新加载", vim.log.levels.INFO)
  end,
})

-- ===== 编辑体验 =====
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.linebreak = true

-- ===== 搜索 =====
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ===== 补全 =====
vim.opt.pumheight = 15
vim.opt.pumblend = 10
vim.opt.completeopt = "menu,menuone,noselect"

-- ===== 显示 =====
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

-- ===== 分屏 =====
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ===== 鼠标支持 =====
vim.opt.mouse = "a"

-- ===== 剪贴板 =====
vim.opt.clipboard = "unnamedplus"

-- ===== 禁用不需要的 provider (消除警告) =====
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
