set number
set relativenumber
set tabstop=4
set shiftwidth=0
set nowrap
set sidescroll=1
set completeopt-=preview
set hlsearch
set scrolloff=5

nnoremap <leader>h : wincmd h<cr>
nnoremap <leader>j : wincmd j<cr>
nnoremap <leader>k : wincmd k<cr>
nnoremap <leader>l : wincmd l<cr>
nnoremap <leader>w : write<cr>

" Plugins installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'ycm-core/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'valloric/listtoggle'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" YouCompleteMe plugin options
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '∆'

nnoremap <leader>go : YcmCompleter GoTo<cr>
nnoremap <leader>fi : YcmCompleter FixIt<cr>
nnoremap <leader>fm : YcmCompleter Format<cr>
nnoremap <leader>gd : YcmCompleter GetDoc<cr>
nnoremap <leader>rn : YcmCompleter RefactorRename<space>

" ListToggle plugin options
let g:lt_height = 5
let g:lt_location_list_toggle_map = '<leader>e'

" Fugitive plugin options
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gl :Git log<cr>

" Theming
set termguicolors
colorscheme onedark
let g:airline_theme='onedark'

