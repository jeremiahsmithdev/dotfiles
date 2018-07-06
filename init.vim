edit
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
set cursorline          " highlight current line
set wildmenu            " visual autocompleme for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set title " show file path of current file in window title
set hidden " allow edited buffers to hide
set foldmethod=syntax
set foldlevelstart=1 " 0 is all closed, 1 is some closed
set encoding=UTF-8
filetype plugin on
set hlsearch " better searches
set incsearch
set ignorecase
set smartcase
set nocompatible
set ttyfast
" TEST
set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto

" change option codes to vim alt codes for remapping
" execute "set <A-.>=\e."
" execute "set <A-j>=\ej"
" execute "set <A-k>=\ek"
nnoremap <A-.> :e ~/.vimrc<cr>
"clear highlights


" PLUGINS
call plug#begin()
" statusline
" Plug 'vim-airline/vim-airline' cursor shape, pasting, mouse support etc
"something to do witn interfaecs?
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jacoborus/tender.vim'
Plug 'shougo/denite.nvim'
Plug 'shougo/echodoc.vim'
Plug 'shougo/neomru.vim' " browse most recently used files
Plug 'bling/vim-airline'
" numbers tabs
let g:airline#extensions#tabline#buffer_idx_mode = 1
" Plug 'teddywing/auditory.vim'
Plug 'rizzatti/dash.vim'
Plug 'koron/minimap-vim'
Plug 'thinca/vim-ref'
Plug 'chriskempson/base16-vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " colours for devicons/nerdtree
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
Plug 'tpope/vim-eunuch' " Unix file operations in vim
Plug 'vim-scripts/Gundo' " requires python2...
" Plug 'ervandew/supertab'
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " enable folder glyph flag
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
Plug 'justinmk/vim-gtfo' " go to terminal or file manager in current directory
let g:gtfo#terminals = { 'mac': 'iterm' }
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'beloglazov/vim-online-thesaurus'
let g:online_thesaurus_map_keys = 0
nnoremap <leader>d :OnlineThesaurusCurrentWord<CR>
Plug 'junegunn/vim-pseudocl' " ?
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-easy-align'
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"Normal mode
" <Leader>r<Movement> - Substitution in the range
" <Leader>R - Substitution of the word under the cursor in the entire document
" Visual mode
" <Leader>r - Substitution in the selected range
" <Leader>R - Substitution of the selected string in the entire document
" Command line
" :<Range>FNR
Plug 'junegunn/vim-peekaboo'
" lug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-slash' " automatically clears highligting after search++
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
let g:vimwiki_folding = 'syntax'
" To use Markdown's wiki markup:
let g:vimwiki_list = [{'path': '~vimwiki/',
			\ 'syntax': 'markdown', 'ext': '.md'}]


" normal mode:

" <Leader>ww -- Open default wiki index file.
" <Leader>wt -- Open default wiki index file in a new tab.
" <Leader>wd -- Delete wiki file you are in.
" <Leader>wr -- Rename wiki file you are in.
" <Enter> -- Follow/Create wiki link
" <Shift-Enter> -- Split and follow/create wiki link
" <Ctrl-Enter> -- Vertical split and follow/create wiki link
" <Backspace> -- Go back to parent(previous) wiki link
" <Tab> -- Find next wiki link
" <Shift-Tab> -- Find previous wiki link
" For more keys, see :h vimwiki-mappings

" Commands
" :Vimwiki2HTML -- Convert current wiki link to HTML
" :VimwikiAll2HTML -- Convert all your wiki links to HTML
" :help vimwiki-commands -- list all commands
"snipmate
silent! set ttymouse=xterm2
set mouse=niv
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
  " Optional:
Plug 'honza/vim-snippets'
Plug 'LucHermitte/vim-refactor'
" Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'apalmer1377/factorus'
Plug 'terryma/vim-smooth-scroll'
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

