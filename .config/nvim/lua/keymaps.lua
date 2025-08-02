vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local baseOpts = { buffer = event.buf }

    ---@param mode string|string[]
    ---@param lhs string
    ---@param rhs string|function
    ---@param desc? string
    ---@see vim.keymap.set
    local map = function(mode, lhs, rhs, desc)
      local options = vim.tbl_extend("force", baseOpts, desc and { desc = desc } or {})
      vim.keymap.set(mode, lhs, rhs, options)
    end

    map("n", "<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)

    map("n", "K", vim.lsp.buf.hover, "Show [H]over")
    map("n", "gd", vim.lsp.buf.definition, "Go to [D]efinition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to [D]eclaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to [I]mplementation")
    map("n", "go", vim.lsp.buf.type_definition, "Go to [O]verview (type definition)")
    map("n", "gr", vim.lsp.buf.references, "Go to [R]eferences")
    map("n", "gs", vim.lsp.buf.signature_help, "Show [S]ignature Help")

    map("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
    map({ "n", "x" }, "<leader>cf", function()
      require("conform").format({ async = true })
    end, "[C]ode [F]ormat")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("n", "<leader>cd", function()
      vim.diagnostic.open_float({ float_bufnr = 0, scope = "line" })
    end, "[C]ode [D]iagnostic")
  end,
})

vim.keymap.set("n", "<leader>tu", ":SignifyHunkUndo<CR>", { desc = "Gi[T] hunk [U]ndo" })
vim.keymap.set("n", "<leader>th", ":SignifyHunkDiff<CR>", { desc = "Gi[T] [H]unk diff" })
vim.keymap.set("n", "<leader>td", ":SignifyDiff<CR>", { desc = "Gi[T] file [D]iff" })
