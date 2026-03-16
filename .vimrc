"
" a nahm vimrc
"
set encoding=utf-8
set nocompatible        " must be first line

" vim-plug
" setup on a new machine:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then open vim and run :PlugInstall
call plug#begin('~/.vim/bundle')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

call plug#end()

" basic viewing stuff
set guifont="Anonymous\ Pro\ 11"
set background=dark
set t_Co=256
set textwidth=100
set colorcolumn=101
highlight ColorColumn ctermbg=green guibg=green
au BufEnter * set colorcolumn=101

set ruler
set title
set number
"set relativenumber
set showmatch                   " show matching paren
set showmode
set showcmd
set autochdir

" security issue
:set modelines=0
:set nomodeline

" syntax pretty
syntax enable
filetype plugin indent on
set ttyfast                     " send more chars for redraws

" stuff having to do with tabbing and indenting
" note: edited per ab config
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
au BufWinEnter,BufNewFile * silent tab

set autoindent
set smarttab
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
highlight ExtraWhitespace ctermbg=red guibg=blue
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()



" disable backups
set nobackup
set nowritebackup
set noswapfile

" Adding in file formatting
" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab


""""""""""""" keyboard shortcuts """"""""""""
" faster tab navigation
nnoremap <S-tab> :tabprevious<CR>
nnoremap <tab> :tabnext<CR>

" mapleader = free key to place custom mappings
let mapleader=","

nnoremap <leader>f :let @" = expand('%')<CR>
nnoremap <leader>l :NERDTreeToggle<CR>
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>p :set invpaste<CR>
nnoremap <leader>rf :w<CR>:!ruff format %<CR><CR>
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

" faster ctrl-p search
"Only refreshes results every 100ms, so if type fast searches don't pile up
let g:ctrlp_lazy_update = 100
let g:ctrlp_user_command = 'find %s -type f | egrep -iv "(\.(eot|gif|gz|ico|jpg|jpeg|otf|png|psd|pyc|svg|ttf|woff|zip|build|deploy)$)|(/\.)|((^|\/)tmp\/|node_modules)"' "Quicker indexing"


