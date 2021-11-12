call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
call plug#end()

set tabstop=4
set shiftwidth=0
set number
set relativenumber
set hidden
set undofile
set signcolumn=yes
set updatetime=250
set termguicolors
set noshowmode
set mouse=a
set breakindent
set ignorecase
set smartcase
set completeopt=menuone,noselect

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
colorscheme nord

let g:lightline = {'colorscheme': 'nord'}

noremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

noremap <leader>y "+y
noremap <leader>p "+p
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
