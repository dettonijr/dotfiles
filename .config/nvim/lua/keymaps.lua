-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    -- vim.keymap.set({ 'n', 'x' }, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', vim.tbl_extend('force', opts, { desc = '' }))
    vim.keymap.set(
      { "n", "x" },
      "<leader>cf",
      '<cmd>lua require("conform").format({async = true})<cr>',
      vim.tbl_extend("force", opts, { desc = "" })
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      vim.tbl_extend("force", opts, { desc = "" })
    )
    vim.keymap.set(
      "n",
      "<leader>cd",
      ':lua vim.diagnostic.open_float(0, {scope="line"})<cr>',
      vim.tbl_extend("force", opts, { desc = "" })
    )
  end,
})
