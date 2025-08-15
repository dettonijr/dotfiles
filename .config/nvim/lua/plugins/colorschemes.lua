return {
  { "folke/tokyonight.nvim" },
  { "sainnhe/everforest" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic,altfont",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })
    end,
  },
  { "Mofiqul/vscode.nvim" },
  { "sainnhe/sonokai" },
  { "ribru17/bamboo.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "morhetz/gruvbox" },
  { "rebelot/kanagawa.nvim" },
  { "NLKNguyen/papercolor-theme" },
  { "lunacookies/vim-colors-xcode" },
  { "maxmx03/solarized.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "navarasu/onedark.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/gruvbox-material" },
  { "shaunsingh/nord.nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "paul-han-gh/tomorrow.nvim" },
  { "deparr/tairiki.nvim" },

  {
    "vague2k/huez.nvim",
    enabled = vim.g.vscode == nil,
    -- if you want registry related features, uncomment this
    import = "huez-manager.import",
    branch = "stable",
    event = "UIEnter",
    config = function()
      require("huez").setup({
        exclude = {
          "desert",
          "evening",
          "industry",
          "koehler",
          "morning",
          "murphy",
          "pablo",
          "peachpuff",
          "ron",
          "shine",
          "slate",
          "torte",
          "zellner",
          "blue",
          "darkblue",
          "delek",
          "quiet",
          "elflord",
          "habamax",
          "lunaperche",
          "zaibatsu",
          "wildcharm",
          "sorbet",
          "vim",
          "rose-pine-dawn",
          "onelight",
          "kanagawa-lotus",
          "github_light",
          "github_light_colorblind",
          "github_light_default",
          "github_light_high_contrast",
          "github_light_tritanopia",
          "dayfox",
          "dawnfox",
          "catppuccin-latte",
          "bamboo-light",
          "tairiki-light",
          "tokyonight-day",
          "xcodelight",
          "xcodelighthc",
        },
      })
    end,
  },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require("lualine").setup({
  --       options = {
  --         icons_enabled = true
  --       }
  --     })
  --   end,
  -- }
}
