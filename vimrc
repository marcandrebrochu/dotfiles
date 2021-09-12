" vim: foldmethod=marker

" I don't care about Vim being Vi-compatible.
set nocompatible

" Character encoding, applies to text in buffers, registers, Strings in
" expressions, text stored in the viminfo file, etc.
set encoding=utf-8

" If in this many ms, nothing is typed, the swap file will be written to the
" disk. Also used for the CursorHold autocommand event.
set updatetime=300

" Visualize trailing whitespaces.
set listchars=trail:·
set list

" Terminal behavior {{{
" -----------------------------------------------------------------------------
" Any bell is annoying as hell. This will disable both beeps and flashes.
set visualbell
set t_vb=

" Indicates fast terminal connection. Improves smoothness of redrawing.
set ttyfast

" Do not redraw the screen while executing macros, regisers and other commands
" that have not been typed.
set lazyredraw
" -----------------------------------------------------------------------------
" }}}

" Buffer behavior {{{
" -----------------------------------------------------------------------------
" Keep a changed buffer without saving it, by hiding it instead of abandoning
" it. The old buffer is not displayed anymore, but it's not unloaded.
set hidden

" Do not make any backups when saving to a file.
set nobackup
set nowritebackup
" -----------------------------------------------------------------------------
" }}}

" Interface configuration {{{
" -----------------------------------------------------------------------------
" Shows the line and column number of the cursor position. If the number of
" characters displayed is different from the number of bytes in the text, both
" the text column (byte number) and the screen column are shown.
set ruler

" If in Insert, Replace or Visual mode, put a message on the last line.
set showmode

" Show partial command in the last line of the screen.
set showcmd

" Draw the signcolumn, displaying signs in the 'number' column. If the number
" column is not present, the signcolumn is only shown when there are signs.
set signcolumn=number

" Don't give completion menu messages.
set shortmess+=c

" Splitting a window will put the new one below or to the right of the current
" one.
set splitbelow
set splitright
" -----------------------------------------------------------------------------
" }}}

" Text editing {{{
" -----------------------------------------------------------------------------
" Always insert spaces instead of tabs.
set tabstop=2
set shiftwidth=0 " means use tabstop value
set expandtab

" Allows backspacing over anything as long as it does not go over the start of
" insert. Concretely this means an edit session cannot remove text from
" another edit session.
set backspace=eol,indent

" When a bracket is inserted, briefly jump to the matching one.
set showmatch
" -----------------------------------------------------------------------------
" }}}

" Patterns and searching {{{
" -----------------------------------------------------------------------------
" When there is a previous search pattern, highlight all its matches. Turning
" off highlighting with :nohlsearch does not change the option value; as soon
" as another search is done, the highlighting will come back.
set hlsearch

" While typing a search command, interactively show matches. CTRL-L can be
" used to add one character from after the current match to the command line.
" CTRL-R CTRL-W can be used to add the word at the end of the current match.
set incsearch

" Ignore the case of normal letters, but only when the pattern only contains
" lowercase letters.
set ignorecase
set smartcase

" Ignore files that match with one of these patterns when expanding wildcards,
" completing file or dir names.
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" -----------------------------------------------------------------------------
" }}}

" Plugins {{{
" -----------------------------------------------------------------------------
filetype plugin on

call plug#begin('~/.local/share/nvim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'neoclide/coc.nvim'
Plug 'elzr/vim-json'
Plug 'kovetskiy/sxhkd-vim'
Plug 'weakish/rcshell.vim'
Plug 'vmchale/dhall-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'junegunn/goyo.vim'
Plug 'lifepillar/vim-solarized8'
call plug#end()
" -----------------------------------------------------------------------------
" }}}

" Syntax highlighting and theme {{{
" -----------------------------------------------------------------------------
syntax enable

" Get truecolor support in the terminal; should work in tmux>=2.2
set termguicolors

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 0,
  \       'override': {
  \         'color00': ['#040402', 23],
  \         'linenumber_bg': ['#0a0a09', 23]
  \       }
  \     }
  \   }
  \ }

set background=dark
colorscheme PaperColor
" -----------------------------------------------------------------------------
" }}}

let mapleader=","

" Identify logical with visual lines when browsing around.
nnoremap j gj
nnoremap k gk

nnoremap <leader>z :Goyo<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>sc :source $MYVIMRC<CR>

" Clear search highlighting and register.
nnoremap <leader>/ :let @/=''<CR>:set nohlsearch<CR>

" Move quickly between splits.
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
