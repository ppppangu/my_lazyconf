return {
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("media_files")
    end,
    keys = {
      { "<leader>fm", "<cmd>Telescope media_files<cr>", desc = "Media Files" },
    },
  },
}