" This always comes first
set nocompatible

" Then syntax highlighting for all files
syntax on

" Use ANSI colours to improve consistency
colorscheme vim-dim/colors/dim

" Set background for tmux compatibility
set background=dark

" Standard configuration options
set wildmenu
set hlsearch
set incsearch
set ruler
set showcmd
set nowrap

" Configure line numbers
set numberwidth=5
set number

" Setting these according to h: tabstop
set tabstop=4
set shiftwidth=4
set cindent

" Configuration that works with lightline.vim
set laststatus=2
set noshowmode

" More natural split opening
set splitbelow
set splitright

" Add row number highlighting
set cursorline
highlight clear CursorLine

" Keep the banner when running netrw
let g:netrw_banner=1
let g:netrw_liststyle=0

" Set grep command to use ripgrep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Specific commands for source code
autocmd FileType cpp,python,cmake setlocal colorcolumn=80

" Specific commands for text files
autocmd FileType text,markdown setlocal spell nonumber wrap

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk

" Resize window to standard width
nnoremap <silent> <leader>' :vertical resize 85<CR>
