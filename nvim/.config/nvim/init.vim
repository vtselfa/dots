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


"Syntax and errors highlighter
Plug 'scrooloose/syntastic'
	let g:syntastic_always_populate_loc_list = 1
	nnoremap <F5> :SyntasticCheck<CR>


" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    let g:fzf_buffers_jump = 1


" Very good autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': 'YCM_CORES=1 python2 ./install.py --clang-completer >build.out 2>build.err &' }
	autocmd FileType python,c,cpp nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
	highlight YcmErrorSection ctermbg=0 ctermfg=9
	highlight YcmWarningSection ctermbg=0 ctermfg=220


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
    let g:airline#extensions#tabline#show_splits = 0
	let g:airline_theme='murmur'
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9

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
	highlight CSVColumnOdd ctermbg=blue ctermfg=black guifg=Black guibg=#88afff
	highlight CSVColumnEven ctermbg=white ctermfg=black guifg=Black guibg=White
	highlight CSVColumnHeaderOdd cterm=bold,underline gui=bold,underline ctermbg=blue ctermfg=88 guifg=#870000 guibg=#87afff
	highlight CSVColumnHeaderEven cterm=bold,underline gui=bold,underline ctermbg=white ctermfg=88 guifg=#870000 guibg=White


" Mark multiple words and all their occurences with different colors
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
" Defines <leader> m,n,r,*,/


" +/- vcs signs
Plug 'mhinz/vim-signify'
	highlight SignColumn guibg=lightgrey ctermbg=237
	highlight SignifySignDelete ctermbg=237 ctermfg=9 guifg=Red guibg=Lightgrey
	highlight SignifySignAdd    ctermbg=237 ctermfg=34
	highlight SignifySignChange ctermbg=237 ctermfg=227 guifg=Blue guibg=Lightgrey
	let g:signify_vcs_list = ['git', 'svn']
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


call plug#end()



" ---------------
" General options
" ---------------

colorscheme desert
set nocompatible	" Be iMproved
if !has('nvim')
	set encoding=utf-8
endif
syntax on			" Sintax highlighting
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
set noswapfile					" Turn off annoying swapfiles
let g:tex_flavor = "latex"		" Always expect LaTeX code (instead of plain TeX code) within .tex files

" Truecolor
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" Indentation
set expandtab
set autoindent		" Maintain indentation level after newline
set tabstop=4		" Tab width
set shiftwidth=4	" How many positions [<] and [>] indent or deindent
set breakindent		" Word wrapping mantaining indentation
set showbreak=....	" What is shown in wrapped lines
set linebreak		" Only wrap at a character in the 'breakat' option

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

" GVim
if has('gui_running')
	" Remove menus
	set guioptions-=T
	set guioptions-=m
endif

" Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Diff mode
highlight DiffAdd    ctermfg=0 ctermbg=119
highlight DiffDelete ctermfg=0 ctermbg=203
highlight DiffChange ctermfg=0 ctermbg=159
highlight DiffText   ctermfg=9 ctermbg=81
hi VertSplit ctermbg=237
hi Folded cterm=bold ctermbg=237 ctermfg=15
hi FoldColumn ctermbg=237 ctermfg=15
set fdc=0



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

" p -> togle paste
nnoremap <leader>p :set paste!<CR>

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
  \ call fzf#run(fzf#wrap('vpfs', {'source': 'rg -t cpp -t py -t sh -t mako -t make -t xml --files $vp_source_dirs'}, <bang>0))

command! -bang -nargs=* VPCS
  \ call fzf#vim#grep(
  \   'rg -t cpp -t py -t sh -t mako -t make --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>).' $vp_source_dirs', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <F6>    :!updatedb --localpaths="$vp_source_dirs" --output=$HOME/.vp_db<CR> 
command! -bang VPFSLocate
   \ call fzf#run(fzf#wrap('vpfslocate', {'source': 'locate -d $HOME/.vp_db '.shellescape(<q-args>) }, <bang>0))


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
map <F8>    :!cleartool co -nc -unr -nmaster -nwa -pti %:p <CR>
map <F9>    :!cleartool ci -nwa -pti %:p <CR>
map <F10>   :!cleartool co -nc %:p:h && cleartool mkelem -ci -pti %:p <CR>
map <F11>   :!cleartool mkelem -ci -pti %:p <CR>
