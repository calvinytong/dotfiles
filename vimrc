if &compatible
  set nocompatible
endif

" Automatic installation
if empty(glob('~/.local/share/nvim/plugged'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'icymind/NeoSolarized'
Plug 'junegunn/fzf', {'build': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'google/vim-searchindex'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
call plug#end()


" ----- Editing files and buffers -----

filetype plugin indent on
syntax enable

set clipboard=unnamedplus

let mapleader=","
nmap ; :
:imap jj <Esc>


set autoread
set hidden
set title
set noswapfile
set nobackup
" set nowb

set backspace=indent,eol,start

set fileformat=unix

set history=1000
set undolevels=1000

set visualbell


" ----- window -----

set number
set showcmd
set linebreak
set textwidth=80
set colorcolumn=81
set cursorline
set lazyredraw
set scrolloff=8
set laststatus=2
set list lcs=trail:·

" trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" terminal
command! -nargs=* T sp | te <args>
command! -nargs=* VT vs | te <args>

tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
autocmd BufWinEnter,WinEnter term://* startinsert
tnoremap <esc> <c-\><c-n>

" nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize = 30


" ----- indentation -----

set autoindent
set smartindent
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set scrolloff=5




" ----- fzf -----

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <silent> ,t :Files<CR>
nnoremap <silent> ,b :Buffers<cr>
nnoremap <silent> ,r :Tags<cr>

let g:fzf_tags_command = 'ctags -R'

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let $FZF_DEFAULT_OPTS .= ' --no-height'

" ----- searching -----

set ignorecase
set smartcase
set incsearch


" ----- appearance -----

set termguicolors
colo NeoSolarized

" ----- formatting and linting -----

let g:ale_linters = {
  \'python': ['flake8', 'mypy'],
  \'typescript': ['tslint'],
  \'yaml': ['yamllint']
\}

let g:ale_fixers = {
  \'typescript': ['prettier'],
  \'python': ['yapf'],
  \'yaml': ['prettier']
\}

" don't lint on text change or file entry
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0

" lint and fix on save
let g:ale_lint_on_save=1
let g:ale_fix_on_save=1

let g:ale_echo_cursor=0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list=1

let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'

" ----- autocomplete and LSP -----

let g:deoplete#enable_at_startup=1


" use TAB to manually autocomplete with deoplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_trace = 'verbose'

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ----- comments -----
filetype plugin on

" allow commenting and inverting empty lines
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ----- status bar -----
let g:airline_theme = 'solarized'

" ----- language specific formatting -----
autocmd FileType yaml setlocal expandtab
    \ tabstop=2
    \ sts=2
    \ sw=2

autocmd Filetype python setlocal expandtab
    \ textwidth=79
    \ shiftwidth=4
    \ tabstop=4

autocmd Filetype c setlocal noexpandtab
    \ softtabstop=8
    \ shiftwidth=8
    \ tabstop=8

autocmd Filetype ruby setlocal expandtab
    \ tabstop=2
    \ shiftwidth=2
    \ textwidth=79

autocmd Filetype cpp setlocal noexpandtab
    \ shiftwidth=2
    \ tabstop=2

autocmd FileType cmake setlocal ts=4 sts=4 sw=4
autocmd FileType dockerfile setlocal nolist noexpandtab
autocmd FileType go setlocal nolist noexpandtab
autocmd FileType make setlocal nolist noexpandtab

autocmd BufNewFile,Bufread *.s set ft=asm
