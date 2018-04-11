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
call plug#end()

let g:ycm_semantic_triggers = {
    \ 'elm' : ['.'],
    \}