nnoremap <silent> <ScrollWheelDown> :call smooth_scroll#down(&scroll, 0, 1)<CR>
nnoremap <silent> <ScrollWheelUp> :call smooth_scroll#up(&scroll, 0, 1)<CR>
" Plug 'yuttie/comfortable-motion.vim' "SCROLLING
" noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(60)<CR>
" noremap <silent> <ScrollWheelUp> :call comfortable_motion#flick(-60)<CR>
" let g:comfortable_motion_friction = 200.0
" let g:comfortable_motion_air_drag = 5.0
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move' 
" Plug 'Conque-GDB'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plug 'L9'
" Git plugin not hosted on GitHub
" Plug 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'scrooloose/nerdtree'

" format comments to be lined up neatly
Plug 'godlygeek/tabular'

"tabs
"Plug 'jistr/vim-nerdtree-tabs'

" best plugin ever (when it works)
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Plug 'Buffergator'

" move anywhere in three keystrokes
Plug 'justinmk/vim-sneak'

Plug 'morhetz/gruvbox'

" Plug 'easymotion/vim-easymotion'

" “Plug 'altercation/vim-colors-solarized'
			
" install (prerequisite for vebugger)
" Plug 'Shougo/vimproc.vim'

" install (debugger)
Plug 'idanarye/vim-vebugger'


" let g:completor_python_binary = '/usr/local/lib/python3.6/site-packages'
" C/C++
" let g:completor_clang_binary = '/usr/local/Cellar//completor_clang_binary'
" tab to select completion
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" tab to trigger completion
" let g:completor_auto_trigger = 0
" Plug 'maralla/completor.vim'
"
" TODO
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_or_target)
"
"COMPLETION
Plug 'artur-shaik/vim-javacomplete2'
" Plug 'ervandew/supertab'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"COMPLETION CONFIG
"CLANG completion
Plug 'zchee/deoplete-clang'
" deoplete tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" PYTHON
Plug 'zchee/deoplete-jedi'
" tag manager?
Plug 'ludovicchabant/vim-gutentags'

" directory statusline...
" Plug 'ctrlpvim/ctrlp.vim'

" distraction fre environment
Plug 'junegunn/goyo.vim'

"Plug 'nathanaelkane/vim-indent-guides'

Plug 'TimothyYe/vim-tips'

" commenting shortuct
Plug 'tomtom/tcomment_vim'

" use this for Goyo (theme)
Plug 'reedes/vim-colors-pencil'

" improved terminal/vim integration
Plug 'wincent/terminus'

"PYTHON
"TODO
" Plug 'davidhalter/jedi-vim'
" python IDE mode...

"debugging... try comment out if python ide problem...
" function! s:goyo_enter()
" 	colorscheme pencil
" endfunction
"
" function! s:goyo_leave()
" 	colorscheme gruvbox
" endfunction
"
" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoEnter nested call <SID>goyo_leave()

" for skipping to a word in a file


" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
" enable fzf from homebrew install
set rtp+=/usr/local/opt/fzf

let g:airline#extensions#show_splits = 1
let g:airline#extensions#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c='%t'
let g:airline#extensions#tabline#fnamemod = ':p:.'
"
nnoremap gb :ls<CR>:buffer<Space>

call plug#end()            " required
filetype plugin indent on    " required


" backup If you leave a Vim process open in which you've changed file, Vim creates a "backup" file. Then, when you open the file from a different Vim session, Vim knows to complain “at you for trying to edit a file that is already being edited. The "backup" file is created by appending a ~ to the end of the file in the current directory. This can get quite  annoying when browsing around a directory, so I applied the following settings to move backups to the /tmp folder.

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set incsearch           " search as characters are entered (not working?)
set hlsearch            " highlight matches

" All of your Plugs must be added before the following line
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line

