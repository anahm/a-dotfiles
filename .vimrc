" environment
set nocompatible		" must be first line

	" Pathogen Plug-in for Vim
call pathogen#infect()
call pathogen#helptags() " to make editing .vimrc easier in the future...

" basic vim editing behavior

set wrap						" please wrap lines
set textwidth=80				" max length per line = 80 char
set backspace=indent,eol,start	" backspacing allowed in insert mode	

set guifont="Anonymous\ Pro\ 11"
set background=dark
set t_Co=256
colorscheme wombat
syntax on

set number						" show line numbers
"set relativenumber				" show relative line numbers
set showmatch 					" show matching paren

	" stuff having to do with tabbing and indenting
filetype plugin indent on
set smartindent
set expandtab
set tabstop=4					" tab = 4 spaces
set autoindent					" autoindenting always on
set copyindent					" copy previous indentation for autoindent
set shiftwidth=4 				" num spaces for autoindenting
set smarttab 					" insert tabs of line start on shiftwidth, 
   								" not tabstop

	" searching stuff
set smartcase						" ignore case if lowercase
set hlsearch 						" highlight search terms
set incsearch 						" shows search matches as you type

" gui / ui stuff
	" highlighting 80+ characters

highlight OverLength ctermbg=green ctermfg=white guibg=#59292
match OverLength /\%81v.\+/

	" show current mode
set showmode

" Allows for ctags -- awesomeness
set tags=tags;/


""""""""""""" keyboard shortcuts """"""""""""

	" mapleader = free key to place custom mappings
let mapleader=","

nnoremap <leader>p :set invpaste<CR>
nnoremap <leader>s :vsplit<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap t<silent> <leader>sv :so $MYVIMRC<CR>

" ; > :
nnoremap ; :
