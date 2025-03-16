return {
  { 'folke/tokyonight.nvim' },
  { 'sainnhe/everforest' },
  { "catppuccin/nvim",              name = "catppuccin", priority = 1000 },
  { 'EdenEast/nightfox.nvim' },
  { 'Mofiqul/vscode.nvim' },
  { 'scottmckendry/cyberdream.nvim' },
  { 'sainnhe/sonokai' },
  { 'ribru17/bamboo.nvim' },
  { 'tiagovla/tokyodark.nvim' },
  { 'morhetz/gruvbox' },
  { 'rebelot/kanagawa.nvim' },
  { 'NLKNguyen/papercolor-theme' },
  { 'TaDaa/vimade' },
  { 'lunacookies/vim-colors-xcode'},

  {
    "vague2k/huez.nvim",
    enabled = vim.g.vscode == nil,
    -- if you want registry related features, uncomment this
    -- import = "huez-manager.import"
    branch = "stable",
    event = "UIEnter",
    config = function()
      require("huez").setup({})
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
