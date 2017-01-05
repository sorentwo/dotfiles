"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" Colors
Plug 'chriskempson/base16-vim'

" Utilities
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'aliou/sql-heredoc.vim', { 'for': 'ruby' }

" Frameworks
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-rails'

filetype plugin indent on

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

nmap <Leader>a= :Tab /=<CR>
vmap <Leader>a= :Tab /=<CR>
nmap <Leader>a: :Tab /:\zs<CR>
vmap <Leader>a: :Tab /:\zs<CR>
map  <Leader>bd :bufdo bd!<CR>
map  <Leader>c :Ack<space>
map  <leader>d :NERDTreeToggle \| :silent NERDTreeMirror<CR>
map  <Leader>r :CtrlP<CR>
map  <Leader>pr orequire 'pry'; binding.pry<ESC>:w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set background=dark
colorscheme base16-default-dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nohlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Speed up vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set notimeout
set ttimeout
set timeoutlen=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use a more logical Y
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change cursor shape between modes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup Preferences
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowritebackup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display Prefrences
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden
set ruler
set copyindent
set number
set numberwidth=5
set showcmd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set listchars=tab:▸\ ,trail:·,eol:¬

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace Highlighting && Deletion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set incsearch
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigate splits more easily
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab completion options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmode=list:longest,list:full
set wildignore+=*/.git/*,*/node_modules/**,*/vendor/ruby/**,*/tmp/*
set complete=.,w,t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2               " always show statusbar
set statusline=
set statusline+=%-10.3n\       " buffer number
set statusline+=%f\            " filename
set statusline+=%h%m%r%w       " status flags
set statusline+=%=             " right align remainder
set statusline+=%-14(%l,%c%V%) " line, character
set statusline+=%<%P           " file position

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Less Annoying Bell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set visualbell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeCaseSensitiveSort = 1
let NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_match_window_reversed = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack - Use Silver Searcher
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby 1.8 -> 1.9 Hash Replacement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:nnoremap <silent> <F10> :%s/\v:(\w+)\s?\=\>/\1:/g<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickfix to Args
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor

  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype & Syntax Coercion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Force hamstache syntax highlighting
au Bufread,BufNewFile *.hamstache set filetype=haml

" Force markdown to hard wrap
au BufRead,BufNewFile *.md setlocal textwidth=80

" Capistrano "recipies" are just Ruby
au Bufread,BufNewFile *.cap set filetype=ruby

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
" remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Functions <F?>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove any trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <silent> <leader>t :w\|:TestFile<CR>
nmap <silent> <leader>T :w\|:TestNearest<CR>
nmap <silent> <leader>a :w\|:TestSuite<CR>
nmap <silent> <leader>l :w\|:TestLast<CR>
nmap <silent> <leader>g :w\|:TestVisit<CR>
let test#strategy="neovim"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup localneomake
  autocmd! BufWritePost * Neomake
augroup END

" Don't tell me to use smartquotes in markdown ok?
let g:neomake_markdown_enabled_makers = []

" Enable full credo verification
let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
function NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'     " Refactoring opportunities
    let type = 'W'
  elseif a:entry.type ==# 'D' " Software design suggestions
    let type = 'I'
  elseif a:entry.type ==# 'W' " Warnings
    let type = 'W'
  elseif a:entry.type ==# 'R' " Readability suggestions
    let type = 'I'
  elseif a:entry.type ==# 'C' " Convention violation
    let type = 'W'
  else
    let type = 'M'            " Everything else is a message
  endif
  let a:entry.type = type
endfunction

let g:neomake_elixir_mycredo_maker = {
  \ 'exe': 'mix',
  \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
  \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
  \ 'postprocess': function('NeomakeCredoErrorType')
  \ }
