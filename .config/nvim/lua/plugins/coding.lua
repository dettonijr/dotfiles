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
    enabled = vim.g.vscode == nil and vim.fn.hostname() == "LAMS0044",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
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

  {
    "mhinz/vim-signify",
    enabled = vim.g.vscode == nil,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
}
