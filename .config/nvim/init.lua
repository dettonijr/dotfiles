-- vim.cmd("syn on")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set ai")
vim.cmd("set nu")
vim.cmd("set scrolloff=10")
vim.opt.hlsearch = true
vim.g.mapleader = ","
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.cursorline = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
vim.opt.foldcolumn = "0"

vim.api.nvim_create_autocmd("BufReadPost", { command = 'silent! normal! g`"zz' })
vim.keymap.set("n", "<C-j>", "5<C-e>5j")
vim.keymap.set("n", "<C-k>", "5<C-y>5k")
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  print("Installing lazy.nvim....")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("keymaps")
