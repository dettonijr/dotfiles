return {
  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = vim.g.vscode == nil,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },


  {
    "dlvandenberg/tree-sitter-angular",
    enabled = vim.g.vscode == nil,
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = vim.g.vscode == nil,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-CR>",
            accept_word = false,
            accept_line = "<C-l>",
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<ESC>",
          },
        },
      })
    end,
  },

  -- Context lines on top
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = vim.g.vscode == nil,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup()
    end
  },

  -- Auto pair "" [] ()
  {
    'windwp/nvim-autopairs',
    enabled = vim.g.vscode == nil,
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "tpope/vim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
  },

--  {
--    "tpope/vim-fugitive",
--    enabled = vim.g.vscode == nil,
--  }

  {
    -- "airblade/vim-gitgutter",
    "mhinz/vim-signify",
    enabled = vim.g.vscode == nil,
  }
}
