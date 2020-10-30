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
    let g:fzf_buffers_jump = 0
    let g:fzf_layout = { 'down': '33%' }


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


Plug 'Yggdroot/indentLine'


" Nice theme
Plug 'gruvbox-community/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'liuchengxu/vista.vim'

" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}


call plug#end()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rs <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>caa  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>fi  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>



" ---------------
" VISTA
" ---------------
nmap <leader>vv :Vista!!<CR>
nmap <leader>vf :Vista finder coc<CR>

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'


" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }



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
nnoremap <leader>fc :FZF %:p:h<CR>

nmap <nowait> <leader>rg :Rg<space>
nnoremap <leader>sw :Rg <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>s y:Rg <C-R>"<CR>


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
colorscheme gruvbox
set background=dark

" Signify
highlight SignColumn        ctermbg=237                           guibg=#1c1c1c
highlight SignifySignDelete ctermbg=237 ctermfg=203 guifg=#FF5f5f guibg=#1c1c1c
highlight SignifySignChangeDelete cterm=bold ctermbg=0     ctermfg=1 guifg=#CC0000 gui=bold guibg=#1c1c1c
highlight SignifySignAdd    ctermbg=237 ctermfg=119 guifg=#87ff5f guibg=#1c1c1c
highlight SignifySignChange ctermbg=237 ctermfg=227 guifg=#ffff5f guibg=#1c1c1c

" Diff mode
" highlight DiffAdd    ctermfg=0 ctermbg=119 guibg=#98FB98 guifg=#000000
" highlight DiffDelete ctermfg=0 ctermbg=203 guibg=#FF5f5f guifg=#000000
" highlight DiffChange ctermfg=0 ctermbg=159 guibg=#AFFFFF guifg=#000000
" highlight DiffText   ctermfg=9 ctermbg=81  guibg=#5FD7FF guifg=#FF0000
" highlight VertSplit ctermbg=237
" highlight Folded cterm=bold ctermbg=237 ctermfg=15
" highlight FoldColumn ctermbg=237 ctermfg=15
set fdc=0

" CSV plugin
highlight CSVColumnOdd ctermbg=blue ctermfg=black guifg=Black guibg=#88afff
highlight CSVColumnEven ctermbg=white ctermfg=black guifg=Black guibg=White
highlight CSVColumnHeaderOdd cterm=bold,underline gui=bold,underline ctermbg=blue ctermfg=88 guifg=#870000 guibg=#87afff
highlight CSVColumnHeaderEven cterm=bold,underline gui=bold,underline ctermbg=white ctermfg=88 guifg=#870000 guibg=White

" Markdown
highlight def link markdownCode Delimiter
