syn on
set tabstop=4
set expandtab

"set si
set nu
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

call plug#begin()
Plug 'elmcast/elm-vim'
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git'
Plug 'https://github.com/nvie/vim-flake8.git'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
call plug#end()

let g:ycm_semantic_triggers = {
    \ 'elm' : ['.'],
    \}

let g:ycm_global_ycm_extra_conf = "$HOME/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0

autocmd BufWritePost *.py call Flake8()
