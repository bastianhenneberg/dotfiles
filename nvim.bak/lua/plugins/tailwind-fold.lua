return {
  {
    "razak17/tailwind-fold.nvim",
    opts = {
      enabled = true,
      -- Only fold when class string char count is more than 30. Folds everything by default.
      min_chars = 0,
      ft = {
        "html",
        "svelte",
        "astro",
        "vue",
        "tsx",
        "jsx",
        "javascript",
        "php",
        "blade",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "javascriptreact", "typescriptreact", "tsx", "jsx", "php", "blade" },
  },
}
