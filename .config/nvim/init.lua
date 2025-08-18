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
vim.opt.signcolumn = "yes"

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

vim.g.snacks_animate = false

-- Open file in the last position
vim.api.nvim_create_autocmd("BufReadPost", { command = 'silent! normal! g`"zz' })

-- Easy exit from terminal with esc
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- swap true false
vim.keymap.set("n", "~", ":s/\\v(true|false)/\\=submatch(0) == 'true' ? 'false' : 'true'/<CR>:nohl<CR>")
-- vim.o.statuscolumn = "%!v:lua.require('statuscolumn').myStatuscolumn()"

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
