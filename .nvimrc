set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
  Plug 'vim-scripts/wombat256.vim'
  Plug 'christoomey/vim-tmux-navigator'

  "Deoplete (Java Script)
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  
  "Deoplete engines
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'deoplete-plugins/deoplete-jedi' 
  Plug 'w0rp/ale'  
 
  Plug 'sbdchd/neoformat'
  Plug 'vim-airline/vim-airline'
  Plug 'einars/translit.vim'
call plug#end()

let g:deoplete#enable_at_startup = 1

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
set clipboard=unnamedplus
"copy to clipboard
vnoremap <C-c> y:call system('xclip -selection clipboard',@0)

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
noremap <Leader>q :quit!<CR>

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

"highlight colorcolumn ctermbg=233 " change color for threshold column
color wombat256mod

set nobackup
set nowritebackup
set noswapfile
syntax on

"ctrlp should load current directory files
let g:ctrlp_working_path_mode = 'c'

augroup CommandManager 
        au!
	autocmd BufRead */*.py call Load_PythonCommands()
augroup end

function! Load_PythonCommands()
	nnoremap <Leader>r :!python3 %<ENTER>
endfunction

"deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"autocmd FileType javascript set formatprg=prettier\ --stdin
"autocmd BufWritePre *.js :normal gggqG
let g:ale_fixers = {
			\   'javascript': ['prettier']
			\}

let g:ale_linters = {
			\  'javascript': ['eslint']
			\}

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --no-semi'

let g:ale_fix_on_save = 1

let g:neoformat_try_formatprg = 1
augroup NeoformatAutoFormat
	    autocmd!
	        autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier\ --single-quote
augroup end
nnoremap gp :silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote<CR>

