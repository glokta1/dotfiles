call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nvim-lua/completion-nvim'
call plug#end()

let mapleader = " "

set termguicolors
colorscheme gruvbox-material
set nohlsearch
set ignorecase
set guicursor= 
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set mouse=a
set nu rnu
set history=200
set splitbelow splitright
set completeopt=menuone,noinsert
set shortmess-=F

autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++11 -O2 -Wall % -o %:r<CR>
autocmd filetype cpp nnoremap <F10> :terminal ./%:r <CR>i


" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
nnoremap <leader>s :UltiSnipsEdit<CR>

"completion-nvim settings
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = "UltiSnips"
let g:completion_enable_auto_paren = 1
let g:completion_matching_strategy_list = ['fuzzy']

" deoplete settings
let g:deoplete#enable_at_startup = 0

" Python 3 settings
let g:python3_host_prog="/usr/bin/python3"

" Highlight selection on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

" Speedy vimrc editing
nnoremap <leader>ev :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

"Terminal mode mappings
tnoremap <Esc> <C-\><C-n>

