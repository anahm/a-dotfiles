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
Bundle 'ambv/black'

" plug-ins for specific files (per ab)
Bundle 'tpope/vim-git'

" syntax files
Bundle 'fisadev/vim-isort'
Bundle 'tpope/vim-markdown'
Bundle 'tell-k/vim-autopep8'
Bundle 'nvie/vim-flake8'
Bundle 'posva/vim-vue'
Bundle 'leafgarland/typescript-vim'
Bundle 'mxw/vim-jsx'

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
let g:ctrlp_user_command = 'find %s -type f | egrep -iv "(\.(eot|gif|gz|ico|jpg|jpeg|otf|png|psd|pyc|svg|ttf|woff|zip|build|deploy)$)|(/\.)|((^|\/)tmp\/|node_modules)"' "Quicker indexing"

" TODO switch to silver searcher
" let g:ctrlp_custom_ignore = '\v[\/](node_modules|symlinks|dist|venv)|(\.(build|deploy))$'

"" vi settings to match vscode settings
" https://github.com/humu-com/code/blob/master/.vscode/settings.json

" Autopep8
nnoremap <leader>ap :Autopep8<CR>
let g:autopep8_max_line_length=100
let g:autopep8_aggressive=2  " add more aggressive options (--aggressive)
let g:autopep8_indent_size=4

" black doesn't support AutoFormatBuffer b/c it doesn't handle line ranges, so you need this
" instead.
" autocmd BufWritePre *.py execute ':Black'

" Run iSort automatically on every save
autocmd BufWritePost *.py Isort

"" Flake8
let g:flake8_show_in_gutter=1  " show warnings/errors in left gutter
let g:flake8_show_in_file=0  " don't show marks in the file
let g:flake8_error_marker='✗'
let g:flake8_warning_marker='⚠'
let g:black_linelength=100
let g:black_skip_string_normalization=1
autocmd FileType python map <buffer> <leader>fl :call Flake8()<CR>
autocmd BufWritePost *.py call Flake8()

""" Black
let g:black_linelength=100
let g:black_skip_string_normalization=1
" autocmd BufWritePre *.py execute ':Black'
