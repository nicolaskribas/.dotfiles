set number
set relativenumber
set tabstop=4
set shiftwidth=0
set nowrap
set completeopt-=preview
set hlsearch
set scrolloff=10

nnoremap <leader>h : wincmd h<cr>
nnoremap <leader>j : wincmd j<cr>
nnoremap <leader>k : wincmd k<cr>
nnoremap <leader>l : wincmd l<cr>

" Plugins installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ycm-core/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'valloric/listtoggle'
Plug 'tpope/vim-fugitive'
call plug#end()

" YouCompleteMe plugin options
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '∆'

nnoremap <leader>go : YcmCompleter GoTo<cr>
nnoremap <leader>fi : YcmCompleter FixIt<cr>
nnoremap <leader>fm : YcmCompleter Format<cr>
nnoremap <leader>gd : YcmCompleter GetDoc<cr>

" ListToggle plugin options
let g:lt_height = 5
let g:lt_location_list_toggle_map = '<leader>e'

" Theming
let g:gruvbox_contrast_dark = 'hard'
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

