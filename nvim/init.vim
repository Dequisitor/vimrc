"encoding
scriptencoding utf-8
set fileencodings=ucs-bomb,utf-8,latin1

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'othree/html5.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'w0rp/ale'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'sickill/vim-monokai'
Plugin 'equalsraf/neovim-gui-shim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-surround'
Plugin 'wellle/targets.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'mxw/vim-jsx'
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
set wildmenu
set relativenumber
set nowrap
set hidden
set hlsearch
"set ignorecase
set scrolloff=5
set foldenable
set foldmethod=indent
set foldlevelstart=99
set mousehide
set incsearch
syntax enable
filetype plugin indent on

let &listchars="tab:\u007c\ ,trail:\u25ca"
hi SpecialKey guibg=bg
set list

"colorscheme
set background=dark
colorscheme base16-atelier-dune
AirlineTheme base16_atelierdune
GuiFont DejaVuSansMonoForPowerline NF:h11

"functions
function! BufferClose()
	let bufferId = bufnr("%")
	execute "bprevious"
	execute "bdelete " . bufferId
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

function! ToggleJSComment()
	execute "normal m'"
	let line = getline('.')
	let comment = matchstr(line, '^\s*//.\+$')
	if empty(comment)
		execute "normal I//"
	else
		s/\/\///
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

function! FindInCurrentDir()
	let word = expand("<cword>")
	execute 'Ggrep ' . word
endfunction

function! QuickfixGoto()
	let row = line('.')
	execute 'll ' . row
endfunction

"key mappings
let mapleader=','
set timeoutlen=500
""window navigation
nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-w> :call BufferClose()<CR>
nnoremap <silent> <Tab> :wincmd w<CR>
"vimrc stuff
nnoremap <silent> <leader>e :e $MYVIMRC<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
"movements and frequently used keys
inoremap <leader>. <Esc>
vnoremap <leader>. <Esc>
inoremap jj <Esc>
inoremap <Esc> <nop>
nnoremap j gj
nnoremap k gk
nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^
nnoremap Y "+y
vnoremap Y "+y
"nnoremap J Jx
nnoremap ; :
nnoremap [[ [{
nnoremap ]] ]}
nnoremap <silent> {{ :call NextIndent(0)<CR>
nnoremap <silent> }} :call NextIndent(1)<CR>
nnoremap <silent> <CR> :noh<CR>
"text manipulation
nnoremap <C-k> 3<C-y>
nnoremap <C-j> 3<C-e>
"folding
nnoremap <leader>ft Vatzf
nnoremap <leader>ff [{V%zf:noh<CR>
nnoremap <space> za
"search
"nnoremap <C-f> "9yiw /<C-R>9<Enter>
"nnoremap <C-g> "9yiw :vimgrep /<C-R>9/ **\*.*<Enter>
"other
nnoremap <silent> <F1> :NERDTreeToggle<CR>
inoremap <silent> <F1> <Esc>:NERDTreeToggle<CR>a
nnoremap <F3> :call FindInCurrentDir()<CR>
nnoremap <Left> :cp<CR>
nnoremap <Right> :cn<CR>
nmap <Up> <Plug>(ale_previous_wrap)
nmap <Down> <Plug>(ale_next_wrap)

"spelling
"set spell spelllang=en_gb
iab teh the
iab Teh The
iab lenght length
iab weigth weight
iab wieght weight
iab wiegth weight
iab reuqire require
iab requrei require
iab requier require

"conditional remaps
augroup remaps
	autocmd!
	autocmd filetype pug set syntax=pug

	autocmd filetype cshtml set syntax=html
	autocmd filetype html nnoremap <buffer> <C-c> :call ToggleHtmlComment()<CR>
	autocmd filetype html vnoremap <buffer> <C-c> "-c<!--<Esc>o<Esc>cc--><Esc>=="-P
	autocmd filetype html inoremap <S-CR> <br/>

	autocmd filetype xml nnoremap <buffer> <C-c> :call ToggleHtmlComment()<CR>
	autocmd filetype xml vnoremap <buffer> <C-c> "-c<!--<Esc>o<Esc>cc--><Esc>=="-P

	autocmd filetype css nnoremap <buffer> <C-c> :call ToggleCssComment()<CR>
	autocmd filetype less nnoremap <buffer> <C-c> :call ToggleCssComment()<CR>

	autocmd BufReadPost quickfix nnoremap <buffer> <CR> :call QuickfixGoto()<CR>
	autocmd BufReadPost quickfix nnoremap <buffer> q :q<CR>

	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	autocmd filetype javascript nnoremap <buffer> <C-c> :call ToggleJSComment()<CR>
	autocmd filetype javascript vnoremap <buffer> <C-c> "-c/*<Esc>o<Esc>cc*/<Esc>=="-P
	"autocmd filetype javascript inoremap (<CR> (<CR>)O ")
	"autocmd filetype javascript inoremap {<CR> {<CR>}O "}
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
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }

"bookmark settings
let g:bookmark_sign = "\u266b"
let g:bookmark_highlight_lines = 1
"let g:bookmark_no_default_key_mappings = 1
nmap <leader><leader> <Plug>BookmarkToggle
nmap <leader>c <Plug>BookmarkClear
nmap <leader>a <Plug>BookmarkShowAll

"highlights
highlight BookmarkLine guibg=#009900 guifg=#ffffff gui=none
highlight BookmarkSign guibg=NONE guifg=#009900 gui=none
highlight Visual guibg=#ffffff guifg=#000000 gui=none
highlight Folded guibg=NONE guifg=fg gui=none
highlight Pmenu guibg=white guifg=black gui=bold
highlight Search guibg=orange guifg=black gui=bold
highlight MatchParen guibg=green guifg=white gui=none

"ale lint
let g:ale_sign_error = "E"
let g:ale_sign_warning = "W"
let g:ale_lint_on_text_changed = 1
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linter_aliases = {'less': 'css'}
let g:ale_linters = {
			\'javascript': ['jshint', 'eslint'],
			\'less': ['stylelint'],
			\'css': ['stylelint'],
			\'html': ['htmlhint']
			\}

"bookmark settings
let g:bookmark_sign = "\u266b"
let g:bookmark_save_per_working_dir = 0
let g:bookmark_highlight_lines = 1
"let g:bookmark_no_default_key_mappings = 1
nmap <leader><leader> <Plug>BookmarkToggle
nmap <leader>c <Plug>BookmarkClear
nmap <leader>a <Plug>BookmarkShowAll

"javascript conceals
set conceallevel=1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "<"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

"airline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts=1
let g:Powerline_symbols="fancy"

"targets.vim
let g:targets_argOpening = '[(]'
let g:targets_argClosing = '[)]'
