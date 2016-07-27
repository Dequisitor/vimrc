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
Plugin 'kshenoy/vim-signature'
Plugin 'chriskempson/base16-vim'
call vundle#end()

"general settings
set directory=$HOME\\.vim\\.swp\\
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set cot=menu
set number
set relativenumber
set nowrap
set hidden
set hlsearch
set foldenable
set foldmethod=manual
set mousehide
set incsearch
syntax enable
filetype plugin indent on

"colorschemes
if has('gui_running')
	colorscheme base16-default
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
set timeoutlen=200
""window navigation
nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-w> :call BClose()<CR>
nnoremap <silent> <Tab> :wincmd w<CR>
""vimrc stuff
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
""movements and frequently used keys
noremap <leader>. <Esc>
inoremap <Esc> <nop>
nnoremap L $
nnoremap H ^
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
nnoremap ; :
nnoremap [[ [{
nnoremap ]] ]}
nnoremap <silent> <CR> :noh<CR>
""text manipulation
nnoremap <C-k> ddkP
nnoremap <C-j> ddp
vnoremap <C-k> xkP`[V`]
vnoremap <C-j> xp`[V`]
""folding
nnoremap <leader>ft Vatzf
nnoremap <leader>ff [{V%zf:noh<CR>

"spelling
set spell spelllang=en_gb
iab teh the
iab Teh The

"autosave
au Focuslost * :wa

"conditional remaps
autocmd filetype tex nnoremap <C-s> :w<CR>:!pdflatex %<CR>
autocmd filetype tex inoremap <C-s> <Esc>:w<CR>:!pdflatex %<CR>
autocmd filetype cshtml set syntax=html
autocmd filetype pug set syntax=pug

"undo stuff
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set undofile
