-- Format Lsp Buffer
return {
  vim.keymap.set("n", "<leader>qf", vim.lsp.buf.format, { remap = false }),
  vim.keymap.set("n", "<leader>xx", ":set conceallevel=0<CR>", {remap = false}),
  vim.keymap.set("n", "<leader>xt", ":set conceallevel=2<CR>", {remap = false})
}
