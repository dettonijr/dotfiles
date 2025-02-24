return {
  -- File Search
  {
    'nvim-telescope/telescope.nvim',
    enabled = vim.g.vscode == nil, -- vim.g.vscode,
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },


  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = vim.g.vscode == nil, -- vim.g.vscode,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set('n', '<leader>n', ':Neotree filesystem toggle left<CR>')
      require("neo-tree").setup({
        filesytem = {
          follow_current_file = { enabled = true }
        }
      })
    end
  },
  {
    'stevearc/oil.nvim',
    enabled = vim.g.vscode == nil, -- vim.g.vscode,
    tag = "v2.15.0",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  }
}
