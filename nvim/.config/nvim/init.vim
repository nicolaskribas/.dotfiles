call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
call plug#end()

set tabstop=4
set shiftwidth=0
set number
set relativenumber
set hidden
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set signcolumn=yes
set updatetime=300
set termguicolors
set noshowmode

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
colorscheme nord

let g:lightline = {'colorscheme': 'nord'}

let g:coc_global_extensions = ['coc-clangd', 
			\ 'coc-rust-analyzer', 'coc-json',
			\ 'coc-css', 'coc-tsserver', 
			\ 'coc-markdownlint']

nmap <leader>h : wincmd h<cr>
nmap <leader>j : wincmd j<cr>
nmap <leader>k : wincmd k<cr>
nmap <leader>l : wincmd l<cr>

