call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim' 
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dense-analysis/ale'
" Plug 'HerringtonDarkholme/yats.vim' Might be causing trouble with tab
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
Plug 'luochen1990/rainbow'
" Plug 'jason0x43/vim-js-indent'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

call plug#end()

set relativenumber
set nu rnu

set background = "dark"
syntax on
colorscheme onedark 
set termguicolors
set encoding=UTF-8

set cindent

" Thanks ChrisAtMachine
" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''

set showtabline=2

let g:ale_sign_error='❌'
let g:ale_sign_warning='⚠️'

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'


set guifont=FiraCode\ Nerd\ Font

let g:rainbow_active=1
