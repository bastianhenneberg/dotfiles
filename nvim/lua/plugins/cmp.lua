local cmp = require("cmp")

return {
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered({ border = "single" }),
    },
  }),
}
