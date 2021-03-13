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
Plug 'valloric/youcompleteme'
call plug#end()

" Select gruvbox as colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

