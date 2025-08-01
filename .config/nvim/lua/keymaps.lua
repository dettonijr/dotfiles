local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    map("n", "<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)

    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "go", vim.lsp.buf.type_definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gs", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>cr", vim.lsp.buf.rename, opts)
    -- km({ 'n', 'x' }, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', vim.tbl_extend('force', opts, { desc = '' }))
    map({ "n", "x" }, "<leader>cf", function()
      require("conform").format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "" }))

    map("n", "<leader>cd", function()
      vim.diagnostic.open_float({ float_bufnr = 0, scope = "line" })
    end, vim.tbl_extend("force", opts, { desc = "" }))
  end,
})
