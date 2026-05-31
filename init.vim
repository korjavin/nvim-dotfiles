" ============================================================================
" Neovim configuration  —  migrated from ~/.vim/vimrc (May 2026)
"
" Independent from the old Vim config on purpose: lives in ~/.config/nvim and
" shares nothing with ~/.vim, so the two editors never influence each other.
"
" Dropped during migration (no longer used):
"   - YouCompleteMe        (was never even compiled; use built-in LSP later)
"   - vim-powerline        (deprecated)
"   - Snippets             (snipmate / snippetsEmu / SuperTab + after/ftplugin)
"   - Perl tooling         (compiler, makeprg, perltidy, .pl autocmds, folding)
"   - PHP tooling          (php -l lint, php_sql_query, .twig/.tt/.ep filetypes)
"
" Plugin manager is vim-plug (replaces Vundle). NERDTree is now a declared,
" managed plugin instead of the old ad-hoc Vimball dump in ~/.vim.
" ============================================================================

" ============================================================================
" PLUGIN MANAGER (vim-plug)
"   Plugins live under stdpath('data')/plugged (~/.local/share/nvim), fully
"   separate from ~/.vim/bundle. vim-plug auto-installs itself on first launch.
"   After that, manage with:  :PlugInstall  :PlugUpdate  :PlugClean
" ============================================================================
let s:plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " Load it now so plug#begin() below resolves on this very first run.
  execute 'source ' . s:plug_path
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" --- Colorschemes ---
Plug 'lifepillar/vim-solarized8'      " true-color Solarized (replaces altercation/vim-colors-solarized)
Plug 'tomasr/molokai'
Plug 'nelstrom/vim-mac-classic-theme'

" --- Navigation / files ---
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'             " maintained fork of kien/ctrlp.vim
Plug 'mbbill/undotree'
Plug 'moll/vim-bbye'                  " :Bdelete / :Bwipeout without closing windows
Plug 'bogado/file-line'              " open file:line from the shell

" --- Editing ---
Plug 'Raimondi/delimitMate'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'AndrewRadev/linediff.vim'

" --- HTML ---
Plug 'othree/html5.vim'
Plug 'vim-scripts/indenthtml.vim'

" --- Languages ---
Plug 'fatih/vim-go'                   " run :GoInstallBinaries after first install

" --- Misc ---
Plug 'vimwiki/vimwiki'
Plug 'mattn/webapi-vim'               " dependency of gist-vim
Plug 'mattn/gist-vim'
Plug 'mattn/pastebin-vim'

call plug#end()

filetype plugin indent on
syntax on

" fzf (installed via homebrew, not vim-plug)
set rtp+=/opt/homebrew/opt/fzf

" ============================================================================
" GENERAL
" ============================================================================
set ru                          " ruler
set si                          " smartindent
set sta                         " smarttab
set hidden
set autoread
set ch=2                        " command line height
set laststatus=2
set showcmd                     " show incomplete cmds at the bottom
set showmode                    " show current mode at the bottom
set shortmess=tToOI
set belloff=all                 " no bell (replaces Vim's `visualbell t_vb=`)
set mousemodel=popup
set dir=~/tmp/
set timeout timeoutlen=3000 ttimeoutlen=100
set clipboard+=unnamed
set splitbelow
set splitright
" NOTE: Vim's `ttyfast` and `t_Co=255` were removed here — Neovim handles
" terminal capabilities automatically and rejects those options.

" ============================================================================
" APPEARANCE
" ============================================================================
set termguicolors               " true color — kitty supports it; gives real Solarized hex
set background=dark
silent! colorscheme solarized8  " true-color Solarized (silent! so first launch pre-install is quiet)

set linespace=4
set list
set listchars=trail:.,tab:>-
set listchars+=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
highlight lCursor guifg=NONE guibg=Cyan

" ============================================================================
" EDITING / INDENTATION
" ============================================================================
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start
set formatoptions-=o            " dont continue comments when pushing o/O
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" ============================================================================
" SEARCH
" ============================================================================
set ic                          " ignorecase
set incsearch

" ============================================================================
" FOLDING
" ============================================================================
set foldmethod=indent           " fold based on indent
set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " dont fold by default

" ============================================================================
" COMPLETION / WILDMENU
" ============================================================================
set completeopt+=longest
set wildmenu                    " enable ctrl-n / ctrl-p to scroll matches
set wildmode=list:longest       " cmdline tab completion similar to bash
set wcm=<Tab>
set wildignore=*.o,*.obj,*~     " stuff to ignore when tab completing

" ============================================================================
" ENCODING / KEYMAP
" ============================================================================
set fileencodings=ucs-bom,utf-8,cp1251,koi8-r,ibm866,default,latin1
set keymap=russian-jcukenwin    " toggle layout with <C-^> in insert mode
set iminsert=0
set imsearch=-1
set diffopt=filler,iwhite

menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.win-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866   :e ++enc=ibm866<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>

" ============================================================================
" MAPPINGS
" ============================================================================
" --- Tabs / windows / buffers ---
map <C-UP> :tabprevious<CR>
map <C-DOWN> :tabnext<CR>
noremap <C-left> <C-W>t
noremap <C-right> <C-W>b

map <C-F3> :tabnew<CR>
map <C-F4> :tabclose<CR>

map <F1> :bprev<CR>
map <F2> :bnext<CR>
map <F3> :tabnew<CR>
map <F4> :NERDTreeClose<CR>:Bdelete<CR>
map <S-F4> :NERDTreeClose<CR>:bw<CR>
map <F6> :tabclose<cr>
map <F10> :quitall <CR>

