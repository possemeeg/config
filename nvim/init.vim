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
" Extra Commands
" ==============
" Format json ->
" :execute '%!python3 -m json.tool'
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

Plug 'git://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'leafoftree/vim-vue-plugin'

" Initialize plugin system
call plug#end()
" End of plugins

"""""""""""""""
" Vim settingss
"""""""""""""""
set hidden
set spelllang=en_gb
set relativenumber
 
"""""""""""""""
" highlight column 101 
"""""""""""""""
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

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
set shiftwidth=4        " Indentation amount for < and > commands.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
" set esckeys             " Cursor keys in insert mode.
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
"let g:airline_section_y =  '%{getcwd()}'
"let g:airline_section_d =  '%-10.3n\'
let g:airline_section_y =  '%n'
let g:airline#extensions#tabline#buffer_nr_show = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher
"""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
    let g:EclimLocateFileNonProjectScope = 'ag'
    set grepprg=ag\ --case-sensitive\ --path-to-ignore\ ~/pmg/config/vimagignore\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom key mapping
"""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>b :TagbarToggle<CR>
nnoremap <leader>gs mawv/ <CR>"ty/ <CR>wvwh"ny/getters<CR>$a<CR><CR><Esc>xxapublic<Esc>"tpa<Esc>"npbiget<Esc>l~ea()<CR>{<CR><Tab>return<Esc>"npa;<CR>}<Esc>=<CR><Esc>/setters<CR>$a<CR><CR><Esc>xxapublic void<Esc>"npbiset<Esc>l~ea(<Esc>"tpa <Esc>"npa)<CR>{<CR><Tab>this.<Esc>"npa=<Esc>"npa;<CR>}<Esc>=<CR>`ak

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agj silent! grep! -G.*java <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjs silent! grep! -G.*js <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjt silent! grep! -G.*Test\.java <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agsql silent! grep! -G.*sql <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Agjnt silent! grep! -G'^.*/src/main/java/.*\.java$' <args>|cwindow|redraw!
