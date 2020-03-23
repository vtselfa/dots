"--------
" VimPlug
"--------

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif



"--------
" Plugins
"--------

call plug#begin('~/.config/nvim/plugged')


" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    let g:fzf_buffers_jump = 1


" A simple, easy-to-use Vim alignment plugin.
Plug 'junegunn/vim-easy-align'
	" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
	vmap <Enter> <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)


" File explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	" Open NERDTree with F3
	noremap <F3> :NERDTreeToggle<CR>


" Git integration
Plug 'tpope/vim-fugitive'


" Automatically follow the symlinks in Vim.
" This means that when you edit a pathname that is a symlink, vim will instead open the file using the resolved target path
Plug 'moll/vim-bbye'
Plug 'aymericbeaumet/vim-symlink'


" List file tags (requires ctags)
Plug 'majutsushi/tagbar'
	" Swow tagsframe with F2
	noremap <F2> :TagbarToggle<CR>
	let g:tagbar_usearrows = 1


" Comment lines
Plug 'tomtom/tcomment_vim'


" Toggle between header and source
Plug 'vim-scripts/a.vim'


" Undo tree
Plug 'sjl/gundo.vim'
	"Show undo tree with F4
	nnoremap <F4> :GundoToggle<CR>


" Airline
Plug 'vim-airline/vim-airline'
	set laststatus=2
	set noshowmode
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_splits = 0
	let g:airline_theme='murmur'
    let g:airline#extensions#tabline#fnamemod = ':t'
    autocmd FileType * unlet! g:airline#extensions#whitespace#checks
    autocmd FileType markdown let g:airline#extensions#whitespace#checks = [ 'indent' ]

" Airline themes
Plug 'vim-airline/vim-airline-themes'


" Fonts for Airline
Plug 'powerline/fonts', { 'do': './install.sh >install.out 2>install.err &' }


" Sudo
Plug 'chrisbra/SudoEdit.vim'


" Colorize color codes
Plug 'chrisbra/Colorizer'


" CSV
Plug 'chrisbra/csv.vim'


" Mark multiple words and all their occurences with different colors
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark' " Defines <leader> m,n,r,*,/


" +/- vcs signs
Plug 'mhinz/vim-signify'
	let g:signify_vcs_list = ['git']
	let g:signify_sign_change = '~'
	let g:signify_sign_delete_first_line = '‾'


" Enable repeating supported plugin maps
Plug 'tpope/vim-repeat'


Plug 'vim-scripts/visualrepeat'


" Add/modify surroundings " ' [] etc
Plug 'tpope/vim-surround'


Plug 'rhysd/vim-clang-format'
	" map to <Leader>cf in C++ code
	autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
	autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


" Vim sugar for the UNIX shell commands that need it the most.
Plug 'tpope/vim-eunuch'


" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'


" Adds automated view session creation/restoration when editing a buffer, across Vim sessions and window life cycles
Plug 'zhimsel/vim-stay'
	set viewoptions=cursor,folds,slash,unix


" Updated cmake syntax
Plug 'pboettch/vim-cmake-syntax'


