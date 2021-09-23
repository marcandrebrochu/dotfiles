" vim: foldmethod=marker

" I don't care about Vim being Vi-compatible.
set nocompatible

" Character encoding, applies to text in buffers, registers, Strings in
" expressions, text stored in the viminfo file, etc.
set encoding=utf-8

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
set statusline=%f%y%([%R%M]%)%=%l:%c%V\ %P

" Always show the status line, even if there is only one window.
set laststatus=2

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
call plug#begin('~/.local/share/nvim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'elzr/vim-json'
Plug 'kovetskiy/sxhkd-vim'
Plug 'weakish/rcshell.vim'
Plug 'vmchale/dhall-vim'
Plug 'junegunn/goyo.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovimhaskell/haskell-vim'
call plug#end()

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Goyo by default acts as a mode, which means that :q while in Goyo will just
" quit the mode and not Vim as I expect. These callbacks fix this behavior
" most of the time...
function! GoyoBefore()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! GoyoAfter()
  " Quit Vim if this is the only remaining buffer.
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
" -----------------------------------------------------------------------------
" }}}

" Syntax highlighting and theme {{{
" -----------------------------------------------------------------------------
syntax on
filetype plugin indent on

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

" Fzf stuff.
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Editing Haskell {{{
" -----------------------------------------------------------------------------
function! SetupHaskell()
  setlocal tabstop=4
endfunction

augroup haskell
  autocmd!
  autocmd FileType haskell call SetupHaskell()
augroup END
" -----------------------------------------------------------------------------
" }}}

" Editing emails {{{
" -----------------------------------------------------------------------------
function! SetupEmail()
  " When writing emails, I like to not have logical linebreaks inserted into
  " my text. It's better to let my MUA flow the text usually.
  setlocal textwidth=0
  setlocal wrap
  setlocal linebreak
endfunction

augroup email
  autocmd!
  autocmd BufNewFile,BufRead /tmp/neomutt/* call SetupEmail() | Goyo
augroup END
" -----------------------------------------------------------------------------
" }}}
