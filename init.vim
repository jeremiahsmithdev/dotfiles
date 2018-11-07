filetype indent on      " load filetype-specific indent files
syntax on " nice to have
let mapleader = ' '
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags' " for tagbar
set shell=bash
set termguicolors
set scrolloff=8 " keep cursor 8 lines from the top and bottom of the screen
set autoread
set autochdir " set working directory to current file
set relativenumber number " hybrid numbering mdoe
set showcmd             " show command in bottom bar
" set cursorline          " highlight current line
set wildmenu            " visual autocompleme for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set title " show file path of current file in window title
set hidden " allow edited buffers to hide
set foldmethod=syntax
set foldlevelstart=999 " 0 is all closed, 1 is some closed
set encoding=UTF-8
set hlsearch " better searches
set incsearch
set ignorecase
set smartcase
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set incsearch           " search as characters are entered (not working?)
set hlsearch            " highlight matches
set clipboard=unnamed
set noswapfile
set showcmd
filetype plugin on

" PLUGINS BEGIN
call plug#begin()
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'	" provides additional text objects e.g. 'cin(' = (and) -> (for)
Plug 'sheerun/vim-polyglot'	" A solic language pack - 'One to rule them all, one to bring them all and in the dark to bind them.
Plug 'takac/vim-hardtime'
Plug 'wellle/visual-split.vim'	" control splits with visual selections or text objects
Plug 'Shougo/neopairs.vim'	" recommended for deoplete
Plug 'Raimondi/delimitMate'	" auto-completion for quotes, parens,brackets, etc.
Plug 'christoomey/vim-conflicted'	" wrapper for fugitive for merging conflicts
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jacoborus/tender.vim'
Plug 'shougo/denite.nvim'
Plug 'shougo/neomru.vim' " browse most recently used files
Plug 'bling/vim-airline'
Plug 'chrisbra/Colorizer' " color hex codes and color names
Plug 'rizzatti/dash.vim'
Plug 'chriskempson/base16-vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " colours for devicons/nerdtree
Plug 'tpope/vim-eunuch' " Unix file operations in vim
Plug 'mbbill/undotree'
Plug 'justinmk/vim-gtfo' " go to terminal or file manager in current directory
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'junegunn/vim-pseudocl' " required for vim-fnr (find and replace), 'a pseudo command line'
Plug 'junegunn/vim-fnr'		" visual find and replace, mapped to <leader>R
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'		" extends '' and @ functionality with a view of register contents
Plug 'junegunn/vim-xmark'		" live markdown preview for Vim on macOS
Plug 'junegunn/vim-slash' " automatically clears highligting after search++
Plug 'mhinz/vim-signify'	" apprarently faster than gitgutter
Plug 'vimwiki/vimwiki'
Plug 'MarcWeber/vim-addon-mw-utils' " needed for snipmate
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'justinmk/vim-sneak' " move anywhere in three keystrokes
Plug 'morhetz/gruvbox'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'junegunn/goyo.vim'
Plug 'TimothyYe/vim-tips'
Plug 'tomtom/tcomment_vim'	" commenting shortcut
Plug 'reedes/vim-colors-pencil'
Plug 'wincent/terminus'		" improved terminal integration
Plug 'davidhalter/jedi-vim'
Plug 'starcraftman/vim-eclim' " Eclipse functionality in the Vim editor
Plug 'junegunn/fzf.vim'		" the best plugin ever invented
Plug 'ryanoasis/vim-devicons'
" TEMPORARILY COMMENTED OUT !!!!!!!!!! DETENTION ZONE
" Plug 'tpope/vim-rhubarb'
" Plug 'lekv/vim-clewn'
" Plug 'shougo/echodoc.vim'
" Plug 'critiqjo/lldb.nvim'
" Plug 'tpope/vim-dispatch'	" testing... TPOPE!
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'koron/minimap-vim'
" Plug 'thinca/vim-ref'
" Plug 'mattn/webapi-vim'
" Plug 'junegunn/limelight.vim'
" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plug 'LucHermitte/vim-refactor'
" Plug 'tomtom/tlib_vim'
" Plug 'idanarye/vim-vebugger'
" Plug 'javipolo/vim'
" Plug 'apalmer1377/factorus'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-notes' " requires vim-misc
" __________ END DETENTION ZONE
call plug#end()            " required
filetype plugin indent on    " required
" PLUGINS END
"
let g:deoplete#enable_at_startup = 1
let g:move_key_modifier = 'A'
"COMPLETION CONFIG
"CLANG completion
silent! set ttymouse=xterm2
set mouse=niv
let g:vebugger_leader='<leader>v'


if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" deoplete tab completion

let g:ale_sign_error = '✗'	" ale settings
let g:ale_sign_warning = '⚠'
" enable fzf from homebrew install
set rtp+=/usr/local/opt/fzf

let g:airline#extensions#show_splits = 1
let g:airline#extensions#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c='%t'
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:EclimFileTypeValidate = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
" numbers tabs
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " enable folder glyph flag
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:gtfo#terminals = { 'mac': 'iterm' }
let g:online_thesaurus_map_keys = 0
let g:vimwiki_folding = 'syntax'
let g:vimwiki_list = [{'path': '~wiki/',
			\ 'syntax': 'markdown', 'ext': '.md'}]
:let g:gruvbox_invert_selection = 0
:let g:gruvbox_termcolors=16
:let g:gruvbox_italic = 1
:let string = 'string'

" test
let g:webdevicons_enable_airline_statusline = 1
let g:DevIconsEnableFolderExtGensionPatternMatching = 1

" enable hard mode
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:hardtime_maxcount = 4
set background=dark
let g:gruvbox_contrast_dark = 'soft'
set nocursorline
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mappingyntax onuuuuuuuuuuuuuauuuuuuuuuuu
colorscheme gruvbox

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_or_target)
cnoremap git !git
nnoremap gb :ls<CR>:buffer<Space>
nnoremap bg <C-z>	" background, escapes to terminal until 'fg' is entered (forground)
noremap <leader>j :JavaDocPreview<CR>
nnoremap <leader>d :OnlineThesaurusCurrentWord<CR>
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" switching buffers
tmap <leader>1 <<C-\><C-n><Plug>AirlineSelectTab1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nnoremap q :q
nnoremap Q :q!
" pane navigation
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-h> <C-w>h
nnoremap <c-l> <C-w>l
nmap <leader>k :nohlsearch<CR>
" nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>
" cnoremap tt TagbarToggle<CR>
nnoremap <leader>t :TagbarOpenAutoClose<CR>
nnoremap gV `[v`] " highlight last inserted text
nnoremap <leader>s :mksession<CR>
nnoremap ^[0M i<CR><Esc>
cnoremap df<CR> :!rm % <CR>:bd<CR>
filetype off
nnoremap \f za
function! AddCommands()
	for commandName in ["One", "Two", "Three"]
		" Adds a command that, when executed, prints its own name
		execute "command! " . commandName . " echom \"" . commandName . "\""
	endfor
endfunction
if has ('win32') || has('win64')
	let &shell='cmd.exe'
endif
" resotres operator pending mode cursor which vim-surround interferes with
let g:surround_no_mappings = 1
function! SurroundOp()
    if v:operator ==# 'd'
        return "\<plug>Dsurround"
    elseif v:operator ==# 'c'
        return "\<plug>Csurround"
    elseif v:operator ==# 'y'
        return "\<plug>Ysurround"
    endif
    return ''
endfunction
omap <expr> s '<esc>'.SurroundOp()
"command! [atribute] ENC <esc>iwritethis
" execute a cpp program
cnoremap runc !./%<<return>
cnoremap tree NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
cnoremap src source %
" execute a java program (and compile)
cnoremap <D-j> !javac %< <return> !java %<
" execute a python program
autocmd FileType python nnoremap <buffer> <leader>r :exec '!python3' shellescape(@%, 1)<cr>
autocmd FileType java nnoremap <expr> write <esc>
" compile / run with auto identify for file type
autocmd FileType java nnoremap <buffer> <leader>c :!javac % <return>
autocmd FileType java nnoremap <buffer> <leader>g :!rm *.class; javac % <return>
autocmd FileType java nnoremap <buffer> <leader>r :!java %< <return>
autocmd FileType java nnoremap <buffer> <leader><leader> :!java %< datafile2.txt <return>
" GO
autocmd FileType go nnoremap <buffer> <leader>r :!go run % <return>
autocmd FileType go nnoremap <buffer> <leader>c :!go build % <return>
" use *cmd-beginning curly bracket* to create both brackets, move inside them
" then indent ready to code
inoremap [[ {<return>}<up><return> " easy method braces
inoremap <D-e> <esc>
" sneak settings
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S
nmap <silent> <leader>e <Plug>(ale_next_wrap)
nnoremap <leader>f :Files<CR>
"  `GFiles [OPTS]`   | Git files ( `git ls-files` )
nnoremap <leader>G :GFiles<CR>
"  `GFiles?`         | Git files ( `git status` )
nnoremap <leader>gs :GFiles?<CR>
"  `Buffers`         | Open buffers
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>C :Commits<CR>
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinEnter * set relativenumber
	autocmd WinLeave * set nocul
	autocmd WinLeave * set norelativenumber
augroup END

autocmd BufWritePost init.vim source %
nmap <leader>k :nohlsearch<CR>

" abbreviations
:abbr ap Appach Web Server
" autocmd FileType java :abbr print System.out.println();<left>
" DOCUMENTATION ACCESS
"PRIMARY - DASH
nnoremap <leader>d :Dash<cr>
nnoremap <leader>D :Dash<cr>
" python NOTE - works in a buffer without this...
autocmd FileType python nnoremap <buffer> K :<C-u>execute "!pydoc " . expand("<cword>")<CR>
" CPP
autocmd FileType cpp nnoremap <buffer> K :<C-u>execute "!cppman " . expand("<cword>")<CR>

syntax on

"airline
" air-line
let g:airline_powerline_fonts = 1

if system('date +%H') > 18
	:let astronomical = '☾'
elseif system('date +%H') < 6
	:let astronomical = '☾ ᶻᶻ'
else
	" colorscheme day
	:let astronomical = '☀'
endif

"sets current directory to directory of current tab
function! OnTabEnter(path)
	if isdirectory(a:path)
		let dirname = a:path
	else
		let dirname = fnamedify(a:path, ":h")
	endif
	execute "tcd ". dirname
endfunction()
" call above function
autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))
" anaglyph vision tranining
highlight Comment ctermbg=Green
highlight Comment ctermbg=DarkGrey
nnoremap <C-J> <C-Y> " drag down
nnoremap <C-K> <C-E> " drag up
cnoremap getset JavaGetSet
