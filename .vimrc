"
" a nahm vimrc
"
set encoding=utf-8
set nocompatible        " must be first line

" vundle
filetype off 
set rtp+=~/.vim/autoload/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" plug-ins
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/trailing-whitespace'

" syntax files
Bundle 'tpope/vim-markdown'

" color schemes
Bundle 'nanotech/jellybeans.vim'
Bundle 'tomasr/molokai'
Bundle 'vim-scripts/Skittles-Dark'
Bundle 'vim-scripts/wombat256.vim'
Bundle 'wgibbs/vim-irblack'

" basic viewing stuff
set guifont="Anonymous\ Pro\ 11"
set background=dark
set t_Co=256
" colorscheme wombat256
set textwidth=80

set ruler
set title
set number
"set relativenumber
set showmatch                   " show matching paren
set showmode
set showcmd

" syntax pretty
syntax enable
filetype plugin indent on
set ttyfast                     " send more chars for redraws

" stuff having to do with tabbing and indenting
set expandtab
set tabstop=4                   " tab = 4 spaces
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
" highlight OverLength ctermbg=green ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/


" Trailing whitespace
" highlight ExtraWhitespace ctermbg=red guibg=red
" au ColorScheme * highlight ExtraWhitespace guibg=red
" au BufEnter * match ExtraWhitespace /\s\+$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhiteSpace /\s\+$/

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
" faster tab navigation
nnoremap <S-tab> :tabprevious<CR>
nnoremap <tab> :tabnext<CR>

" mapleader = free key to place custom mappings
let mapleader=","

" see http://majutsushi.github.com/tagbar/
" let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8/bin/ctags'
nnoremap <leader>b :MRU<CR>
nnoremap <leader>c :TagbarToggle<CR>
nnoremap <leader>f :let @" = expand('%')<CR>
nnoremap <leader>l :NERDTreeToggle<CR>
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>p :set invpaste<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>w :tabclose<CR>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ; > :
nnoremap ; :

" Autocomplete.
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o,*.pyc,*.aux,*.cmi,*.cmo,*.cmx
set completeopt=menu,preview

" make copy/pasting nice
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=r
        set nonu
    else
        set mouse=a
        set nu
    endif
endfunction
nnoremap <leader>m :call ToggleMouse()<CR>

