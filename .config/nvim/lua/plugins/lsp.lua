local lsp_servers = {
  "lua_ls",
  "ts_ls",
  "clangd",
  "angularls",
  "html",
  "jsonls",
  "cssls",
  "bashls",
  "groovyls",
  "rust_analyzer",
  "emmet-ls",
  "pyright",
}

return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },

  -- configures nvim to use LSP servers
  {
    "neovim/nvim-lspconfig",
    version = "*",
    enabled = vim.g.vscode == nil,
    dependencies = {},
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    config = function()
      vim.lsp.enable(lsp_servers)
      -- vim.diagnostic.config({ virtual_lines = { current_line = true } })
    end,
  },

  -- Repo and package manager with LSPs, linters, formatters, DAPs
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      {
        "williamboman/mason.nvim",
        version = "*",
        enabled = vim.g.vscode == nil,
        config = function()
          require("mason").setup()
        end,
      },
    },
    config = function()
      -- TODO: Get this directly from conform
      local formatters = {
        "stylua",
        "prettierd",
        "isort",
        "black",
        "rustfmt",
        "eslint",
      }
      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.deepcopy(lsp_servers), formatters),
      })
    end,
  },

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          -- I recommend these options. See :help conform.format for details.
          lsp_format = "fallback",
          timeout_ms = 500,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = { "prettierd" },
          typescript = { "eslint" },
          html = { "prettierd", "eslint" },
        },
      })
    end,
  },

  -- autocomplete and snippets
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "enter" },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
