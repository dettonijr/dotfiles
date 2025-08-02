return {
  -- File Search
  {
    "nvim-telescope/telescope.nvim",
    enabled = vim.g.vscode == nil, -- vim.g.vscode,
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },

    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      -- vim.keymap.set("n", "<Leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })

      -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },

  {
    "stevearc/oil.nvim",
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
      vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })

      -- Integrate file rename with LSP
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,
  },
}
