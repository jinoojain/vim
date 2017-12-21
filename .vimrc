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
Plugin 'tpope/vim-unimpaired'           " shortcuts for pairs
Plugin 'ctrlpvim/ctrlp.vim'             " fuzzy finder
Plugin 'terryma/vim-expand-region'      " visual select expander
Plugin 'jeetsukumaran/vim-buffergator'  " buffer management
Plugin 'vim-syntastic/syntastic'        " syntax/style checker

" Syntastic settings --------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" line below uses local .eslint not global installation
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" <leader>q now runs eslint and populates a loc list
nmap <leader>q :SyntasticCheck eslint<cr>

" Custom mapping for vim-expand-region ---------
map J <Plug>(expand_region_shrink)
map K <Plug>(expand_region_expand)

" CtrlP ---------------------------------------- 
" use nearest .git directory as the cwd 
let g:ctrlp_working_path_mode = 'r'
" shortcut to open CtrlP
nmap <leader>f :CtrlP<cr>
" set up some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" easy bindings for various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs <CtrlPMRU<cr>

" Buffergator settings -------------------------
" use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" enable custom keymappings
let g:buffergator_suppress_keymaps = 1
" go to previous buffer open 
nmap <leader>tt :BuffergatorMruCyclePrev<cr>
" go to next buffer open
nmap <leader>yy :BuffergatorMruCycleNext<cr>
" view the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>
" open a new empty buffer
nmap <leader>T :enew<cr>
" close current buffer and move to previous one 
nmap <leader>bq :bp <BAR> bd #<cr>

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
map <leader><space> :nohlsearch<cr>

" <leader>-v opens $MYVIMRC
nmap <leader>v :split $MYVIMRC<cr> 

" <leader>-r reload vimrc
nmap <leader>r :source $MYVIMRC<cr>

" <leader>-p install plugins
nmap <leader>p :PluginInstall<cr>

" View a diff between saved and unsaved versions
command! Diff execute 'w !git diff --no-index % -'

" lists all TODOs and FIXMEs 
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" window changing shortcuts--------------------
" function that handles window management
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

" shortcuts to move (or open) new windows using hjkl
map <leader>h :call WinMove('h')<cr>
map <leader>k :call WinMove('k')<cr>
map <leader>l :call WinMove('l')<cr>
map <leader>j :call WinMove('j')<cr>

" <leader>wc = window close
map <leader>wc :wincmd q<cr>

" <leader>wr = windows rotate
map <leader>wr <C-W>r

" shortcuts to move windows around
" hard to describe - just play around with it :) 
map <leader>H :wincmd H<cr>
map <leader>K :wincmd K<cr>
map <leader>L :wincmd L<cr>
map <leader>J :wincmd J<cr>

" remaps arrow keys as shortcuts to resize windows
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
