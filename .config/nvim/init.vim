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


"Syntax and errors highlighter
Plug 'scrooloose/syntastic'
	let g:syntastic_always_populate_loc_list = 1
	nnoremap <F5> :SyntasticCheck<CR>


" Very good autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': 'YCM_CORES=1 python2 ./install.py --clang-completer >build.out 2>build.err &' }
	autocmd FileType python,c,cpp nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
	nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
	nnoremap <leader>jD :YcmCompleter GoToDeclaration<CR>


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
Plug 'bling/vim-airline'
	set laststatus=2
	set noshowmode
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme='murmur'
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline


" Fonts for Airline
Plug 'powerline/fonts', { 'do': './install.sh >install.out 2>install.err &' }


" Sudo
Plug 'chrisbra/SudoEdit.vim'


" Colorize color codes
Plug 'chrisbra/Colorizer'


" CSV
Plug 'chrisbra/csv.vim'
	highlight CSVColumnOdd ctermbg=blue ctermfg=black guifg=Black guibg=#88afff
	highlight CSVColumnEven ctermbg=white ctermfg=black guifg=Black guibg=White
	highlight CSVColumnHeaderOdd cterm=bold,underline gui=bold,underline ctermbg=blue ctermfg=88 guifg=#870000 guibg=#87afff
	highlight CSVColumnHeaderEven cterm=bold,underline gui=bold,underline ctermbg=white ctermfg=88 guifg=#870000 guibg=White


" Mark multiple words and all their occurences with different colors
Plug 'vim-scripts/Mark'
" Defines <leader> m,n,r,*,/


" +/- vcs signs
Plug 'mhinz/vim-signify'
	highlight SignColumn guibg=lightgrey
	highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119 guifg=Green guibg=Lightgrey
	highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167 guifg=Red guibg=Lightgrey
	highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227 guifg=Blue guibg=Lightgrey
	let g:signify_vcs_list = ['git', 'svn']
	let g:signify_sign_change = '~'
	let g:signify_sign_delete_first_line = '‾'


" Enable repeating supported plugin maps
Plug 'tpope/vim-repeat'


Plug 'vim-scripts/visualrepeat'


" Better * command
Plug 'haya14busa/vim-asterisk'
let g:asterisk#keeppos = 1

" Add/modify surroundings " ' [] etc
Plug 'tpope/vim-surround'


call plug#end()

" Mappings for vim-asterisk. They should be after calling plug#end().
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)



" ---------------
" General options
" ---------------

set nocompatible 	" Be iMproved
syntax on			" Sintax highlighting
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching
set ignorecase 		" Ignore case when searching brackets.
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set autoread		" Auto read when a file is changed from the outside
set hidden 			" Hide buffers when they are abandoned
set mouse=a 		" Enable mouse usage (all modes)
set ruler 			" Always show current position in the status bar
set backspace=eol,start,indent 	" Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l			" Configure arrows so they acts as it should act
set mat=2 						" How many tenths of a second to blink when matching brackets
set tabpagemax=50 				" Maximum number of open tabs
set noswapfile 					" Turn off annoying swapfiles
let g:tex_flavor = "latex" 		" Always expect LaTeX code (instead of plain TeX code) within .tex files

" Indentation
set autoindent 		" Maintain indentation level after newline
set tabstop=4		" Tab width
set shiftwidth=4	" How many positions [<] and [>] indent or deindent
set breakindent 	" Word wrapping mantaining indentation
set showbreak=....	" What is shown in wrapped lines
set linebreak 		" Only wrap at a character in the 'breakat' option

" Move Backup Files to ~/.nvim/sessions
silent !mkdir -p ~/.nvim/sessions
set backupdir=~/.nvim/sessions
set dir=~/.nvim/sessions

" Set persistent undo
silent !mkdir -p ~/.nvim/undodir
set undodir=~/.nvim/undodir
set undofile
set undolevels=1000      " use many levels of undo

"Configure wildmenu
set wildmode=longest,list,full
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set history=1000         " remember more commands and search history

" GVim
if has('gui_running')
	" Remove menus
	set guioptions-=T
	set guioptions-=m
endif



" -------------------
" Generic autocomands
" -------------------

"Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Delete trailing whitespaces on source files on write
autocmd FileType c,cpp,java,php,python,tex autocmd BufWritePre <buffer> :%s/\s\+$//e



" ---------------
" Leader mappings
" ---------------

let mapleader = ","

" w -> Toggle word wrapping
nnoremap <leader>w :set wrap!<CR>

" p -> Toggle paste mode
set pastetoggle=<leader>p



" --------
" Functions
" --------



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
