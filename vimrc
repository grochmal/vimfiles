" .vimrc

" plugins and base {{{
set nocompatible
"execute pathogen#infect()
"packloadall
filetype plugin indent on
syntax on
colorscheme elflord
"}}}

" calendar.vim {{{
let g:calendar_locale = 'en'
let g:calendar_date_endian = 'big'
let g:calendar_date_separator = '-'
let g:calendar_week_number = 1
let g:calendar_frame = 'default'
let g:calendar_cache_directory = expand('~/.vim/cache/calendar/')
"}}}

" common to all files {{{
function! Marks()
  set listchars=eol:\|,tab:@>,trail:%
  set list
  set number
  set numberwidth=4
  set wrap
  set linebreak
endfunction

function! Clear()
  set nolist
  set nonumber
endfunction

call Marks()

set norelativenumber
set shiftround
set shiftwidth=4
set noshowmatch
set matchpairs=(:),[:],{:},<:>
set showbreak=+++\   " the \ escapes a space
set iskeyword=@,48-57,@-@,_,-,192-255
set foldlevelstart=1
set encoding=utf-8

set wildchar=<tab>
set wildmenu

" this is a little dangerous, since changes to files
" can be abandoned, but it works nicely with netrw
set hidden
set noautowrite

" works well on urxvt and xterm
set mouse=a
"}}}

" colours and highlights {{{
set noautoindent

set showcmd
set noignorecase
set incsearch
if !&hlsearch
  set hlsearch
  nohlsearch
endif
"set showmatch
"set smartcase

hi LongText term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
match LongText '\%80v.'
set textwidth=79
set modelines=6

"}}}

" commands {{{
command! -nargs=1 -range Decr <line1>,<line2>s/\d\+/\=printf('%0*d',
  \ len(submatch(0)), submatch(0) - <args>)
":%!xxd     " hex editor
":%!xxd -r  " restore from hex
"}}}

" common mappings {{{
let mapleader = '-'
let maplocalleader = ','

" select a single word
nnoremap <leader><space> viw
"nnoremap <leader>d dd
"nnoremap <leader>c ddO
nnoremap <leader>u viwU
nnoremap <leader>~ viw~
inoremap <c-u> <esc>viwUi

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>

