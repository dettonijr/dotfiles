return {
  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = vim.g.vscode == nil,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "typescript" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-treesitter/playground",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
  {
    "vigoux/notifier.nvim",
    config = function()
      -- conflict with notifier from snacks
      ---@diagnostic disable-next-line: undefined-field
      require("notifier").setup({
        components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
          "lsp", -- LSP status updates
        },
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
          enabled = false,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-CR>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
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
    end,
  },

  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<C-w>h")
      if vim.fn.has("persistent_undo") == 1 then
        local target_path = vim.fn.expand("~/.undodir")

        -- create the directory and any parent directories if the location does not exist
        if not vim.fn.isdirectory(target_path) then
          vim.cmd("!mkdir -p 0700" .. target_path)
        end

        vim.o.undodir = target_path
        vim.o.undofile = true
      end
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "terminal", cmd = "nvim --version | cowsay", hl = "header", padding = 1, indent = 8 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      explorer = { enabled = true },
      picker = {
        enabled = true,
        -- layout = { preset = "telescope", layout = { position = "top" } },
        matcher = {
          frecency = true,
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = 100,
          },
        },
      },
      quickfile = { enabled = true },
      words = { enabled = true },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "sschleemilch/slimline.nvim",
    opts = {
      style = "fg",
    },
  },

  {
    "tpope/vim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
  },

  {
    "lewis6991/gitsigns.nvim",
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
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
