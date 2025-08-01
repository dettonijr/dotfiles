local lsp_configurations = function()
  local util = require("lspconfig.util")
  return {
    elixirls = {
      cmd = { "/Users/dettonijr/elixir-ls/language_server.sh" },
    },
    ts_ls = {},
    lua_ls = {
      on_init = function(client)
        --if client.workspace_folders then
        --  local path = client.workspace_folders[1].name
        --  if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        --    return
        --  end
        --end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              "${3rd}/luv/library",
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
      settings = {
        Lua = {},
      },
    },
    clangd = {
      cmd = { "clangd", "--compile-commands-dir=." },
    },
    angularls = {
      root_dir = util.root_pattern("angular.json", "project.json"),
      filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
    },
    eslint = {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    },
    html = {},
    jsonls = {},
    cssls = {},
    bashls = {},
    rust_analyzer = {},
    groovyls = {},
  }
end

local get_table_keys = function(tab)
  local keyset = {}
  for k, _ in pairs(tab) do
    keyset[#keyset + 1] = k
  end
  return keyset
end

return {
  -- Repo and package manager with LSPs, linters, formatters, DAPs
  {
    "williamboman/mason.nvim",
    version = "*",
    enabled = vim.g.vscode == nil,
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason auto install LSPs
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = get_table_keys(lsp_configurations()),
      })

      vim.diagnostic.config({
        virtual_lines = true,
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
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "eslint_d", "prettierd", stop_after_first = true },
          html = { "prettierd", "eslint_d", "prettier", stop_after_first = true },
        },
      })
    end,
  },

  -- configures nvim to use LSP servers
  {
    "neovim/nvim-lspconfig",
    version = "*",
    enabled = vim.g.vscode == nil,
    dependencies = {},
    config = function()
      for lsp, setup in pairs(lsp_configurations()) do
        vim.lsp.config(lsp, setup)
        vim.lsp.enable(lsp)
      end
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

  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = "*",
  --   enabled = false,
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-buffer",
  --     "neovim/nvim-lspconfig",
  --     "honza/vim-snippets",
  --     {
  --       "L3MON4D3/LuaSnip",
  --       -- follow latest release.
  --       version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --       -- install jsregexp (optional!).
  --       build = "make install_jsregexp",
  --       dependencies = { "rafamadriz/friendly-snippets" },
  --       config = function()
  --         require("luasnip").filetype_extend("ex", { "elixir" })
  --         require("luasnip.loaders.from_vscode").lazy_load()
  --       end,
  --     },
  --   },
  --
  --   config = function()
  --     local cmp = require("cmp")
  --     cmp.setup({
  --       snippet = {
  --         -- REQUIRED - you must specify a snippet engine
  --         expand = function(args)
  --           -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --           require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
  --           -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --           -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  --
  --           -- For `mini.snippets` users:
  --           -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
  --           -- insert({ body = args.body }) -- Insert at cursor
  --           -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
  --           -- require("cmp.config").set_onetime({ sources = {} })
  --         end,
  --       },
  --       window = {
  --
  --         -- completion = cmp.config.window.bordered(),
  --         -- documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         -- { name = 'vsnip' }, -- For vsnip users.
  --         { name = "luasnip" }, -- For luasnip users.
  --         -- { name = 'ultisnips' }, -- For ultisnips users.
  --         -- { name = 'snippy' }, -- For snippy users.
  --       }, {
  --         { name = "buffer" },
  --         { name = "path" },
  --       }),
  --     })
  --     -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  --     -- Set configuration for specific filetype.
  --     --[[ cmp.setup.filetype('gitcommit', {
  --           sources = cmp.config.sources({
  --             { name = 'git' },
  --           }, {
  --             { name = 'buffer' },
  --           })
  --        })
  --        require("cmp_git").setup() ]]
  --     --
  --
  --     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --     -- cmp.setup.cmdline({ '/', '?' }, {
  --     --   mapping = cmp.mapping.preset.cmdline(),
  --     --   sources = {
  --     --     { name = 'buffer' }
  --     --   }
  --     -- })
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     -- cmp.setup.cmdline(':', {
  --     --   completion = {
  --     --     autocomplete = false,
  --     --   },
  --     --   mapping = cmp.mapping.preset.cmdline(),
  --     --   sources = cmp.config.sources({
  --     --     { name = 'path' }
  --     --   }, {
  --     --     { name = 'cmdline' }
  --     --   }),
  --     --   matching = { disallow_symbol_nonprefix_matching = false }
  --     -- })
  --   end,
  -- },
}