onoremap p i(
onoremap " i"
onoremap ' i'

onoremap b /return<cr>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap al( :<c-u>normal! F(va(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>
onoremap al{ :<c-u>normal! F{va{<cr>

" change the next email address
onoremap in@ :<c-u>execute "normal! "
  \. "/[A-Za-z0-9!#$%&'*+-/=?^_`{\|}~.]\\+@[A-Za-z0-9.]\\+\r"
  \. ":nohlsearch\rv//e\r"<cr>

function! RightSplit()
  if '' ==# bufname('#')
    echom 'No alternate buffer'
  else
    execute "rightbelow vsplit " . bufname('#')
  endif
endfunction
nnoremap <leader>sp :call RightSplit()<cr>

" highlight trailing spaces
nnoremap <leader>wt :match ErrorMsg /\v\s+$/<cr>
nnoremap <leader>wl :match LongText /\%80v./<cr>
nnoremap <leader>wc :match none<cr>

" always used very magic
nnoremap / /\v

" nohlsearch
nnoremap <leader>nh :nohlsearch<cr>

" toogle foldcolumn
function! FoldColumnToogle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction
nnoremap <leader>f :call FoldColumnToogle()<cr>

" toogle the quickfix window
let g:quickfix_is_open = 0
let g:quickfix_return_to_window = 1
function! QuickfixToogle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
nnoremap <leader>q :call QuickfixToogle()<cr>

" tab completion: addon on ins-completion, prevent completion in first position
let g:tab_completion_keys = "\<c-x>\<c-p>"
function! TabCompletion()
  let l:col = max([col('.')-1, 1])
  let l:char = matchstr(getline('.'), '\%' . l:col . 'c.')
  if l:col != 1 && l:char =~# '\k'
    return g:tab_completion_keys
  else
    return "\<tab>"
  endif
endfunction
inoremap <expr> <tab> TabCompletion()
"}}}

" spelling and abbreviations{{{
function! Abbrev()
  iabbrev adn and
  iabbrev teh the
  iabbrev waht what
  iabbrev tehn then
  iabbrev @@@ NmiOke@gSroPchAmal.oMrg
  iabbrev ccopy Copyright (C) Michal Grochmal
  iabbrev ssig -- <cr>Mike Grochmal<cr>key ID 0xC840C4F6
endfunction

call Abbrev()

cabbrev h tab help

" abclear  " removes abbreviations
"}}}

" status line {{{

set laststatus=2

" tail of file name (last part of file name)
set statusline=%t
" buffer number
set statusline+=[%n]
" modified flag
set statusline+=%m
" readonly flag
set statusline+=%r
" fileformat (unix, dos, mac)
set statusline+=[%{&ff}]
" filetype
set statusline+=%y
" left align / right align separator
set statusline+=%=  " %#TabLineFill#%=
" column number, virtual column number
set statusline+={%c%V}  " %#StatusLine#{%c%V}
" line number / total lines
set statusline+=[%l/%L]
" byte number in file
set statusline+=[0x%O]
" value of byte under cursor
set statusline+={0x%B}
" percentage through file
set statusline+=%P

"}}}

" quickfix {{{
"nnoremap <leader>g :silent execute "grep! -R "
"  \. shellescape(expand('<cWORD>')) . " ."<cr>:7copen<cr><c-l>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>
"}}}

" netrw {{{
"
" tree listing
let g:netrw_liststyle=3
" suppress banner
let g:netrw_banner=0
" moved current working directory with netrw
let g:netrw_keepdir=0
" open files in the other window
let g:netrw_chgwin=2
" keep the netrw window small
let g:netrw_winsize=22
" limit filenames to the window size
let g:netrw_maxfilenamelen=22
" do not care about directory history
let g:netrw_dirhistmax=1
" ignore Vim swap files
let g:netrw_list_hide= '.*\.swp$'
" use left vertical split
nnoremap <leader>l :Lexplore<cr>

"}}}

" skk {{{
"set complete=s~/vim/skk/skk-jisyo-utf-8.l
"let g:skk_jisyo = '~/vim/skk/priv.skk'
"let g:skk_large_jisyo = '~/vim/skk/skk-jisyo-utf-8.l'
"let g:skk_initial_mode = 'hira'
"let g:skk_script = '~/vim/skk/skk.vim'

"set completeopt=menuone,preview
"set thesaurus=~/vim/skk/skk-jisyo-utf-8.l

"function! ToogleMode()
"  if 'hira' ==# g:skk_initial_mode
"    let g:skk_initial_mode = 'kata'
"  else
"    let g:skk_initial_mode = 'hira'
"  endif
"  execute "source " . g:skk_script
"endfunction
"}}}

" tabs {{{

set showtabline=2

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

" }}}

" Write a proper colorscheme someday
"hi StatusLineNC term=bold,reverse cterm=bold,reverse gui=reverse
"hi TabLineFill term=bold,reverse cterm=bold,reverse gui=bold,reverse
"hi VertSplit term=bold,reverse cterm=bold,reverse gui=bold,reverse

" vimscript {{{
function! FtVim()
  setlocal expandtab shiftwidth=2 softtabstop=2
  setlocal foldmethod=marker
  nnoremap <buffer> <localleader>c I"<esc>
  iabbrev <buffer> ffun function
endfunction
"}}}

" newrt {{{
function! FtNetrw()
  setlocal nolist expandtab shiftwidth=2 softtabstop=2
endfunction
"}}}

" python {{{
function! FtPython()
  setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
  " comment line
  nnoremap <buffer> <localleader>c I#<esc>
  " cut and produce condition
  nnoremap <buffer> <localleader>cc ^wC:<esc><left>i
  " runs visually marked code with vim's python
  vnoremap <localleader>p y:<c-r>"<c-b>python3 <cr>
  iabbrev <buffer> iff if:<left>
  iabbrev <buffer> yy yay
endfunction
"}}}

" shell {{{
function! FtShell()
  setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
  " comment line
  nnoremap <buffer> <localleader>c I#<esc>
endfunction
"}}}

" c/cpp {{{
function! FtC()
  setlocal noexpandtab shiftwidth=8
  setlocal cindent comments=sr:/*,mb:*,ex:*/,://
  nnoremap <buffer> <localleader>c I/*<esc>A*/<esc>0
endfunction
"}}}

" javascript {{{
function! FtJavaScript()
  setlocal expandtab shiftwidth=2 softtabstop=2 autoindent
  setlocal comments=sr:/*,mb:*,ex:*/,://
  nnoremap <buffer> <localleader>c I//<esc>
endfunction
"}}}

" sql {{{
function! FtSql()
  setlocal expandtab shiftwidth=2 softtabstop=2
  nnoremap <buffer> <localleader>c I--<esc>
  iabbrev <buffer> ssel select
endfunction
"}}}

" java {{{
function! FtJava()
  setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
  nnoremap <buffer> <localleader>c I//<esc>
  iabbrev <buffer> iff if ()<left>
endfunction
"}}}

" markdown {{{
function! FtMarkdown()
  setlocal expandtab shiftwidth=4 softtabstop=4
endfunction
"}}}

" xml/html {{{
function! FtXml()
  setlocal expandtab shiftwidth=2 softtabstop=2
  nnoremap <buffer> <localleader>f Vatvf
  iabbrev <buffer> --- &mdash;
  iabbrev <buffer> << &lt;
  iabbrev <buffer> >> &gt;
endfunction
"}}}

" filetype autocmds {{{
if has("autocmd")
  augroup filetype_vimrc
    autocmd!
    autocmd FileType vim call FtVim()
    autocmd FileType netrw call FtNetrw()
    autocmd FileType python call FtPython()
    autocmd FileType sh call FtShell()
    autocmd FileType c,cpp call FtC()
    autocmd FileType javascript call FtJavaScript()
    autocmd FileType sql call FtSql()
    autocmd FileType java call FtJava()
    autocmd FileType markdown call FtMarkdown()
    autocmd FileType html call FtXml()
    autocmd FileType xml call FtXml()
  augroup end
endif
" }}}

" junk {{{
" things that are only here as POCs

let g:abook_prevbuf = 0
let g:abook_buf = 0

" creates a special buffer
function! MkAbook()
  let g:abook_prevbuf = bufnr('%')  " save current buffer
  if g:abook_buf
    execute 'buffer ' . string(g:abook_buf)
  else
    edit [abook]
  endif
  setlocal buftype=nofile
  setlocal nomodifiable
  setlocal filetype=abook
  setlocal nobuflisted
  call AbookDraw()
endfunction

" fakes a change in buffer
function! AbookDraw()
  let b:dict = {
  \   'header1' : 'content1'
  \ , 'header2' : 'content2'
  \ }
  setlocal modifiable
  " clear the buffer
  normal ggdG
  put! ='abook list'
  put  ='=========='
  put  =''
  for k in keys(b:dict)
    put ='[' . k . ']'
    put =b:dict[k]
    put =''
  endfor
  setlocal nomodifiable
  setlocal nomodified
endfunction

function! Abook()
  nnoremap Q :execute 'buffer' . string(g:abook_prevbuf)<cr>
endfunction

augroup filetype_abook
  autocmd!
  autocmd FileType abook call Abook()
augroup end

nnoremap <leader>a :call MkAbook()<cr>

"}}}

" terminal sheaningans {{{
"let &t_SI = "\<esc>[5 q"
"let &t_SR = "\<esc>[5 q"
"let &t_EI = "\<esc>[2 q"

"let &t_SI = "\<esc>[5 q"
"let &t_SR = "\<esc>[5 q"
"let &t_EI = "\<esc>[2 q"
"au InsertEnter * silent execute "!echo -en \<esc>[5 q"
"au InsertLeave * silent execute "!echo -en \<esc>[2 q"

"}}}

" load all packages so they overwrite the ones from the Vim distribution
packloadall

