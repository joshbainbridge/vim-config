" This always comes first
set nocompatible

" Then syntax highlighting for all files
syntax on

" Set background for tmux compatibility
set background=dark

" Use 256 colours from gruvbox
packadd! gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

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
set numberwidth=4
set number

" Add row number highlighting
set cursorline

" Setting these according to h: tabstop
set tabstop=4
set shiftwidth=4
set cindent

" Configure the statusline
set laststatus=2

" More natural split opening
set splitbelow
set splitright

" Make special characters visible
set listchars=tab:+-,trail:+
set list

" Specific commands for text files
autocmd FileType text,markdown setlocal spell nonumber wrap

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk

" Add clang format key maps
nnoremap <silent> <leader>f :%! clang-format-11 --style=file<CR>
vnoremap <silent> <leader>f :'<,'>! clang-format-11 --style=file<CR>

" Accept completion from popup with <CR>
inoremap <expr> <CR> pumvisible() ? '<C-Y>' : '<CR>'

" Don't keep the banner when running netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 0

" If fzf is found...
if executable("fzf")
    " Change fzf layout to bottom of screen
    let g:fzf_layout = { 'window': '15new' }

    " Mapping for fuzzy search with fzf
    nnoremap <C-P> :FZF<CR>
endif

" If ripgrep is found...
if executable("rg")
    " Set grep command to use ripgrep
    set grepprg=rg\ --vimgrep

    " Configure the format to match ripgrep
    set grepformat=%f:%l:%c:%m
endif

" If clangd is found...
if executable('clangd')
    " Configure vim-lsp with the clangd server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Define a config function for LSP enabled buffers
function! s:on_lsp_buffer_enabled() abort
    " Options for LSP enabled files
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Make omni completion easier to access
    imap <buffer> <expr> <C-N> pumvisible() ? '<C-N>' : '<C-X><C-O>'

    " Basic mappings for LSP functionality
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

" Run the config function for LSP enabled buffers
augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Enable LSP diagnostics in the status bar
let g:lsp_diagnostics_echo_cursor = 1

" Use ANSI colours from dim
" colorscheme dim
" highlight CursorLine   cterm=NONE
" highlight CursorLineNr cterm=NONE
" highlight! link SignColumn LineNr

" Resize window to standard width (+5 for numbers, +2 for signs)
" nnoremap <silent> <leader>' :vertical resize 87<CR>

" Specific commands for source code
" autocmd FileType cpp,python,cmake setlocal colorcolumn=80
