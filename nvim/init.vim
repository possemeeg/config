" Commands.
" =========
"
" <keader> f - toggle NERD tree
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
" Python remote plugs rplugin
" ==========================
" :UpdateRemotePlugins
"
" Plugins
" =======
"
" To use:
" Reload init.vim and :PlugInstall to install plugins.
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" python env
" pip install 
let g:python3_host_prog = "~/config/nvim/py-env/neovim/bin/python"

let g:maplocalleader = "\<SPACE>"

packadd vimball

call plug#begin('~/.local/share/nvim/plugged')

Plug 'git://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'leafoftree/vim-vue-plugin'
"Plug 'plasticboy/vim-markdown'

Plug 'freitass/todo.txt-vim'
" Sorting tasks:
" <localleader>s Sort the file
" <localleader>s+ Sort the file on +Projects
" <localleader>s@ Sort the file on @Contexts
" <localleader>sd Sort the file on dates
" <localleader>sdd Sort the file on due dates
" 
" Edit priority:
" <localleader>j Decrease the priority of the current line
" <localleader>k Increase the priority of the current line
" <localleader>a Add the priority (A) to the current line
" <localleader>b Add the priority (B) to the current line
" <localleader>c Add the priority (C) to the current line
" 
" Date:
" <localleader>d Set current task's creation date to the current date
" date<tab> (Insert mode) Insert the current date
" 
" Mark as done:
" <localleader>x Mark current task as done
" <localleader>X Mark all tasks as done
" <localleader>D Move completed tasks to done.txt 


" Initialize plugin system
call plug#end()
" End of plugins


"""""""""""""""
" Vim settingss
"""""""""""""""
set hidden
set spelllang=en_gb
set relativenumber
"set autochdir
set tags=/home/peter/Development/tags
set clipboard=unnamedplus
"set diffopt=vertical,context:999
set diffopt=vertical
 
"""""""""""""""
" highlight column 101 
"""""""""""""""
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%101v.\+/

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


set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set nu                  " Show the line numbers on the left side.
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
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'
" "let g:airline_section_y =  '%{getcwd()}'
" "let g:airline_section_d =  '%-10.3n\'
" let g:airline_section_y =  '%n'
" let g:airline#extensions#tabline#buffer_nr_show = 1
" function! WindowNumber(...)
"     "let builder = 
"     "let context = a:2
"     call a:1.add_section('airline_b', ' %{tabpagewinnr(tabpagenr())} ')
"     return 0
" endfunction
" call airline#add_statusline_func('WindowNumber')
" call airline#add_inactive_statusline_func('WindowNumber')

"""""""""""""""""""""""""""""""""""""""""""""""
" status bar
"""""""""""""""""""""""""""""""""""""""""""""""
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

"function! IsMouseOn()
"    return system("EN=''; for d in $(xinput list | ag 'Prestigio.*pointer' |ag -o 'id=([^\s]+)' |ag -o '[0-9]+'); do if [ $(xinput list-props $d | ag 'Device Enabled' |ag -o ':.*' | ag -o [0-9]+) == 1 ]; then EN='---MOUSE ON---'; break; fi; done; echo $EN | tr -d '\n'")
"endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

highlight ModifiedColour ctermfg=White ctermbg=DarkRed
highlight FilenameColour ctermfg=Gray ctermbg=Black
highlight WarningColour ctermfg=White ctermbg=Red

set statusline=
set statusline+=%n\ │\ %{winnr()}\ ║ 
set statusline+=%#CursorColumn#
set statusline+=%#WarningColour#
"set statusline+=%{IsMouseOn()}
set statusline+=%#FilenameColour#
set statusline+=\ %f
set statusline+=%#ModifiedColour#%{&mod?'\ [MOD]\ ':''}%*
set statusline+=%#FilenameColour#
set statusline+=%=
set statusline+=%#LineNr#
set statusline+=%#CursorColumn#
set statusline+=\ %y\ ║
set statusline+=\ %p%%\ ║
set statusline+=\ %l│%c
set statusline+=\ 

"""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher
"""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
    set grepprg=ag\ --case-sensitive\ --path-to-ignore\ ~/pmg/config/vimagignore\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom key mapping
"""""""""""""""""""""""""""""""""""""""""""""""

nmap <LocalLeader>q :q<CR>
nmap <LocalLeader>e :Ex<CR>
nmap <LocalLeader>w :update<CR>
nmap <LocalLeader>bd :bd<CR>
nmap <LocalLeader>/ :noh<CR>
nmap <LocalLeader>1 1w
nmap <LocalLeader>2 2w
nmap <LocalLeader>3 3w
nmap <LocalLeader>4 4w
nmap <LocalLeader>5 5w
nmap <LocalLeader>6 6w
nmap <LocalLeader>7 7w
nmap <LocalLeader>8 8w
nmap <LocalLeader>9 9w
nmap <LocalLeader>cn :cn<CR>
nmap <LocalLeader>cN :cN<CR>
nmap <LocalLeader>! 1gt
nmap <LocalLeader>@ 2gt
nmap <LocalLeader># 3gt
nmap <LocalLeader>$ 4gt
nmap <LocalLeader>% 5gt
nmap <LocalLeader>^ 6gt
nmap <LocalLeader>& 7gt
nmap <LocalLeader>* 8gt
nmap <LocalLeader>( 9gt
nmap <LocalLeader>n :set rnu!<CR>
nmap <LocalLeader>N :set nornu!<CR>
nmap <LocalLeader>A :Ag -w <CR>
nmap <LocalLeader>a :Ag <CR>
nmap <LocalLeader>cd :cd %:p:h<CR>:pwd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:
autocmd FileType yaml setlocal indentkeys-=<:>
autocmd FileType yaml setlocal indentkeys-=:
autocmd FileType yaml setlocal indentkeys-=0#
autocmd FileType html setlocal indentkeys-=<:>
autocmd FileType html setlocal indentkeys-=:

" netrw
let g:netrw_localrmdiropt=' -r'
let g:netrw_localcopycmdopt=' -r'
let g:netrw_localmovecmdopt=' -r'
let g:netrw_preview   = 1
let g:netrw_alto      = 0
let g:netrw_liststyle = 0
let g:netrw_winsize   = 80

"" so :find works with paths of current open buffers
"" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
"let s:default_path = escape(&path, '\ ') " store default value of 'path'
"
"" Always add the current file's directory to the path and tags list if not
"" already there. Add it to the beginning to speed up searches.
"autocmd BufRead *
"      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
"      \ exec "set path-=".s:tempPath |
"      \ exec "set path-=".s:default_path |
"      \ exec "set path^=".s:tempPath |
"      \ exec "set path^=".s:default_path
"
" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  echo a:filename.' - '.error_file
  call system('find . -name "'.a:filename.'" -printf "%p:1:1:%f\n" > '.error_file)
  exe 'cfile '. error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 Find call FindFiles(<q-args>)

" this allows alias in bash commands
set shellcmdflag=-ic

