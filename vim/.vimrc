syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number

set mouse=a

set ruler

filetype plugin indent on

"remember position in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"copy to the system clipboard with Y
map Y "+y

"make backspace sane
set backspace=2
