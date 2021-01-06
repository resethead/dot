set term=screen-256color
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
  Plug 'vim-scripts/wombat256.vim'
  Plug 'christoomey/vim-tmux-navigator'
call plug#end()

"auto re-load vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Exit visual/insert modes WITHOUT a delay
set timeoutlen=1000 ttimeoutlen=0

set laststatus=2
set t_Co=256

"paste toggle key is now F2
set pastetoggle=<F2>
"allows you yank into clipboard normally
set clipboard=unnamed
"Couldn't get clipboard support on RedHat - xclip workaround
vnoremap <C-c> y:call system('xclip -selection clipboard',@0)

"changes default encryption to blowfish2
" Needs current version of VIM past 7.5 should be supported
set cm=blowfish2

com! FormatJSON %!python -m json.tool
"enable mouse
set mouse=a
set bs=2

let mapleader = ","

"sort selected block
vnoremap <Leader>s :sort<CR>

vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

noremap <Leader>e :quit<CR>
"quicksave 
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
"move around splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"move around tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

set number
set nowrap
set fo-=t " don't automatically wrap text when typing
set colorcolumn=80 " shows color threshold; in py should be 80

color wombat256mod

set nobackup
set nowritebackup
set noswapfile
syntax on
