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

" Give a text width value
set textwidth=80

" Configure line numbers
set numberwidth=5
set number

" Add row number highlighting
set cursorline
highlight clear CursorLine

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

" Make special characters visible
set listchars=tab:+-,trail:-
set list

" Keep the banner when running netrw
let g:netrw_banner=1
let g:netrw_liststyle=0

" Set grep command to use ripgrep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Set the make program and error format
set makeprg=ninja\ -C\ build
set errorformat=../%f:%l:%c:\ error:\ %m,../%f:%l:%c:\ fatal\ error:\ %m

" Specific commands for source code
autocmd FileType cpp,python,cmake setlocal colorcolumn=80

" Specific commands for text files
autocmd FileType text,markdown setlocal spell nonumber wrap

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk

" Resize window to standard width (+5 for line numbers)
nnoremap <silent> <leader>' :vertical resize 85<CR>

" Add clang format key maps
nnoremap <silent> <leader>f :%! clang-format-11 --style=file<CR>
vnoremap <silent> <leader>f :'<,'>! clang-format-11 --style=file<CR>

" Configure vim-lsp with the clangd server
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