" Rust support
Plug 'rust-lang/rust.vim'


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

	let g:LanguageClient_serverCommands = {
	  \ 'cpp': ['clangd', '-background-index', '-clang-tidy'],
	  \ 'c': ['clangd', '-background-index', '-clang-tidy'],
      \ 'python': ['/usr/local/bin/pyls'],
      \ 'markdown' : ['common-mark-language-server'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
	  \ }

Plug 'Yggdroot/indentLine'


if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'Shougo/echodoc.vim'
    set cmdheight=1
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'signature'


call plug#end()



" ---------------
" General options
" ---------------

syntax on			" Sintax highlighting
set nocompatible	" Be iMproved
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching
set ignorecase		" Ignore case when searching brackets.
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch
set autowrite		" Automatically save before commands like :next and :make
set autoread		" Auto read when a file is changed from the outside
set hidden			" Hide buffers when they are abandoned
set mouse=a 		" Enable mouse usage (all modes)
set ruler			" Always show current position in the status bar
set backspace=eol,start,indent	" Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l			" Configure arrows so they acts as it should act
set mat=2						" How many tenths of a second to blink when matching brackets
set tabpagemax=50				" Maximum number of open tabs
set guitablabel=%t              " Don't show the path in tabs
set noswapfile					" Turn off annoying swapfiles
let g:tex_flavor = "latex"		" Always expect LaTeX code (instead of plain TeX code) within .tex files

" Indentation
set expandtab
set autoindent		" Maintain indentation level after newline
set tabstop=4		" Tab width
set shiftwidth=4	" How many positions [<] and [>] indent or deindent
set breakindent		" Word wrapping mantaining indentation
set showbreak=....	" What is shown in wrapped lines
set linebreak		" Only wrap at a character in the 'breakat' option

" Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
set foldenable
set foldcolumn=1
let g:markdown_folding=1


" Move Backup Files to ~/.nvim/sessions
silent !mkdir -p ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Set persistent undo
silent !mkdir -p ~/.vim/undodir
set undodir=~/.vim/undodir
set undofile
set undolevels=1000      " use many levels of undo

"Configure wildmenu
set wildmode=longest,list,full
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set history=1000         " remember more commands and search history

" Config for gvim
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
	set guioptions-=T
	set guioptions-=m
endif

" Differences vim/nvim
if !has('nvim')
	set encoding=utf-8
    if exists('$TMUX')
        let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
        let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
    endif
endif


" -------------------
" Generic autocomands
" -------------------

"Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Delete trailing whitespaces on source files on write
autocmd FileType c,cpp,java,php,python,tex,vim,rs autocmd BufWritePre <buffer> :%s/\s\+$//e



" ---------------
" Leader mappings
" ---------------

let mapleader = ","

" w -> Toggle word wrapping
nnoremap <leader>w :set wrap!<CR>

" Copy to system slipboard
noremap <Leader>y "*y

" p -> togle paste
nnoremap <leader>p :set paste!<CR>

" FZF mappings
nnoremap <leader>tt :Windows<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>ff :FZF<CR>

" Code completion mappings
nnoremap <leader>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>rs :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>oh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>fi :call LanguageClient#textDocument_codeAction()<CR>

" Tabclose, next and prev
nnoremap <silent> <Plug>TabClose :tabclose<CR>
    \:call repeat#set("\<Plug>TabClose")<CR>
nmap <leader>tc <Plug>TabClose
nnoremap <silent> <Plug>TabNext :tabnext<CR>
    \:call repeat#set("\<Plug>TabNext")<CR>
nmap <leader>tn <Plug>TabNext
nnoremap <silent> <Plug>TabPrev :tabprev<CR>
    \:call repeat#set("\<Plug>TabPrev")<CR>
nmap <leader>tp <Plug>TabPrev

" Edit macro
nmap <Leader>em :call EditMacro()<CR> <Plug>em

" --------
" Functions
" --------

function! EditMacro()
  call inputsave()
  let g:regToEdit = input('Register to edit: ')
  call inputrestore()
  execute "nnoremap <Plug>em :let @" . eval("g:regToEdit") . "='<C-R><C-R>" . eval("g:regToEdit")
endfunction


" --------
" Mappings
" --------

"Y and D append to "@
nnoremap Y :let @"=@".getline('.')."\n"<CR>
nnoremap D :let @"=@".getline('.')."\n"<CR>"_dd

vnoremap Y :let @"=@".call s:get_selected_text()."\n"<CR>
vnoremap D :let @"=@".s:get_selected_text()."\n"<CR>"_d

" zoom with <c-w>z in any mode
nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
inoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>a
vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv
if has('nvim') && exists(':tnoremap')
	tnoremap <Esc><Esc> <c-\><c-n>
	tnoremap <a-j> <c-\><c-n><c-w>j
	tnoremap <a-k> <c-\><c-n><c-w>k
	tnoremap <a-h> <c-\><c-n><c-w>h
	tnoremap <a-l> <c-\><c-n><c-w>l
	tnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>
endif



"
" Colors
"

" Truecolor
set termguicolors

" Colorscheme
colorscheme desert

" Signify
highlight SignColumn        ctermbg=237                           guibg=#1c1c1c
highlight SignifySignDelete ctermbg=237 ctermfg=203 guifg=#FF5f5f guibg=#1c1c1c
highlight SignifySignChangeDelete cterm=bold ctermbg=0     ctermfg=1 guifg=#CC0000 gui=bold guibg=#1c1c1c
highlight SignifySignAdd    ctermbg=237 ctermfg=119 guifg=#87ff5f guibg=#1c1c1c
highlight SignifySignChange ctermbg=237 ctermfg=227 guifg=#ffff5f guibg=#1c1c1c

" Diff mode
highlight DiffAdd    ctermfg=0 ctermbg=119 guibg=#98FB98 guifg=#000000
highlight DiffDelete ctermfg=0 ctermbg=203 guibg=#FF5f5f guifg=#000000
highlight DiffChange ctermfg=0 ctermbg=159 guibg=#AFFFFF guifg=#000000
highlight DiffText   ctermfg=9 ctermbg=81  guibg=#5FD7FF guifg=#FF0000
highlight VertSplit ctermbg=237
highlight Folded cterm=bold ctermbg=237 ctermfg=15
highlight FoldColumn ctermbg=237 ctermfg=15
set fdc=0

" CSV plugin
highlight CSVColumnOdd ctermbg=blue ctermfg=black guifg=Black guibg=#88afff
highlight CSVColumnEven ctermbg=white ctermfg=black guifg=Black guibg=White
highlight CSVColumnHeaderOdd cterm=bold,underline gui=bold,underline ctermbg=blue ctermfg=88 guifg=#870000 guibg=#87afff
highlight CSVColumnHeaderEven cterm=bold,underline gui=bold,underline ctermbg=white ctermfg=88 guifg=#870000 guibg=White

" Markdown
highlight def link markdownCode Delimiter
