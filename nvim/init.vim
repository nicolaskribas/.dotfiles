call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
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
colorscheme base16-onedark 

let g:lightline = { 'colorscheme': 'one' }

let g:coc_global_extensions = ['coc-clangd', 
			\ 'coc-rust-analyzer', 'coc-json',
			\ 'coc-css', 'coc-tsserver', 
			\ 'coc-markdownlint']

nmap <leader>h : wincmd h<cr>
nmap <leader>j : wincmd j<cr>
nmap <leader>k : wincmd k<cr>
nmap <leader>l : wincmd l<cr>

