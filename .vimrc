"
" .vimrc file of ali nahm
" be nice to it
" 
" and remember, pigs can fly
"

" environment
	" basics
set nocompatible		" must be first line
set background=dark		" assume dark background

	" Pathogen Plug-in for Vim
	" a.k.a. bundle support (manager for vim plugins) 
call pathogen#infect()
call pathogen#helptags() " to make editing .vimrc easier in the future...

	" mapleader = free key to place custom mappings
let mapleader=","

	" ,ev and ,sv to edit/reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" basic vim editing behavior
	" hide buffer instead of closing buffer
	" (can have unwritten changes and open a new file without saving changes)
set hidden

set wrap						" please wrap lines
set textwidth=80				" max length per line = 80 char
set backspace=indent,eol,start	" backspacing allowed in insert mode	

set guifont="Anonymous\ Pro\ 11"
set number						" show line numbers
"set relativenumber				" show relative line numbers
set showmatch 					" show matching paren

	" stuff having to do with tabbing and indenting
set smartindent
set expandtab
set tabstop=4					" tab = 4 spaces
set autoindent					" autoindenting always on
set copyindent					" copy previous indentation for autoindent
set shiftwidth=4 				" num spaces for autoindenting
set smarttab 					" insert tabs of line start on shiftwidth, 
   								" not tabstop

	" searching stuff
set smartcase						" ignore case if search pattern 
									" lowercase, otherwise case-sensitive
set hlsearch 						" highlight search terms
set incsearch 						" shows search matches as you type
		" new command to clear highlighted searches
nmap <silent> ,/ :nohlsearch<CR> 	

	" enlarging the undo buffer
set history=1000 				" remember commands / search history
set undolevels=1000 			" go back as much as you remember
set wildignore=*.swp,*.bak,*.pyc,*.class

	
	" preventing vim from writing a backup file
	" HUGE POTENTIAL TO SCREW ME OVER 
" set nobackup 
" set noswapfile

" basic filetype schtuff
	" enable indenting intel. based on syntax rules of the file type
filetype plugin indent on

	" set file type specific settings
if has('autocmd')
	autocmd filetype python set expandtab
		" specific forms of tabbing
	autocmd filetype html,xml set listchars-=tab:>.
endif

" gui / ui stuff

	" columns
set columns=80

	" colorscheme
if &t_Co >= 256 || has("gui_running")
	if has("mac")
		set guifont=DejaVu\ Sans\ Mono:h13
	elseif has("unix")
		set guifont=DejaVu\ Sans\ Mono\ 13
	endif
   	colorscheme ir_black 
endif

	" highlighting 80+ characters
	" http://stackoverflow.com/questions/7797593/highlighting-more-than-80-
	" characters-with-a-non-standard-colorscheme

highlight OverLength ctermbg=green ctermfg=white guibg=#59292
match OverLength /\%81v.\+/

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

	" seeing | tabstop, dot trail, > at lines too long, < overflow line, + 
"set list
"set listchars=tab:\|\ ,trail:•,extends:>,precedes:<,nbsp:+

	" pasting easier by temporarily switching into paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

	" jumps to next line in editor, rather than then next new line
nnoremap j gj
nnoremap k gk

	" press space to turn off highlighting and clear any msg already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

	" show current mode
set showmode

	" hide mouse while typing
set mousehide

	" make command line two lines high
set ch=2

	" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

	" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_ 


""""""""""""""""""""""" PLUG-IN SETTINGS """"""""""""""""""""""""""""

" NERD Tree plugin settings

	" Toggle the NERD Tree on an off with F7
nmap <silent> ,t :NERDTreeToggle<CR>

	" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

	" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$' ]

" fugitive.vim plugin
