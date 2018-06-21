"nice to have
syntax on
let mapleader = ' '
" for ctags to work in tagbar plugin
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

set shell=bash
set termguicolors

" keep cursor 8 lines from the top and bottom
set scrolloff=8
set autoread
" set working directory to current file
set autochdir

" set number

" hybrid numbering mode
set relativenumber number
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocompleme for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
"show file path of currentf file in window title
set title
" allow edited buffers to hide
set hidden

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"quit a document without saving
cnoremap qq q!

" better searches
set hlsearch
set incsearch
set ignorecase
set smartcase
"clear highlights
nmap <leader>kk :nohlsearch<CR>

" toggle gundo?
nnoremap <leader>u :GundoToggle<CR>

cnoremap tt TagbarToggle<CR>
nnoremap <leader>t :TagbarOpenAutoClose<CR>

" highlight last inserted text
nnoremap gV `[v`]

" save session	?
nnoremap <leader>s :mksession<CR>
set nocompatible              " be iMproved, required
" filetype off                  " required
filetype plugin on

"enter maps


" Needed for CLI VIm (Note: ^[0M was created with Ctrl+V Shift+Enter, don't type it directly)
nnoremap ^[0M i<CR><Esc>   

cnoremap df :!rm % <CR>:bd<CR>

" execute pathogen#infect()

set nocompatible
filetype off
" added above...

" begin plugin management
call plug#begin()

" Unix file operations in vim file context
Plug 'tpope/vim-eunuch'

Plug 'vimwiki/vimwiki'

" To use Markdown's wiki markup:
let g:vimwiki_list = [{'path': '~wiki/',
			\ 'syntax': 'markdown', 'ext': '.md'}]


" normal mode:

" <Leader>ww -- Open default wiki index file.
" <Leader>wt -- Open default wiki index file in a new tab.
" <Leader>ws -- Select and open wiki index file.
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
Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'

  " Optional:
  Plug 'honza/vim-snippets'

Plug 'LucHermitte/vim-refactor'

Plug 'tpope/vim-surround'

Plug 'xolox/vim-misc'

Plug 'xolox/vim-notes'

Plug 'apalmer1377/factorus'
" Plug 'blueyed/vim-diminactive'

" Plug 'terryma/vim-smooth-scroll'
" Plug 'joeytwiddle/sexy_scroller.vim'
" :let g:SexyScroller_EasingStyle = 5
" :let g:SexyScroller_ScrollTime = 30
Plug 'yuttie/comfortable-motion.vim'

noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(30)<CR>
noremap <silent> <ScrollWheelUp> :call comfortable_motion#flick(-30)<CR>
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0

Plug 'majutsushi/tagbar'
Plug 'matze/vim-move' 

" Plug 'thinca/vim-quickrun'

" align comments
" Plug 'Align'


" a better debugger
" Plug 'Conque-GDB'

" The following are examples of different formats supported.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
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

" Plug 'Buffergator'

" move anywhere in three keystrokes
Plug 'justinmk/vim-sneak'

Plug 'morhetz/gruvbox'

" Plug 'easymotion/vim-easymotion'

" “Plug 'altercation/vim-colors-solarized'
			
" install (prerequisite for vebugger)
Plug 'Shougo/vimproc.vim'

" install (debugger)
Plug 'idanarye/vim-vebugger'

" install
" Plug 'Valloric/YouCompleteMe'
" Plug 'shougo/neocomplete'
" Plug 'prabirshrestha/asyncomplete.vim'
" if has('nvim')
" 	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugs' }
" else
" 	Plug 'Shougo/deoplete.nvim'
" 	Plug 'roxma/nvim-yarp'
" 	Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1
"
" set pyxversion=3
" Plug 'ajh17/vimcompletesme'
" python semantic completion
let g:completor_python_binary = '/usr/local/lib/python3.6/site-packages'
" C/C++
let g:completor_clang_binary = '/usr/local/Cellar//completor_clang_binary'
" tab to select completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" tab to trigger completion
let g:completor_auto_trigger = 0
Plug 'maralla/completor.vim'

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

" statusline
Plug 'vim-airline/vim-airline'

" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
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

" MY REMAPPINGS
" nnoremap - mapping for normal mode
" inoremap - mapping for insert mode
" vnoremap - mapping for visual mode

" cnoremap - mapping for command (colon) mode
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;

function! AddCommands()

  for commandName in ["One", "Two", "Three"]
    " Adds a command that, when executed, prints its own name
    execute "command! " . commandName . " echom \"" . commandName . "\""
  endfor

endfunction

" Factorus bindings
cnoremap getset FEncapsulate
"command! [atribute] ENC <esc>iwritethis
" "
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
" Disable Arrow keys in Escape mode
" 
" map <up> <NOP>
" map <down> <NOP>
" map <left> <NOP>
" map <right> <NOP>
"
" Disable Arrow keys in Insert mode
imap <up> <NOP>
imap <down> <NOP> 
imap <left> <NOP>

" sneak settings
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" nmap f <Plug>SneakLabel_s
" nmap F <Plug>>SneakLabel_S

" disable mouse...
set mouse=
" enable clipboard to work with outer os
" not yet working as I have not yet compiled vim with the keyboard
set clipboard=unnamedplus

set noswapfile

if has ('win32') || has('win64')
    let &shell='cmd.exe'
endif

cnoremap Tabc Tabularize /\/\/

noremap <CR> <C-W><C-W>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" nnoremap 1 :QuickRun<return>

let g:move_key_modifier = 'C'

map  :source %

" noremap  :open .vimrc
" open my vimrc from normal mode
nnoremap ≥ :e ~/.vimrc<CR>
nnoremap <leader>. :e ~/.vimrc<CR>

inoremap  System.out.println();<left><left>
inoremap ß System.out.println();<left><left>

imap µ public<space>static<space>void<space>main(String<space>args[])<return><D-[>

noremap <C-a> :source %<return>


" toggle modes on startup to fix cursor appearance
autocmd VimEnter * execute "normal :startinsert"

" Cycle between buffers
noremap <C-h> :bp <return>
noremap <C-l> :bn <return>

set background=dark
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

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
