-- 在 ~/.config/nvim/lua/plugins/dotenv.lua
return {
  "ellisonleao/dotenv.nvim",
  config = function()
    require("dotenv").setup()
  end,
}