" --- Colorscheme toggles ---
map <F11> :colorscheme zellner<CR>
map <S-F11> :colorscheme desert<CR>

" --- Sessions (own paths so Vim and Neovim sessions never collide) ---
map <F12> :mksession! ~/tmp/nvim.session<CR>
autocmd VimLeavePre * silent mksession! ~/tmp/lastNvimSession.vim

" --- Plugins / toggles ---
noremap <F8> :NERDTreeToggle<cr>
noremap <F9> :set list!<cr>
nnoremap <F7> :UndotreeToggle<CR>

" --- Leader-number equivalents for the F-keys (keyboards without F-row) ---
map <leader>1 :bprev<CR>
map <leader>2 :bnext<CR>
map <leader>3 :tabnew<CR>
map <leader>4 :NERDTreeClose<CR>:Bdelete<CR>
map <leader>6 :tabclose<cr>
nnoremap <leader>7 :UndotreeToggle<CR>
noremap <leader>8 :NERDTreeToggle<cr>
noremap <leader>9 :set list!<cr>
map <leader>0 :quitall<CR>
" <leader>5 reuses the per-filetype <F5> run/compile mapping below.
nmap <leader>5 <F5>

map <S-DOWN> <DOWN>
map <S-UP> <UP>
map <C-L> :CtrlPBuffer<CR>
map <C-\> :CtrlPMRUFiles<CR>

imap <C-@> <C-X><C-O>           " omni-completion trigger

" --- Build / lint (<S-F5>) ---
map <S-F5> <esc>:make<CR>

" --- Leader maps ---
" Save a file as root via sudo.
nnoremap <leader>es :w! /tmp/sudoSave \| let $fileToSave=expand('%') \| let $fileToSaveBackup=expand('%').'~' \| !sudo cp $fileToSave $fileToSaveBackup && sudo cp /tmp/sudoSave $fileToSave<CR><ESC>:e!<CR>

" <leader>f: if a real file is open, reveal it in the tree (NERDTreeFind).
" Otherwise (empty/no buffer at startup) open the tree rooted at the CWD
" instead of letting NERDTreeFind drift up into the parent directory.
nnoremap <silent> <leader>f :call LeaderFindOrCWD()<CR>

map <leader>ti :%! tidy -config ~/.config/nvim/tidy.conf <CR>
vmap <leader>ti :! tidy -config ~/.config/nvim/tidy.conf <CR>

vmap <leader>li :Linediff<CR>
map <leader>lr :LinediffReset<CR>

map <leader>ru :setlocal spell spelllang=ru<CR>
map <leader>en :setlocal spell spelllang=en<CR>

" Strip trailing whitespace + tidy braces + retab.
map <leader>sp :%s/\s\+$//e<CR> :%s@\v[\r\n]\s*\{@ {@ge<CR> :retab<CR>

nnoremap <C-F7> <Plug>VimwikiDiaryPrevDay
nmap <C-x>G :call GitGrepWord()<CR>

" ============================================================================
" COMMANDS / ABBREVIATIONS
" ============================================================================
command! -bang -bar Q :q<bang>
command! -bar -nargs=* -bang W :write<bang> <args>
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq

" ============================================================================
" PLUGIN CONFIGURATION
" ============================================================================
" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeHighlightCursorline=0

" delimitMate
let delimitMate_expand_cr = 1       " place cursor on its own line inside {}
let delimitMate_expand_space = 1    " { x } instead of { x} on space

" indent-guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size =1

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 'h'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](lib[\/]vendor|cache|web|plugins|test)$',
    \ }
let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

" indenthtml
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" linediff
let g:linediff_first_buffer_command  = 'tabnew'
let g:linediff_second_buffer_command = 'rightbelow new'

" vim-go
let g:go_auto_sameids =1

" gist / pastebin
let g:gist_get_multiplefile = 1
let g:pastebin_browser_command = ''
" Personal API keys (e.g. g:pastebin_api_dev_key) live in a gitignored local
" file so they never enter git history. See local.vim.example for the template.
let s:local = stdpath('config') . '/local.vim'
if filereadable(s:local) | execute 'source ' . s:local | endif

" vimwiki
let g:vimwiki_list = [{'path': '~/.vimwiki/'}]

" ============================================================================
" FILETYPES / AUTOCOMMANDS
" ============================================================================
au BufNewFile,BufRead *.yaml,*.yml setf yaml | let b:did_indent = 1
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType go set nolist

" Per-language <F5> = run / compile.
au FileType sml        map <F5> <esc>:!sml %<CR>
au FileType javascript map <F5> <esc>:!node %<CR>
au FileType python     map <F5> <esc>:!python3 %<CR>
au FileType haskell    map <F5> <esc>:w<CR>:!ghci %<CR>
au FileType lhaskell   map <F5> <esc>:!ghci %<CR>
au FileType groovy     map <F5> <esc>:!groovy %<CR>
au FileType ruby       map <F5> <esc>:!ruby %<CR>
au FileType go         map <F5> <esc>:GoRun<CR>

" ============================================================================
" FUNCTIONS
" ============================================================================
" <leader>f helper: reveal current file, or open tree at CWD if no file.
function! LeaderFindOrCWD()
  if empty(expand('%')) || !filereadable(expand('%'))
    execute 'NERDTree'
  else
    execute 'NERDTreeFind'
  endif
endfunction

" CtrlP: <C-@> deletes the buffer under the cursor in the buffer list.
function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

" :G <pattern> -- '*.c'   git grep wrapper
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

" git grep the word under the cursor (Ctrl-X G).
func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
