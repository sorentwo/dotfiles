set nocompatible

" Pathogen
filetype on " Fixes exit status 1 issue for git
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Colorscheme
syntax on
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Search
set nohlsearch

" Backup Preferences
set nobackup
set nowritebackup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Undo buffers
set history=1000
set undolevels=1000

" Display Incomplete Commands
set showcmd

" Display Prefrences
set hidden
set ruler
set autoindent
set copyindent
set number
set numberwidth=5

" Whitespace
set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set listchars=tab:▸\ ,trail:·,eol:¬

" Whitespace Highlighting && Deletion
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
map <Leader>l :set invhls <CR>
:nnoremap <silent> <F3> :nohl<CR>

" Tab completion options
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set complete=.,w,t

" Status bar
set laststatus=2

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Leader
let mapleader=" "

" Less Annoying Bell
set visualbell

" CommandT
map <Leader>tt :CommandTFlush<CR>
set wildignore+=**/vendor/**,**/bin/*

" NERDTree
map <leader>d :NERDTreeToggle \| :silent NERDTreeMirror<CR>
let NERDTreeCaseSensitiveSort = 1
let NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen = 1

" Tabularize
nmap <Leader>a= :Tab /=<CR>
vmap <Leader>a= :Tab /=<CR>
nmap <Leader>a> :Tab /=><CR>
vmap <Leader>a> :Tab /=><CR>
nmap <Leader>a: :Tab /:\zs<CR>
vmap <Leader>a: :Tab /:\zs<CR>

" Ruby 1.8 -> 1.9 Hash Replacement
:nnoremap <silent> <F6> :%s/\v:(\w+)(\s+)\=\>/\1:\2/g<CR>

" TextObj / Matchit
runtime macros/matchit.vim

" Toggle whitespace invisibles
nmap <leader>l :set list!<CR>

" Use a more logical Y
nmap Y y$
