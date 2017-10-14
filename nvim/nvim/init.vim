" Commands.
" =========
"
" <leader> f - toggle NERD tree
" <leader> v - NERD tree in this folder
" <leader> be - buffer explorero
" <leader> bt - buffer explorero in new tab
" <leader> ba - buffer explorero in new hor split
" <leader> bv - buffer explorero in new vert split
" <leader> b - tags explorer
" <leader> . - ctrlp tags
"
" q: - show history
" Ctrl-p in edit mode - autocomplete looking up in the file
" Ctrl-n in edit mode - autocomplete looking down in the file
" Ctrl-] go to tag
" Ctrl-W Ctrl-] go to tag in new window
" g Ctrl-] tag select
" Ctrl-W } preview tag
" :ts /<pattern> searches tags for pattern
"
"
" Plugins
" =======
"
" To use:
" Reload init.vim and :PlugInstall to install plugins.
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
"
"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'git://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/jlanzarotta/bufexplorer.git'
Plug 'git://github.com/majutsushi/tagbar'

" Initialize plugin system
call plug#end()
" End of plugins

"""""""""""""""
" Vim settingss
"""""""""""""""
set hidden
set spelllang=en_gb

""""""""
" Colour
""""""""
syntax enable
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors = 256
let g:solarized_termtrans = 0
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""
" From http://nerditya.com/code/guide-to-neovim/
"""""""""""""""""""""""""""""""""""""""""""""""
let mapleader="\<SPACE>"

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

"""""""""""""""""""""""""""""""""""""""""""""""
" Airline - status bar
"""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_y =  '%{getcwd()}'
"let g:airline_section_d =  '%-10.3n\'
"let g:airline#extensions#tabline#buffer_nr_show = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher
"""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
    let g:EclimLocateFileNonProjectScope = 'ag'
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom key mapping
"""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agj silent! grep! -G.*java <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjs silent! grep! -G.*js <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjt silent! grep! -G.*Test\.java <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agsql silent! grep! -G.*sql <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjnt silent! grep! -G'^.*/src/main/java/.*\.java$' <args>|cwindow|redraw!
