"
" a nahm vimrc
"
set encoding=utf-8
set nocompatible        " must be first line

" vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'gmarik/vundle'
" when copying..
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" :PluginInstall

" plug-ins
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/trailing-whitespace'
Bundle 'majutsushi/tagbar'
Bundle 'autowitch/hive.vim'

" plug-ins for specific files (per ab)
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-git'

" syntax files
Bundle 'tpope/vim-markdown'

" color schemes
" Bundle 'nanotech/jellybeans.vim'
" Bundle 'tomasr/molokai'
" Bundle 'vim-scripts/Skittles-Dark'
" Bundle 'vim-scripts/wombat256.vim'
" Bundle 'wgibbs/vim-irblack'

" basic viewing stuff
set guifont="Anonymous\ Pro\ 11"
set background=dark
set t_Co=256
set textwidth=80
set colorcolumn=81
au BufEnter * set colorcolumn=81

set ruler
set title
set number
"set relativenumber
set showmatch                   " show matching paren
set showmode
set showcmd
set autochdir

" syntax pretty
syntax enable
filetype plugin indent on
set ttyfast                     " send more chars for redraws

" stuff having to do with tabbing and indenting
" note: edited per ab config
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" Allows for ctags -- awesomeness
set tags=tags;/

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

" faster ctrl-p search
"Only refreshes results every 100ms, so if type fast searches don't pile up
let g:ctrlp_lazy_update = 100
let g:ctrlp_user_command = 'find %s -type f | egrep -iv "(\.(eot|gif|gz|ico|jpg|jpeg|otf|png|psd|pyc|svg|ttf|woff|zip)$)|(/\.)|((^|\/)tmp\/)"' "Quicker indexing"

" Generating hive files from Hive++ data
function! CopyHivePP(...)
    write
    " I think right now this only will work on macs
    execute '! hive++ ' .  shellescape(a:1) ' -d | pbcopy '
endfunction
au BufNewFile,BufRead *.hql noremap <leader>h :call CopyHivePP(expand("%"))  <CR>
