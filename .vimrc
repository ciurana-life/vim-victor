" admin@victorciurana.com

set encoding=utf-8
scriptencoding utf-8
set nocompatible
filetype off
syntax on
set t_Co=256
set number

" Enable folding
set foldmethod=indent
set foldlevel=99

" Color scheme
set background=dark
colorscheme molokai

" Show hidden characters
" set listchars=eol:¬
" set list

set laststatus=2

" Enable folding with t
nnoremap <space> za

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" Python specific settings
set encoding=utf-8

"python with virtualenv support
if has('python')
python << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Misc
:set backspace=indent,eol,start

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'itchyny/lightline.vim'
Plugin 'itchyny/vim-gitbranch'
Plugin 'preservim/nerdtree'

" Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Plugin settings
let g:ycm_autoclose_preview_window_after_completion = 1
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Auto-open NERDTree when Vim starts
autocmd VimEnter * NERDTree
let NERDTreeShowHidden=1