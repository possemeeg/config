syntax enable

au BufNewFile,BufRead *.tsx set syntax=javascript
au BufNewFile,BufRead *.ts set syntax=javascript

"colorscheme desert
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors = 16
let g:solarized_termtrans = 1
colorscheme solarized

set ruler
set incsearch
set scrolloff=3
set wildmode=longest,list

set number
set softtabstop=4 shiftwidth=4 expandtab
set noswapfile

set laststatus=2
set statusline=%{getcwd()}                   " current working directory
set statusline+=\ -\                           " right align remainder  
set statusline+=%f\                          " filename   
set statusline+=%h%m%r%w                     " status flags  
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
set statusline+=%=                           " right align remainder  
"set statusline+=0x%-8B                       " character value  
set statusline+=%-14(%l,%c%V%)               " line, character  
set statusline+=%<%P                         " file position 

set hidden

set diffopt+=iwhite

"hi CursorLine   cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkred guifg=white
"colours
"
"General commands
command! Clqf call setqflist([]) 

" formatiing
com! FormatJSON %!python -m json.tool

" tabs
nnoremap td  :tabclose<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

"For eclim
filetype plugin indent on
set completeopt-=preview
let g:EclimLocateFileDefaultAction = 'edit'

"Ctrlp
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_working_path_mode = '0'

"Scratch
let g:scratch_autohide = '0'

" The Silver Searcher
if executable('ag')
    let g:EclimLocateFileNonProjectScope = 'ag'
    set grepprg=ag\ --path-to-agignore\ ~/.agignore\ -U\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0

    " bind <Leader> (backward slash) to grep shortcut
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Aghere silent! grep! <args> %:p:h|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agj silent! grep! -G.*\.java$ <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agkt silent! grep! -G.*\.kt$ <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agjs silent! grep! -G.*\.js$ <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agjt silent! grep! -G.*Test\.java$ <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agsql silent! grep! -G.*sql <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Agjnt silent! grep! -G'.*(?<!Test|IT).java$' <args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Fjc silent! grep! -G'<args>.*\.java$' class.*<args>|cwindow|redraw!
    command! -nargs=+ -complete=file -bar Fji silent! grep! -G'<args>.*\.java$' interface.*<args>|cwindow|redraw!

endif

"ctags
"
command! GenerateTags call system('ctags -Rf ./.tags --python-kinds=-i --exclude=.git `cat .srclist`') | echo
let g:Tlist_WinWidth=65

"Find files

set tags+=.tags
command! -nargs=+ T exec "normal! i<args>"
command! -nargs=+ Tr exec "normal! i<args><cr>"
command! -nargs=+ Tre exec "normal! i<args> | tee ~/.vimerrors<cr>" | set makeprg=cat\ ~/.vimerrors | make

" Read quickfix from file
" :cf[ile][!] [errorfile] 
"      Read the error file and jump to the first error.
"      This is done automatically when Vim is started with
"      the -q option.  You can use this command when you
"      keep Vim running while compiling.  If you give the
"      name of the errorfile, the 'errorfile' option will
"      be set to [errorfile].  See |:cc| for [!].
" 
" :cg[etfile] [errorfile] 
"      Read the error file.  Just like ":cfile" but don't
"      jump to the first error.

set errorfile=~/.vim/errors
set errorformat=[ERROR]\ %f:[%l\\,%v]\ %m,%-G%.%#
set errorformat+=%-G%.%# " only matching lines show see "-G" in documentation
"set errorformat=NOTHINGSHOULDMATCH
"set errorformat=
"            \[%tRROR]\ %#Malformed\ POM\ %f:\ %m@%l:%c%.%#,
"            \[%tRROR]\ %#Non-parseable\ POM\ %f:\ %m\ %#\\@\ line\ %l\\,\ column\ %c%.%#,
"            \[%[A-Z]%#]\ %f:[%l\\,%c]\ %t%[a-z]%#:\ %m,
"            \[%t%[A-Z]%#]\ %f:[%l\\,%c]\ %[%^:]%#:\ %m,
"            \%A[%[A-Z]%#]\ Exit\ code:\ %[0-9]%#\ -\ %f:%l:\ %m,
"            \%A[%[A-Z]%#]\ %f:%l:\ %m,
"            \%-Z[%[A-Z]%#]\ %p^,
"            \%C[%[A-Z]%#]\ %#%m


