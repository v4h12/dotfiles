local fine_cmdline = require("fine-cmdline")

fine_cmdline.setup({
  popup = {
    position = {
      row = "98%",
      col = "100%",
    },
    size = {
      width = "25%",
    },
    border = {
      style = "single",
      text = {
        top = " cmd ",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  },
})

