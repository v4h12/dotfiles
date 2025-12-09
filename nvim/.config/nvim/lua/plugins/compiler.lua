return {
  "Zeioth/compiler.nvim",
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  opts = {},
  keys = {
    { "<leader>co", "<cmd>CompilerOpen<cr>", desc = "Open Compiler" },
    { "<leader>cr", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results" },
    { "<leader>cs", "<cmd>CompilerStop<cr>", desc = "Stop Compilation" },
    { "<leader>cR", "<cmd>CompilerRedo<cr>", desc = "Redo Last Compilation" },
  },
  config = function(_, opts)
    require("compiler").setup(opts)
  end,
}