"" POM related messages
"set errorformat=%E[ERROR]\ %#Non-parseable\ POM\ %f:\ %m\ %#\\@\ line\ %l\\,\ column\ %c%.%#,%Z,
"set errorformat+=%+E[ERROR]\ %#Malformed\ POM\ %f:%m\ %#\\@\ %.%#\\,\ line\ %l\\,\ column\ %c%.%#,%Z,
"" Java related build messages
"set errorformat+=%+I[INFO]\ BUILD\ %m,%Z
"set errorformat+=%E[ERROR]\ %f:[%l\\,%c]\ %m,%Z
"set errorformat+=%A[%t%[A-Z]%#]\ %f:[%l\\,%c]\ %m,%Z
"set errorformat+=%A%f:[%l\\,%c]\ %m,%Z
"" jUnit related build messages
"set errorformat+=%+E\ \ %#test%m,%Z
"set errorformat+=%+E[ERROR]\ Please\ refer\ to\ %f\ for\ the\ individual\ test\ results.
"" Misc message removal
"set errorformat+=%-G%.%#,%Z
"set makeprg=cat\ ~/.vimerrors



" jad
so ~/.vim/plugin/jad.vim

function! Current_class_full()
    let line = search('^package\s\+[a-zA-Z_\.]*\s*;\s*$')
    if line > 0 
        return get(split(getline(line), '[ ;]\+'),1) . '.' . get(split(expand('%:t'), '\.'),0)
    end
endfunction

function! Current_class()
        return get(split(expand('%:t'), '\.'),0)
    end
endfunction

"sessions


" Deletes the hidden buffers.
function! s:delete_hidden_buffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

nnoremap <silent> <leader>bd :call <SID>delete_hidden_buffers()<CR>

function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

function! FindFile(pattern, patterntype, targettype, maxdepth)
    let files = system('find . -type '.a:targettype.'  -'.a:patterntype.' "'.a:pattern.'" -maxdepth '.a:maxdepth.' -not -path "*/target/*"')
    let filelist = split(files, "\n")
    let items = []
    for fl in filelist
        call add(items, {'filename': fl, 'lnum': 1, 'col': 1, 'type': '', 'text': fl })
    endfor
    call setqflist(items)
endfunction
"
:command! -nargs=+ Ff call FindFile("<args>", "name", "f", 8) | :copen
:command! -nargs=+ Ffp call FindFile("*<args>*", "name", "f", 8) | :copen
:command! -nargs=+ Ffi call FindFile("<args>", "iname", "f", 8) | :copen
:command! -nargs=+ Ffr call FindFile("<args>", "regex", "f", 8) | :copen
:command! -nargs=+ Ffri call FindFile("<args>", "iregex", "f", 8) | :copen
:command! -nargs=+ Ll call FindFile("<args>", "name", "f", 1) | :copen

:command! Lcdh lcd %:p:h
:command! Lcdb1 lcd %:p:h:h
:command! Lcdb2 lcd %:p:h:h:h
:command! Lcdb3 lcd %:p:h:h:h:h
:command! Lcdb4 lcd %:p:h:h:h:h:h
:command! Lcdb5 lcd %:p:h:h:h:h:h:h
:command! Lcdb6 lcd %:p:h:h:h:h:h:h:h
:command! Lcdb7 lcd %:p:h:h:h:h:h:h:h:h
:command! Lcdb8 lcd %:p:h:h:h:h:h:h:h:h:h
:command! Lcdb9 lcd %:p:h:h:h:h:h:h:h:h:h:h
"
":echo qfl
"[{'lnum': 18, 'bufnr': 33, 'col': 9, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ': * or a custom serializer that generates custom JSON.'}, {'lnum': 31, 'bufnr': 62, 'col': 35, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ':@
"UseLightweightSerialization("Has custom serializer")'}]
"

" Highlight current line
" augroup CursorLine
"     au!
"     au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"     au WinLeave * setlocal nocursorline
" augroup END

" Mappings
"
"General
nnoremap <leader>l :call RestoreSession("temp-session.vim")<CR>
nnoremap <Leader>a :set cursorline!<CR>
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
nnoremap <Leader>- :e#<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>ypc ma:let @" = Current_class_full()<CR>'a:echo @"<CR>
nnoremap <Leader>yc :let @" = Current_class()<CR>:echo @"<CR>
nnoremap <Leader>agj :Agj <C-R><C-W><CR>
nnoremap <Leader>agjnt :Agjnt <C-R><C-W><CR>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <Leader>ico :let @z = Current_class()<CR>ipublic class <C-R>z {<CR><CR>}<esc>
nnoremap <Leader>icc :let @z = Current_class()<CR>i    public <C-R>z() {<CR><CR>}<esc>

" Tags
nnoremap <F5> :GenerateTags<CR>
nnoremap <leader>t :TlistToggle<CR>

" Eclim
nnoremap <leader>x :ProjectProblems!<CR>
nnoremap <leader>c :JavaCallHierarchy<CR>
nnoremap <leader>h :JavaHierarchy<CR>
nnoremap <leader>p :ProjectsTree<CR>
nnoremap <leader>i :JavaImport<CR>

" bind K to grep word under cursor
nnoremap <leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Java
" nnoremap <leader>g :exe 'vim /\<<C-R><C-W>\>/ **/*.' . expand("%:e")<CR>

"crontab doesn't like these settings. So before doing
"crontab -e
"uncomment the lines below
"
"set nobackup
"set nowritebackup

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
