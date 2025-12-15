return {
  "Zeioth/compiler.nvim",
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  opts = {},
  keys = {
    { "<leader>Co", "<cmd>CompilerOpen<cr>", desc = "Open Compiler" },
    { "<leader>Cr", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results" },
    { "<leader>Cs", "<cmd>CompilerStop<cr>", desc = "Stop Compilation" },
    { "<leader>CR", "<cmd>CompilerRedo<cr>", desc = "Redo Last Compilation" },
  },
  config = function(_, opts)
    require("compiler").setup(opts)
  end,
}
