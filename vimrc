
" Be Vimproved!
set nocompatible

" Enable filetype detection, plugins, and indentation:
filetype plugin indent on

" Enable syntax highlighting, but don't clobber existing `:highlight`s:
syntax enable

" Have Vim operate with UTF8, per docs' recommendations:
set encoding=utf-8

" How many `:` commands and search patterns to remember:
set history=1000

" Maximum number of tab pages that can be opened at once:
set tabpagemax=50

" Make a backup before overwriting a file:
set backup
set backupdir=~/.local/share/vim/backups

" Save undo histories for files:
set undofile
set undodir=~/.local/share/vim/undos


""" DISPLAY

colorscheme crasnox

" Show relative line numbers in the left-hand column:
set number
set relativenumber

" Show the line and colum number of the cursor:
set ruler

" Always show the status line:
set laststatus=2

" Show what mode you're in:
set showmode

" Keep cursor away from window margins:
set scrolloff=1
set sidescrolloff=5

" Show as much as possible of the last line of a window:
set display+=lastline

" Display whitespace characters (by default):
set list

" But, when toggled, display whitespace characters as:
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Wrap lines longer than the window width, at word boundaries:
set wrap
set linebreak


""" EDITING

" Allow removal of all textual elements in Insert mode:
set backspace=indent,eol,start

" Do not scan included files for keyword completion
set complete-=i

" Disable <C-A> and <C-X> on octal-looking numbers:
set nrformats-=octal

" Delete comment character when joining commented lines:
set formatoptions+=j

" Time out on partial inputs of mappings and keycodes:
set timeout timeoutlen=500
set ttimeout ttimeoutlen=0

" Make global flag 'g' default for substitute commands like `:s/foo/bar/g`:
set gdefault

" Update buffers if their file changes and they haven't been edited yet:
set autoread


""" WHITESPACE

" Smarter automatic indenting when starting a new line:
set autoindent
set smartindent

" Always insert tabs (and indents) as spaces:
set expandtab

" Insert and delete tabs (or indents) intelligently:
set smarttab

" Number of spaces to use for each indentation step:
set shiftwidth=4


""" NAVIGATION

" `:find` over all files within the current working directory
set path=**

" Enhanced command-line completion:
set wildmenu

" When pressing <Tab> on the wildmenu, autocomplete to the longest common
" string, and if there's more than one match, list them all:
set wildmode=list:full

" File patterns to ignore when autoexpanding file names:
set wildignore+=.git/,.hg/,.svn/
set wildignore+=__pycache__/,*.pyc,.coverage
set wildignore+=target/,deps/,*.o,*.class,_site/,*.dep.mk,*.swp

" Ignore case when completing file paths in the wildmenu:
set wildignorecase

" When switching between buffers, jump to the first open window that contains
" the specified buffer (if there is one):
set switchbuf=useopen

" Allow buffers to be hidden without saving them:
set hidden


""" SEARCHING

" Ignore case for all-lowercase search patterns:
set ignorecase
set smartcase

" Show matches while typing the search pattern:
set incsearch

" Highlight search pattern matches:
set hlsearch

" Use Ag to search with `:grep`:
set grepprg=ag\ --vimgrep\ --follow
set grepformat=%f:%l:%c:%m


""" FILETYPE CUSTOMIZATION

autocmd FileType c
            \ setlocal commentstring=//\ %s
autocmd BufEnter,BufRead *.h
            \ setlocal filetype=c
autocmd Syntax c
            \ syntax keyword cType
                \ schar uchar ushort uint ulong llong ullong ldouble
                \ ord lssize_t |
            \ syntax keyword cConstant LT EQ GT |
            \ syntax keyword cConstant
                \ EADDRNOTAVAIL EAFNOSUPPORT EHOSTUNREACH ENETUNREACH
                \ ENOBUFS ENODATA ENOMSG EOVERFLOW EPROTO
                \ EPROTONOSUPPORT EPROTOTYPE EWOULDBLOCK

autocmd FileType make
            \ setlocal noexpandtab |
            \ setlocal list

autocmd FileType vim
            \ setlocal keywordprg=:help

let g:python_highlight_all = 1
autocmd Syntax python
            \ syntax keyword pythonBuiltinObj self cls

autocmd FileType ruby
            \ setlocal shiftwidth=2
autocmd BufNewFile,BufRead Gemfile,Guardfile
            \ setlocal filetype=ruby

autocmd FileType html
            \ setlocal shiftwidth=2

let g:markdown_fenced_languages = [ 'sh', 'bash=sh', 'c', 'html',
                                  \ 'javascript', 'json', 'python', 'ruby',
                                  \ 'xml' ]


""" MAPPINGS

let mapleader=' '

" Fast way to save the current buffer:
nnoremap S :write<CR>

" Quickly open files by exact paths - useful in smaller directories:
nnoremap <Leader>e :edit<Space>

" Easily open up the quickfix window (grepping, syntastic, etc):
nnoremap <Leader>c :copen<CR>

" Run searches on the cwd recursively:
nnoremap <Leader>g :grep<Space>

" Shortcut to running an external command:
nnoremap <Leader>x :!

" Switch off search highlighting until the next search:
nnoremap <C-L> :nohlsearch<CR>


""" MACROS

" Improved `%` matching:
runtime! macros/matchit.vim


""" PLUGINS

""" Netrw: directory browser

" Hide the banner in directory listings:
let g:netrw_banner=0

" Make the default directory listing tree style:
let g:netrw_liststyle=3

" Open preview windows by verticallly splitting:
let g:netrw_preview=1

" Open new windows from Netrw at this % of the current window:
let g:netrw_winsize=80

" Settings applied to Netrw buffers (adding `relativenumber`):
let g:netrw_bufsettings='nu rnu noma nomod nobl nowrap ro'

" Store netrw bookmarks outside of .vim:
let g:netrw_home='~/.local/share/vim/'

" Initialize with dotfiles hidden (thanks vim-vinegar; `gh` to unhide):
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


"""" Airline: status bar for Vim

" Disable whitespace checking, and the notification:
let g:airline#extensions#whitespace#enabled=0

let g:airline_theme='tomorrow'


"""" Syntastic: live syntax checking
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=2
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

let g:syntastic_c_checkers = ["make"]


""" CtrlP: fuzzy file (and other things) finder
let g:ctrlp_map='<Leader>f'
let g:ctrlp_match_current_file=1
let g:ctrlp_bufname_mod=':.'
let g:ctrlp_bufpath_mod=''

nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>m :CtrlPMRU<CR>


""" Tagbar: a window for showing the current file's tags
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_show_visibility = 0
let g:tagbar_autoshowtag = 1
nnoremap <F8> :TagbarToggle<CR>