let g:move_key_modifier = 'A'
" REMAPPINGS
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
" vnoremap : ;
" window pane movement using alt/option
"exit, until I learn how to use macros...
nnoremap q :q
" and ex mode...
nnoremap Q :q!
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-h> <C-w>h
nnoremap <c-l> <C-w>l
nmap <leader>k :nohlsearch<CR>
cnoremap qq q!
nnoremap <leader>u :GundoToggle<CR>
" cnoremap tt TagbarToggle<CR>
nnoremap <leader>t :TagbarOpenAutoClose<CR>
nnoremap gV `[v`] " highlight last inserted text
nnoremap <leader>s :mksession<CR>
nnoremap ^[0M i<CR><Esc>   
cnoremap df :!rm % <CR>:bd<CR>
filetype off
nnoremap \f za
function! AddCommands()
  for commandName in ["One", "Two", "Three"]
    " Adds a command that, when executed, prints its own name
    execute "command! " . commandName . " echom \"" . commandName . "\""
  endfor
endfunction
" Factorus bindings
cnoremap getset FEncapsulate 
"command! [atribute] ENC <esc>iwritethis
" execute a cpp program
cnoremap runc !./%<<return>
cnoremap tree NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
cnoremap src source %
" execute a java program (and compile)
cnoremap <D-j> !javac %< <return> !java %<
" nnoremap <buffer><D-j> :exec '!javac %< <return> !java %<' shellescape(@%, 1)<cr>
" execute a python program
" nnoremap <buffer><D-9> :exec '!python3' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <leader>r :exec '!python3' shellescape(@%, 1)<cr>
" ?
autocmd FileType java nnoremap <expr> write <esc>
" compile / run with auto identify for file type
" autocmd FileType java nnoremap <buffer> 9 :!javac %<.java <return> :!java %<
" autocmd FileType java inoremap <buffer> 9 <esc>:!javac %<.java <return> :!java %<
autocmd FileType java nnoremap <buffer> <leader>c :!javac %<.java <return>
autocmd FileType java nnoremap <buffer> <leader>r :!java %< <return>
" autocmd FileType java nnoremap <buffer> <space> :!javac %<.java <return>
" autocmd FileType java nnoremap <buffer> - :!java %< <return>
" use *cmd-beginning curly bracket* to create both brackets, move inside them
" then indent ready to code
inoremap [[ {<return>}<up><return>
inoremap <D-e> <esc>
"example command to remap editor commands
":command W w
"
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>
imap <up> <NOP>
imap <down> <NOP> 
imap <left> <NOP>
" sneak settings
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S
" nmap f <Plug>SneakLabel_s
" nmap F <Plug>>SneakLabel_S
" mouse
" enable clipboard to work with outer os
" not yet working as I have not yet compiled vim with the keyboard
set clipboard=unnamed
set noswapfile

if has ('win32') || has('win64')
    let &shell='cmd.exe'
endif

cnoremap align Tabularize /\/\/

" Cycle between panes
noremap <CR> <C-W><C-W>
" Cycle between buffers
noremap <C-p> :bp <return>
noremap <C-n> :bn <return>
" overrides jump to tag?
" nnoremap <c-[> :bp<cr>
" nnoremap <c-]> :bn<cr>
" nnoremap 1 :QuickRun<return>


map  :source %

" noremap  :open .vimrc
" open my vimrc from normal mode
nnoremap <A-.> ~/.vimrc<cr>
nnoremap <leader>. :e ~/.config/nvim/init.vim<CR>

inoremap  System.out.println();<left><left>
inoremap ß System.out.println();<left><left>

imap µ public<space>static<space>void<space>main(String<space>args[])<return><D-[>

noremap <C-a> :source %<return>


" toggle modes on startup to fix cursor appearance
autocmd VimEnter * execute "normal :startinsert"

" no change..
" :let g:gruvbox_number_column = 
" :let g:gruvbox_sign_column = 'green'
" :let g:gruvbox_color_column = 'green'
" :let gruvbox_vert_split = 'bg3'
" :let g:gruvbox_invert_signs = 1
" :let g:gruvbox_invert_tabline = 1
" :let g:gruvbox_improved_strings = 1
" :let g:gruvbox_improved_warnings = 1
" :let g:gruvbox_guisp_fallback = 'fg'
:let g:gruvbox_invert_selection = 0
:let g:gruvbox_termcolors=16
:let g:gruvbox_italic = 1
set background=dark
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
" colorscheme tender

"leader b is taken by buffergator...
" nmap <silent> <leader>b <Plug>(ale_previous_wrap) 
nmap <silent> <leader>e <Plug>(ale_next_wrap)


" fzf-vim-commands 
" -----------------+-----------------------------------------------------------------------
" Command          | List                                                                  ~
" -----------------+-----------------------------------------------------------------------
"  `Files [PATH]`    | Files (similar to  `:FZF` )
nnoremap <leader>f :Files<CR>
"  `GFiles [OPTS]`   | Git files ( `git ls-files` )
nnoremap <leader>G :GFiles<CR>
"  `GFiles?`         | Git files ( `git status` )
nnoremap <leader>gs :GFiles?<CR>
"  `Buffers`         | Open buffers
nnoremap <leader>b :Buffers<CR>
"  `Colors`          | Color schemes
"  `Ag [PATTERN]`    | {ag}{6} search result ( `ALT-A`  to select all,  `ALT-D`  to deselect all)
"  `Lines [QUERY]`   | Lines in loaded buffers
nnoremap <leader>l :Lines<CR>
"  `BLines [QUERY]`  | Lines in the current buffer
"  `Tags [QUERY]`    | Tags in the project ( `ctags -R` )
nnoremap <leader>T :Tags<CR>
"  `BTags [QUERY]`   | Tags in the current buffer
"  `Marks`           | Marks
"  `Windows`         | Windows
"  `Locate PATTERN`  |  `locate`  command output
"  `History`         |  `v:oldfiles`  and open buffers
nnoremap <leader>h :History<CR>
"  `History:`        | Command history
"  `History/`        | Search history
"  `Snippets`        | Snippets ({UltiSnips}{7})
"  `Commits`         | Git commits (requires {fugitive.vim}{8})
nnoremap <leader>C :Commits<CR>
"  `BCommits`        | Git commits for the current buffer
" nnoremap <leader>C :BCommits<CR>
"  `Commands`        | Commands
"  `Maps`            | Normal mode mappings
"  `Helptags`        | Help tags [1]
"  `Filetypes`       | File types
" -----------------+-----------------------------------------------------------------------

set showcmd

" cursorline highlights active window
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinEnter * set relativenumber
	autocmd WinLeave * set nocul
	autocmd WinLeave * set norelativenumber
augroup END


" source .vimrc after every change
autocmd BufWritePost .vimrc source %

nmap <leader>k :nohlsearch<CR>

" abbreviations
:abbr ap Appach Web Server
autocmd FileType java :abbr print System.out.println();<left>
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

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


if system('date +%H') > 18
	:let astronomical = '☾'
elseif system('date +%H') < 6
	:let astronomical = '☾ ᶻᶻ'
else
    " colorscheme day
    :let astronomical = '☀'
endif
:let string = 'string'

" :let g:airline_section_b = '%{strftime("\"%I:%M:%S\ \%p,\ %a,\ %b,\ %d,\ %Y\:%H:%M")}'
" my airline clock
:let g:airline_section_c = '%t  %{strftime("✈  %a
			\ \%I:%M%p  ")}' . astronomical . '  ☁ '

" SNIPPETS
" /**
"  * * 
"  *  * ComparePoly.cpp – Assignment1
"  *   * @author: Jeremiah Smith
"  *    * @student Number: c3238179
"  *     * @version: 24/03/2018
"  *      * Description: stores all current movies in the system and the methods to access their details
"  *       */

" /**
"  * * 
"  *  * fileName - projectName
"  *   * @author: Jeremiah Smith
"  *    * @student Number: c3238179
"  *     * @version: /2018
"  *      * Description: 
"  *       */
" Plug 'reedes/vim-wheel'
" let g:wheel#map#up   = '<c-u>'
" let g:wheel#map#down = '<c-d>'

" test
let g:webdevicons_enable_airline_statusline = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

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

