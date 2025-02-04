-- vim.cmd("syn on")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set ai")
vim.cmd("set nu")
vim.cmd("set scrolloff=10")
vim.g.mapleader = ","

vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.cursorline = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
vim.opt.foldcolumn = "0"


vim.api.nvim_create_autocmd('BufReadPost', { command = "silent! normal! g`\"zz" })
vim.keymap.set('n', '<C-j>', '5<C-e>5j')
vim.keymap.set('n', '<C-k>', '5<C-y>5k')
vim.keymap.set('n', '<leader>vc', '<cmd>tabnew ~/.config/nvim/init.lua<cr>')


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

local lsp_configurations = {
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

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    }
  }
}

local plugins = {
  -- colorschemes
  { 'folke/tokyonight.nvim' },
  { 'sainnhe/everforest' },
  { "catppuccin/nvim",              name = "catppuccin", priority = 1000 },
  { 'EdenEast/nightfox.nvim' },
  { 'Mofiqul/vscode.nvim' },
  { 'scottmckendry/cyberdream.nvim' },
  { 'sainnhe/sonokai' },
  { 'ribru17/bamboo.nvim' },

  -- File Search
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "typescript", "javascript", "lua", "elixir", "eex", "heex" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
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

  -- LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require "mason".setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require "mason-lspconfig".setup({
        ensure_installed = { "lua_ls", 'ts_ls', 'elixirls' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set('n', '<leader>cd', ':lua vim.diagnostic.open_float(0, {scope="line"})<cr>', opts)
        end,
      })
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'neovim/nvim-lspconfig',
      'honza/vim-snippets',
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      }
    },

    config = function()
      local cmp = require 'cmp'
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
          end,
        },
        window = {

          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'git' },
            }, {
              { name = 'buffer' },
            })
         })
         require("cmp_git").setup() ]] --

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      --   completion = {
      --     autocomplete = false,
      --   },
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      for lsp, setup in pairs(lsp_configurations) do
        setup[capabilities] = capabilities
        require('lspconfig')[lsp].setup(setup)
      end
    end
  },

  {
    "zbirenbaum/copilot.lua",
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
  }
}

require('lazy').setup(plugins)

vim.cmd.colorscheme "catppuccin"
vim.cmd.colorscheme "tokyonight"
vim.cmd.colorscheme "everforest"
vim.cmd.colorscheme "nightfox"
