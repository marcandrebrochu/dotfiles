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
