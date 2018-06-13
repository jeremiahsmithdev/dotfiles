"nice to have
syntax on
" for ctags to work in tagbar plugin
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

set shell=bash
set termguicolors

" keep cursor 8 lines from the top and bottom
set scrolloff=8

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




" toggle gundo?
nnoremap <leader>u :GundoToggle<CR>

nnoremap <leader>t :TagbarToggle<CR>

" highlight last inserted text
nnoremap gV `[v`]

" save session	?
nnoremap <leader>s :mksession<CR>

set nocompatible              " be iMproved, required
filetype off                  " required

"enter maps


" Needed for CLI VIm (Note: ^[0M was created with Ctrl+V Shift+Enter, don't type it directly)
nnoremap ^[0M i<CR><Esc>   

" execute pathogen#infect()

" set the runtime path to include Vundle and initialize
set nocompatible
filetype off
" added above...
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'xolox/vim-misc'

Plugin 'xolox/vim-notes'

Plugin 'apalmer1377/factorus'
" Plugin 'blueyed/vim-diminactive'

" Plugin 'terryma/vim-smooth-scroll'
" Plugin 'joeytwiddle/sexy_scroller.vim'
" :let g:SexyScroller_EasingStyle = 5
" :let g:SexyScroller_ScrollTime = 30
Plugin 'yuttie/comfortable-motion.vim'

noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(30)<CR>
noremap <silent> <ScrollWheelUp> :call comfortable_motion#flick(-30)<CR>
" let g:comfortable_motion_friction = 50.0
" let g:comfortable_motion_air_drag = 2.0

Plugin 'majutsushi/tagbar'
Plugin 'matze/vim-move' 

Plugin 'thinca/vim-quickrun'

" align comments
" Plugin 'Align'


" a better debugger
" Plugin 'Conque-GDB'

Plugin 'gmarik/vundle'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdtree'

" format comments to be lined up neatly
Plugin 'godlygeek/tabular'

"tabs
"Plugin 'jistr/vim-nerdtree-tabs'

" best plugin ever (when it works)
" Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'

" Plugin 'Buffergator'

" move anywhere in three keystrokes
Plugin 'justinmk/vim-sneak'

Plugin 'morhetz/gruvbox'

Plugin 'easymotion/vim-easymotion'

" “Plugin 'altercation/vim-colors-solarized'
			
" install (prerequisite for vebugger)
Plugin 'Shougo/vimproc.vim'

" install (debugger)
Plugin 'idanarye/vim-vebugger'

" install
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'shougo/neocomplete'
" Plugin 'prabirshrestha/asyncomplete.vim'
" if has('nvim')
" 	Plugin 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
" else
" 	Plugin 'Shougo/deoplete.nvim'
" 	Plugin 'roxma/nvim-yarp'
" 	Plugin 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1
"
" set pyxversion=3
" Plugin 'ajh17/vimcompletesme'
" Plugin 'maralla/completor.vim'
" python semantic completion
" let g:completor_python_binary = '/usr/local/lib/python3.6/site-packages'
" C/C++
" let g:completor_clang_binary = '/usr/local/Cellar//completor_clang_binary'
" tab to select completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" tab to trigger completion
" let g:completor_auto_trigger = 0
" inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

" tag manager?
Plugin 'ludovicchabant/vim-gutentags'

" directory statusline...
" Plugin 'ctrlpvim/ctrlp.vim'

" distraction fre environment
Plugin 'junegunn/goyo.vim'

"Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'TimothyYe/vim-tips'

" commenting shortuct
Plugin 'tomtom/tcomment_vim'

" use this for Goyo (theme)
Plugin 'reedes/vim-colors-pencil'

" improved terminal/vim integration
Plugin 'wincent/terminus'
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
Plugin 'vim-airline/vim-airline'

" Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
" enable fzf from homebrew install
set rtp+=/usr/local/opt/fzf


let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'

call vundle#end()            " required
filetype plugin indent on    " required


" backup If you leave a Vim process open in which you've changed file, Vim creates a "backup" file. Then, when you open the file from a different Vim session, Vim knows to complain “at you for trying to edit a file that is already being edited. The "backup" file is created by appending a ~ to the end of the file in the current directory. This can get quite  annoying when browsing around a directory, so I applied the following settings to move backups to the /tmp folder.

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set incsearch           " search as characters are entered (not working?)
set hlsearch            " highlight matches

" All of your Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" MY REMAPPINGS
" nnoremap - mapping for normal mode
" inoremap - mapping for insert mode
" vnoremap - mapping for visual mode
" cnoremap - mapping for command (colon) mode
"
" execute a cpp program
cnoremap runc !./%<<return>
cnoremap tree NERDTree
nnoremap :n<CR> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
cnoremap src source %

" execute a java program (and compile)
cnoremap <D-j> !javac %< <return> !java %<
" nnoremap <buffer><D-j> :exec '!javac %< <return> !java %<' shellescape(@%, 1)<cr>

" execute a python program
" nnoremap <buffer><D-9> :exec '!python3' shellescape(@%, 1)<cr>

" compile / run with auto identify for file type
" autocmd FileType java nnoremap <buffer> 9 :!javac %<.java <return> :!java %<
" autocmd FileType java inoremap <buffer> 9 <esc>:!javac %<.java <return> :!java %<

" autocmd FileType java nnoremap <buffer> - :!javac %<.java <return>
" autocmd FileType java nnoremap <buffer> <CR> :!java %< <return>

" autocmd FileType java nnoremap <buffer> <space> :!javac %<.java <return>
" autocmd FileType java nnoremap <buffer> - :!java %< <return>

autocmd FileType python nnoremap <buffer> 9 :exec '!python3' shellescape(@%, 1)<cr>

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
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" " set statusline += '%F'
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"
" " YCM settings
" let g:ycm_show_diagnostics_ui = 0

" sneak settings
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" disable mouse...
set mouse=

set noswapfile

if has ('win32') || has('win64')
    let &shell='cmd.exe'
endif

cnoremap Tabc Tabularize /\/\/

noremap <CR> <C-W><C-W>

" nnoremap 1 :QuickRun<return>

let g:move_key_modifier = 'C'

map  :source %

" noremap  :open .vimrc
noremap ≥ :open .vimrc<return>

inoremap  System.out.println();<left><left>
inoremap ß System.out.println();<left><left>

imap µ public<space>static<space>void<space>main(String<space>args[])<return><D-[>

noremap <C-a> :source %<return>

" SMOOTHSCROLLING
" Update: I have now pushed this code, refactored somewhat according to the guidelines at :help write-plugin, to a Github repo.

" Using the Keyboard
" Here is what I have in my .vimrc:
" function SmoothScroll(up)
"     if a:up
"         let scrollaction="\<C-y>"
"     else
"         let scrollaction="\<C-e>"
"     endif
"     exec "normal " . scrollaction
"     redraw
"     let counter=1
"     while counter<&scroll
"         let counter+=1
"         sleep 10m
"         redraw
"         exec "normal " . scrollaction
"     endwhile
" endfunction
"
" nnoremap <C-U> :call SmoothScroll(1)<Enter>
" nnoremap <C-D> :call SmoothScroll(0)<Enter>
" inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
" inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i
"
" noremap <silent> <c-e> :call smooth_scroll#down(&scroll/2, 0, 1)<CR>
"
" noremap <silent> <c-y> :call smooth_scroll#up(&scroll/2, 2, 1)<CR>
"
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>

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

"mappings for fzf
nnoremap <C-f> :Files<return>
nnoremap <leader>f :Files<CR>

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
