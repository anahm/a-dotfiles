"
" a nahm vimrc
"

set encoding=utf-8
set nocompatible		" must be first line

" Pathogen
filetype on
call pathogen#infect()


" basic viewing stuff
set guifont="Anonymous\ Pro\ 11"
set background=dark
set t_Co=256
colorscheme wombat
set textwidth=80

set ruler
set title
set number
"set relativenumber
set showmatch 					" show matching paren
set showmode
set showcmd

" syntax pretty
syntax enable
filetype plugin indent on
set ttyfast                     " send more chars for redraws

" stuff having to do with tabbing and indenting
set expandtab
set tabstop=4					" tab = 4 spaces
set autoindent
set shiftwidth=4
set smarttab
set softtabstop=4
set shiftround                  " indent/outdent to nearest tabstop

" searching...
set smartcase
set ignorecase
set hlsearch
set incsearch

" highlighting things
highlight OverLength ctermbg=green ctermfg=white guibg=#59292
match OverLength /\%81v.\+/

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Allows for ctags -- awesomeness

set tags=tags;/

" disable backups
set nobackup
set nowritebackup
set noswapfile

" disable annoying beep on errors
set noerrorbells
if has('autocmd')
    autocmd GUIEnter * set vb t_vb=
endif


""""""""""""" keyboard shortcuts """"""""""""

" mapleader = free key to place custom mappings
let mapleader=","

" see http://majutsushi.github.com/tagbar/
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8/bin/ctags'
nnoremap <leader>c :TagbarToggle<CR>
nnoremap <leader>p :set invpaste<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ; > :
nnoremap ; :


