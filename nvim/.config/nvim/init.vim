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


" Snippets engine
Plug 'SirVer/ultisnips'
    let g:UltiSnipsEditSplit="vertical"


" Snippets are separated from the engine
Plug 'honza/vim-snippets'


" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
    let g:fzf_buffers_jump = 1
    set rtp+=~/bin


" Very good autocompletion
Plug 'Valloric/YouCompleteMe'
	autocmd FileType python,c,cpp nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
    let g:ycm_always_populate_location_list = 1
    let g:ycm_max_diagnostics_to_display = 150


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
Plug 'vim-airline/vim-airline'
	set laststatus=2
	set noshowmode
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_splits = 0
	let g:airline_theme='murmur'


" Airline themes
Plug 'vim-airline/vim-airline-themes'


" Fonts for Airline
Plug 'powerline/fonts'


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
	let g:signify_sign_change = '!'
	let g:signify_sign_add = '✚'
	let g:signify_sign_delete = '▁'
	let g:signify_sign_delete_first_line = '▔'


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
set foldcolumn=0

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
else
    let g:python_host_prog = "/usr/intel/bin/python2.7.15"
    let g:python3_host_prog = "/usr/intel/bin/python3.6.3a"
endif



" -------------------
" Generic autocomands
" -------------------

"Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Delete trailing whitespaces on source files on write
autocmd FileType c,cpp,java,php,python,tex,vim autocmd BufWritePre <buffer> :%s/\s\+$//e



" ---------------
" Leader mappings
" ---------------

let mapleader = ","

" w -> Toggle word wrapping
nnoremap <leader>w :set wrap!<CR>

" p -> togle paste
nnoremap <leader>p :set paste!<CR>

" FZF mappings
nnoremap <leader>tt :Windows<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>ffff :VPFS<CR>
nnoremap <leader>fff :VPFSLocate<CR>

" Youcompleteme mappings
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gD :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <Plug>FixIt :YcmCompleter FixIt<CR>
    \:call repeat#set("\<Plug>FixIt")<CR>
nmap <leader>fi <Plug>FixIt

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

command! -bang VPFS
  \ call fzf#run(fzf#wrap('vpfs', {'source': 'rg -t cpp -t py -t sh -t mako -t make --files . $VP_SRC_DIRS'}, <bang>0))

command! -bang -nargs=* VPCS
  \ call fzf#vim#grep(
  \   'rg -t cpp -t py -t sh -t mako -t make --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>).' $VP_SRC_DIRS', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <F6>    :!updatedb --localpaths="$VP_SRC_DIRS" --output=$HOME/.vp.$SUBPROJECTNAME.$WORKSPACEID.db <CR>
command! -bang VPFSLocate
   \ call fzf#run(fzf#wrap('vpfslocate', {'source': 'locate -d $HOME/.vp.$SUBPROJECTNAME.$WORKSPACEID.db '.shellescape(<q-args>) }, <bang>0))


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
" Clearshit mappings
"

map <F7>    :!cleartool unco %:p <CR>
map <F8>    :set noreadonly <CR> :!cleartool co -nc -unr -nmaster -nwa -pti %:p <CR>
map <F9>    :!cleartool ci -nwa -pti %:p <CR>
map <F10>   :!cleartool co -nc %:p:h && cleartool mkelem -comment "FCC" -ci -pti %:p <CR>
map <F11>   :!cleartool mkelem -comment "FCC" -ci -pti %:p <CR>


"
" Colors
"

" Truecolor
set termguicolors

" Colorscheme
colorscheme desert

" Signify
highlight SignColumn              guibg=#1c1c1c ctermbg=0
highlight SignifySignDelete       cterm=bold ctermbg=0     ctermfg=1 guifg=#CC0000 gui=bold guibg=#1c1c1c
highlight SignifySignChangeDelete cterm=bold ctermbg=0     ctermfg=1 guifg=#CC0000 gui=bold guibg=#1c1c1c
highlight SignifySignAdd          cterm=bold ctermbg=0     ctermfg=2 guifg=#00FF00 gui=bold guibg=#1c1c1c
highlight SignifySignChange       cterm=bold ctermbg=0     ctermfg=3 guifg=#fbff00 gui=bold guibg=#1c1c1c

" Diff mode
highlight DiffAdd    ctermfg=0   ctermbg=149 guibg=#acc267 guifg=Black
highlight DiffDelete ctermfg=211 ctermbg=211 guibg=#fb9fb1 guifg=#fb9fb1 gui=None
highlight DiffChange ctermfg=0   ctermbg=153 guibg=#b5dff6 guifg=Black
highlight DiffText   ctermfg=1   ctermbg=81  guibg=#72D5FE guifg=#CC0000 cterm=None gui=None
highlight VertSplit  ctermbg=237
highlight Folded     ctermbg=237 ctermfg=15 cterm=bold
highlight FoldColumn ctermbg=237 ctermfg=15

" YouCompleteMe
highlight YcmErrorSection ctermbg=0 ctermfg=9
highlight YcmWarningSection ctermbg=0 ctermfg=220

" CSV plugin
highlight CSVColumnOdd ctermbg=blue ctermfg=black guifg=Black guibg=#88afff
highlight CSVColumnEven ctermbg=white ctermfg=black guifg=Black guibg=White
highlight CSVColumnHeaderOdd cterm=bold,underline gui=bold,underline ctermbg=blue ctermfg=88 guifg=#870000 guibg=#87afff
highlight CSVColumnHeaderEven cterm=bold,underline gui=bold,underline ctermbg=white ctermfg=88 guifg=#870000 guibg=White
