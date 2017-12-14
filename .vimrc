"=============================================================
"=====================  PLUGIN SETTINGS ======================
"=============================================================

" Vundle Settings
set nocompatible     " be iMproved, required
filetype off         " required

set rtp+=~/.vim/bundle/Vundle.vim 
call vundle#begin() 

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins using Vundle
Plugin 'vim-airline/vim-airline'        " custom status bar
Plugin 'tpope/vim-fugitive'             " git wrapper
Plugin 'tpope/vim-commentary'           " easy commenting
Plugin 'tpope/vim-surround'             " easy surround
Plugin 'ctrlpvim/ctrlp.vim'             " fuzzy finder
Plugin 'vim-syntastic/syntastic'        " syntax checking
Plugin 'terryma/vim-expand-region'      " visual select expander
Plugin 'jeetsukumaran/vim-buffergator'  " buffer management

" Syntastic JavaScript checker ----------------
let g:syntastic_javascript_checkers = ['eslint']

" Custom mapping for vim-expand-region ---------
map J <Plug>(expand_region_shrink)
map K <Plug>(expand_region_expand)

" CtrlP ---------------------------------------- 
" use nearest .git directory as the cwd 
let g:ctrlp_working_path_mode = 'r'
" shortcut to open CtrlP
nmap <leader>f :CtrlP<CR>
" set up some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" easy bindings for various modes
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>bm :CtrlPMixed<CR>
nmap <leader>bs <CtrlPMRU<CR>

" Buffergator settings -------------------------
" use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" enable custom keymappings
let g:buffergator_suppress_keymaps = 1
" go to previous buffer open 
nmap <leader>tt :BuffergatorMruCyclePrev<CR>
" go to next buffer open
nmap <leader>yy :BuffergatorMruCycleNext<CR>
" view the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<CR>
" open a new empty buffer
nmap <leader>T :enew<CR>
" close current buffer and move to previous one 
nmap <leader>bq :bp <BAR> bd #<CR>

" -----------------------------------------------
" All Plugins must be added before the following line
call vundle#end()

"=============================================================
"===================== CORE SETTINGS =========================
"=============================================================

" Visual Settings
syntax on            " enable syntax processing 
set number           " show line numbers
set modeline         " displays file at the bottom
set ls=2             " displays 2 lines of status at bottom 

" Typing Settings
imap jk <Esc>
set tabstop=2        " 2 space tab (display)
set softtabstop=2    " 2 space tab (editing)
set shiftwidth=2     " for autoindent and >>, etc
set expandtab        " use spaces for tabs
set autoindent       " automatically indents lines
set smartindent      " smarter indenting

" Search Settings
set showmatch        " highlight matching [{()}]
set incsearch        " search as characters are entered
set hlsearch         " highlight matches
set ignorecase       " case insensitive searching if all lower case
set smartcase        " case sensitive searching if not all lower
  
"=============================================================
"============== SHORTCUTS/COMMANDS ===========================
"=============================================================

" Leader Shortcuts 
let mapleader=" "

" <leader>-<space> clears highlights
map <leader><space> :nohlsearch<CR>

" <leader>-v opens $MYVIMRC
nmap <leader>v :split $MYVIMRC<CR> 

" <leader>-r reload vimrc
nmap <leader>r :source $MYVIMRC<CR>

" <leader>-p install plugins
nmap <leader>p :PluginInstall<CR>

" View a diff between saved and unsaved versions
command! Diff execute 'w !git diff --no-index % -'

" window changing shortcuts--------------------
" shortcuts to move (or open) new windows using hjkl
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction
map <leader>h :call WinMove('h')<CR>
map <leader>k :call WinMove('k')<CR>
map <leader>l :call WinMove('l')<CR>
map <leader>j :call WinMove('j')<CR>
" wc = window close
map <leader>wc :wincmd q<CR>
" wr = windows rotate
map <leader>wr <C-W>r
" shortcuts to move windows
map <leader>H :wincmd H<CR>
map <leader>K :wincmd K<CR>
map <leader>L :wincmd L<CR>
map <leader>J :wincmd J<CR>
" shortcuts to resize windows
nmap <left> :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up> :3wincmd +<cr>
nmap <down> :3wincmd -<cr>

" ------------------------------------------
" Auto-Reload My Vimrc after making changes
augroup reload_vimrc 
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
