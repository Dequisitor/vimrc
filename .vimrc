"encoding
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bomb,utf-8,latin1

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'myhere/vim-nodejs-complete'
Plugin 'kchmck/vim-coffee-script'
Plugin 'leafgarland/typescript-vim'
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-pug'
call vundle#end()

"general settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set cot=menu
set number
set nowrap
syntax enable
filetype plugin indent on

"solarized
if has('gui_running')
	colorscheme solarized
	set background=dark
	autocmd vimenter * NERDTree
else
	colorscheme evening
endif

"listchars
let &listchars="tab:\u2506\ ,trail:\u25c0" 
hi SpecialKey guibg=bg
set list

"airline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
if has('gui_running')
	let g:airline_powerline_fonts=1
	let g:airline_theme="papercolor"
else
	let g:airline_theme="hybrid"
endif

"functions
function! BClose()
	let l:bufferId = bufnr("%")
	:bn
	execute ":bd". l:bufferId
endfunction

"key mappings
let mapleader=','
"nnoremap <C-s> :w<CR>
"inoremap <C-s> <Esc>:w<CR>
nnoremap <silent> <C-Left> :bp<CR>
nnoremap <silent> <C-Right> :bn<CR>
nnoremap <silent> <C-w> :call BClose()<CR>
nnoremap <silent> <Tab> :wincmd w<CR>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
inoremap <leader>. <Esc>
inoremap <Esc> <nop>
nnoremap L $
nnoremap H ^
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
nnoremap ; :

"conditional remaps
autocmd filetype java inoremap <silent> <C-s> <Esc>:w<CR>:Validate<CR>
autocmd filetype java nnoremap <leader>m :JavaImport<CR>
autocmd filetype java nnoremap <leader>p :JavaImpl<CR>

autocmd filetype tex nnoremap <C-s> :w<CR>:!pdflatex %<CR>
autocmd filetype tex inoremap <C-s> <Esc>:w<CR>:!pdflatex %<CR>
autocmd filetype cshtml set syntax=html
autocmd filetype pug set syntax=pug

"undo stuff
set undofile
set undodir=$home/.vim/undo
set undolevels=1000
set undoreload=10000
