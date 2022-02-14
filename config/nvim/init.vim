" Make Vim more useful
set nocompatible
" Use Linux/OS clipboard by default
set clipboard=unnamed
" Optimize for fast terminal connections
set ttyfast
" New lines inherit the identation of previous lines
set autoindent
" Make tabs as wide as two spaces
set tabstop=2 softtabstop=2 smarttab expandtab
" Enable per-directory .vimrc files
set exrc
" Show the filename in the window title bar
set title
" Use relative line numbers
set relativenumber
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Keeps any edited buffer in the background
set hidden
" Disable error bells
set noerrorbells
" Do not wrap lines
set nowrap
" Highlight dynamically as pattern is typed
set incsearch
" Show 120 columns but make it obvious where 80 characters is
let &colorcolumn="81,".join(range(129,999),",")
" Start scrolling 8 lines before the horizontal window border
set scrolloff=8
" Add extra column
set signcolumn=yes
" Show current mode
set showmode
" Enhance command-line completion
set wildmenu
" Enable file type detection
filetype on
if has ("autocmd")
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
" Set visual bell
set vb
" Allow backspace in insert mode
set backspace=indent,eol,start
" Enable mouse in all modes
set mouse=a

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark    " Setting dark mode
"set background=light   " Setting light mode

" Plugins
call plug#begin('~/.dotfiles/config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()


" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gu :CocCommand git.chunkUndo<cr>

nmap <silent> <leader>k :CocCommand explorer<cr>

"remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh <Plug>(coc-doHover)
