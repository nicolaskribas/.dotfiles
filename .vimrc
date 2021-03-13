" Some vim options
set number
set relativenumber
set nowrap
set shiftwidth=4
set tabstop=4
set background=dark

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins list
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'valloric/youcompleteme'
call plug#end()

" Turn off YouCompleteMe diagnostics 
let g:ycm_show_diagnostics_ui = 0

" Syntastic plugin recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Select gruvbox as colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

