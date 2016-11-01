"encoding
scriptencoding utf-8
set encoding=utf-8
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
Plugin 'andrewradev/linediff.vim'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'kien/ctrlp.vim'
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
set ignorecase
set foldenable
set foldmethod=indent
set foldlevelstart=99
set mousehide
set incsearch
syntax enable
filetype plugin indent on

"colorschemes
if has('gui_running')
	set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI
	colorscheme base16-atelierdune
	set background=dark
	autocmd vimenter * NERDTree
else
	colorscheme evening
endif

"listchars
let &listchars="tab:\u007c\ ,trail:\u25ca" 
hi SpecialKey guibg=bg
set list

"airline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
if has('gui_running')
	set encoding=utf-8
	let g:airline_powerline_fonts=1
	let g:airline_theme="papercolor"
	let g:Powerline_symbols="fancy"
else
	let g:airline_theme="hybrid"
endif

"functions
function! BufferClose()
	let bufferId = bufnr("%")
	execute "bprevious"
	execute "bdelete " . bufferId
endfunction

function! NextIndent(fwd)
	let l:line = line('.')
	let l:column = col('.')
	let l:lastLine = line('$')
	let l:indent = indent(line)
	let l:step = a:fwd ? 1 : -1
	while (l:line > 0 && l:line <= l:lastLine)
		let l:line = line + step
		if (indent(l:line) == l:indent && strlen(getline(l:line)) > 0)
			execute "normal " . l:line . "G"
			execute "normal g^"
			return
		endif
	endwhile
endfunction

function! ToggleHtmlComment()
	execute "normal m'"
	let line = getline('.')
	let comment = matchstr(line, '<!--.\+-->')
	if empty(comment)
		execute "normal I<!--"
		execute "normal A-->"
	else
		s/<!--//
		s/-->//
	endif
	execute "''"
endfunction

function! ToggleCssComment()
	execute "normal m'"
	let line = getline('.')
	let comment = matchstr(line, '/\*.\+\*/')
	if empty(comment)
		execute "normal I/*"
		execute "normal A*/"
	else
		s/\/\*//
		s/\*\//
	endif
	execute "''"
endfunction

"key mappings
let mapleader=','
set timeoutlen=200
""window navigation
nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-w> :call BufferClose()<CR>
nnoremap <silent> <Tab> :wincmd w<CR>
"vimrc stuff
nnoremap <silent> <leader>e :vsplit $MYVIMRC<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
"movements and frequently used keys
inoremap <leader>. <Esc>
vnoremap <leader>. <Esc>
inoremap jj <Esc>
inoremap <Esc> <nop>
nnoremap L $
nnoremap H ^
nnoremap J Jx
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
nnoremap ; :
nnoremap [[ [{
nnoremap ]] ]}
nnoremap <silent> {{ :call NextIndent(0)<CR>
nnoremap <silent> }} :call NextIndent(1)<CR>
nnoremap <silent> <CR> :noh<CR>
"text manipulation
nnoremap <C-k> <C-e>
nnoremap <C-j> <C-y>
"folding
nnoremap <leader>ft Vatzf
nnoremap <leader>ff [{V%zf:noh<CR>
nnoremap <space> za
"surrounding
nnoremap ss( ciw()<Esc>P
nnoremap ss) ciw()<Esc>P
nnoremap ss" ciw""<Esc>P
nnoremap ss' ciw''<Esc>P
"search
nnoremap <C-f> "9yiw /<C-R>9<Enter>
nnoremap <C-g> "9yiw :vimgrep /<C-R>9/ **\*.*<Enter>
"other
nnoremap <silent> <F3> :NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:NERDTreeToggle<CR>a

"spelling
set spell spelllang=en_gb
iab teh the
iab Teh The
iab lenght length
iab weigth weight
iab wieght weight
iab wiegth weight
iab reuqire require
iab requrei require
iab requier require

"autosave
au Focuslost * :wa

"autoreload vimrc
augroup reload_vimrc
	autocmd!
	autocmd! reload_vimrc BufWritePost $MYVIMRC nested source $MYVIMRC | echom "reloaded " . $MYVIMRC
augroup END

"conditional remaps
augroup remaps
	autocmd!
	autocmd filetype tex nnoremap <C-s> :w<CR>:!pdflatex %<CR>
	autocmd filetype tex inoremap <C-s> <Esc>:w<CR>:!pdflatex %<CR>
	autocmd filetype cshtml set syntax=html
	autocmd filetype pug set syntax=pug
	autocmd filetype html nnoremap <buffer> <C-c> :call ToggleHtmlComment()<CR>
	autocmd filetype html vnoremap <buffer> <C-c> "-c<!--<Esc>o<Esc>cc--><Esc>=="-P
	autocmd filetype xml nnoremap <buffer> <C-c> :call ToggleHtmlComment()<CR>
	autocmd filetype xml vnoremap <buffer> <C-c> "-c<!--<Esc>o<Esc>cc--><Esc>=="-P
	autocmd filetype javascript nnoremap <buffer> <C-c> I//<Esc>
	autocmd filetype javascript vnoremap <buffer> <C-c> "-c/*<Esc>o<Esc>cc*/<Esc>=="-P
	autocmd filetype css nnoremap <buffer> <C-c> :call ToggleCssComment()<CR>
augroup END

"undo stuff
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set undofile

"Nerdtree settings
let g:NERDTreeWinSize = 40
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'

"bookmark settings
let g:bookmark_sign = "\u266b"
let g:bookmark_save_per_working_dir = 1
let g:bookmark_highlight_lines = 1

"highlights
highlight BookmarkLine guibg=#009900 guifg=#ffffff gui=none
highlight BookmarkSign guibg=NONE guifg=#009900 gui=none
highlight Visual guibg=#ffffff guifg=#000000 gui=none
highlight Folded guibg=NONE guifg=fg gui=none
highlight Pmenu guibg=white guifg=black gui=bold
