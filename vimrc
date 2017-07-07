" Bobby's  vimrc
" Jul 12, 2015 10:08 AM

if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

" Plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'heavenshell/vim-jsdoc'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-vinegar'
Plug 'diepm/vim-rest-console'
Plug 'vim-scripts/L9' | Plug 'vim-scripts/FuzzyFinder'
Plug 'gregsexton/Atom'
Plug 'gabesoft/vim-ags'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'mattn/gist-vim'
Plug 'scrooloose/syntastic'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kchmck/vim-coffee-script'
Plug 'Raimondi/delimitMate'
Plug 'maksimr/vim-jsbeautify'
Plug 'moll/vim-node'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'gabrielelana/vim-markdown'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'mattn/webapi-vim'
Plug 'jamestomasino/vim-writeroom'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'git://github.com/xolox/vim-misc.git' | Plug 'git://github.com/xolox/vim-notes.git'
Plug 'tpope/vim-unimpaired'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'justinmk/vim-sneak'
Plug 'chankaward/vim-railscasts-theme'
Plug 'vim-scripts/desertEx'
Plug 'vim-scripts/proton'
Plug 'Lokaltog/vim-distinguished'
Plug 'itspriddle/vim-marked'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'moll/vim-bbye'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'morhetz/gruvbox'
Plug 'millermedeiros/vim-esformatter'
Plug 'HerringtonDarkholme/yats.vim'
" command-t build function {{{
function! BuildCommandT(info)
    echomsg "running commandt install function"
    if a:info.status != 'unchanged'
        !cd ruby/command-t && ruby extconf.rb && make
    else
        echomsg "commandt is unchanged, skipping install.."
    endif
endfunction
" }}}

Plug 'wincent/command-t', { 'do': function('BuildCommandT') }
Plug 'gilgigilgil/anderson.vim'
call plug#end()
"}}}

"  Appearance {{{

" make the most of 256-color terminals
if ($TERM == "screen" || $TERM =~ "256")
    set t_Co=256 t_kb=
endif

colorscheme gruvbox
set background=dark
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    " set guifont=Menlo\ for\ Powerline:h14
    set guifont=Source\ Code\ Pro:h13
    colorscheme gruvbox
else
endif
"  }}}

" Settings {{{

set nocompatible               " Be iMproved

let mapleader = "," 

" Use local bundles if available 
"if filereadable(expand("~/.vimrc.bundles"))
"    source ~/.vimrc.bundles
"endif

if has('folding')
    set foldmethod=syntax
endif

set runtimepath+=/Users/rarnold/vim-mpc
set runtimepath+=~/.vim/bundle/ctrlp.vim

set noswapfile " .swp is annoying
set autoindent
set smartindent
set nobackup
set diffopt=filler,icase,iwhite
set nocursorline
set hlsearch
set incsearch
set laststatus=2 "make sure status line always appears, regardless of splits
set ruler
set showcmd
set smartcase
set splitbelow splitright
set nostartofline
set statusline=%<%m%f:%l\ _%{winnr()}_\ %y%r%=<%b\ 0x%B>\ \ %c%V\ %P
set statusline=%m%f:%l/%L\ %P\ %<<%-3b\ 0x%-2B>\ %y%r%w%=b:%n\ w:%{winnr()}
set nowildmenu
set wildmode=list:longest,full
set hidden                          " Allow buffer switching without saving
set shell=zsh
set showmode
set relativenumber
set shiftwidth=4        " spaces for autoindents. also for '>> || <<'
set softtabstop=2
set tabstop=4
"set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces  let mapleader = ','


if has('syntax')
    syntax on
    highlight Folded     term=bold ctermfg=12 ctermbg=None
    "highlight CursorLine term=underline cterm=underline ctermbg=None ctermfg=11
endif

if has('eval')
    filetype plugin indent on
endif
"}}}

" Mappings {{{

" execute the current line of text as a shell command
noremap      Q !!$SHELL<CR>
" Use <C-L> to clear search highlighting as well as refresh the screen
noremap      <silent> <C-l> :nohlsearch <bar> redraw<CR>
inoremap     <silent> <C-l> <C-O>:nohlsearch <bar> redraw<CR>
" write from insert mode test
inoremap <C-s><C-s> :write<CR>
" delete word more easily in insert mode
inoremap <C-BS> <C-W>
noremap <leader>rf :call MyJSFormat()<CR>
" brett terpstra's marked 2
nnoremap mdp :MarkedOpen<CR>
" for vrc console plugin pop-up buffer
nnoremap <silent><leader>rq :bdelete __REST_response__<cr>

" reformat JS selection
vnoremap <C-j> :call MyRangeJSFormat()<CR>

nnoremap <C-p> :CtrlPBuffer<CR>
nmap <silent> <C-l> <Plug>(jsdoc)
"}}}

"commands/aliases {{{
if has('user_commands')
    " ive commented out some cool examples from unnovative.net's vimrc    
    " command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
    " command! -nargs=1 -complete=help Help      :help <args>
    " command! -nargs=1 -complete=help HElp      :help <args>
    command! -nargs=* -bar -bang Ls            :ls<bang>
    " command! -nargs=0 Noh       :noh
    command! -nargs=0 Date      :put ='* ' . strftime('%b %d, %Y %I:%M %p')
    " command! -nargs=? -bar      Underline    :put =repeat( len('<args>') > 0 ? '<args>' : '=', len(getline('.')))
    " command! -nargs=0 Max       :let [s:lines, s:columns] = [&lines, &columns] | set lines=999 columns=999
    command! -nargs=0 Taller    :let [s:lines, s:columns] = [&lines, &columns] |set lines=999
    command! -nargs=0 Wider     :let [s:lines, s:columns] = [&lines, &columns] |set columns=999
    " command! -nargs=0 Restore  :let [s:lines, s:columns, &lines, &columns] = [&lines, &columns, s:lines, s:columns]
    " command! -nargs=0 Merge /^\(<\|=\|>\)\{7}\ze\(\s\|$\)/
    command! -nargs=1 Locate call fzf#run(
                \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})

    command! FZFMru call fzf#run({
                \  'source':  v:oldfiles,
                \  'sink':    'e',
                \  'options': '-m -x +s',
                \  'down':    '40%'})
endif
"}}}

" Autocommands {{{
  
" vim rest console autocmd
" i janked up my folds and i don't want the response buffer folded
  augroup vrc_autocmds
      autocmd!
      autocmd BufWinEnter __REST_response__ execute "normal! zn"
      "" autocmd FileType rest noremap <silent><leader>rr :call RefreshToken()<cr>
  augroup END
  augroup mahTest
      autocmd!
      " autocmd BufWritePost *dynamo* !gulp test -f test/email_userdid_service.test.js
  augroup END

  augroup gofiles
      autocmd!
      autocmd FileType go execute "normal! zn"
  augroup END

  " augroup allFiles
  "     autocmd!
  "     autocmd if &filetype != "vim" |  execute "normal! zn" | endif
  " augroup END



  augroup filetype_javascript
      autocmd!
      "   autocmd BufWritePost *.js !mocha -C 
       " autocmd BufWritePost *.js !npm test
       " autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
       " autocmd User Node if &filetype == "javascript" | noremap <leader><leader>f "normal! ^f'gd"| endif
       autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin 
       " autocmd FileType javascript noremap <buffer> <c-f> :call MyJSFormat()<cr>
       " autocmd FileType javascript noremap <buffer>  <C-f> :call JsBeautify()<cr>
       " autocmd BufWrite if &filetype == "javascript" | :call MyJSFormat() | endif
       autocmd FileType javascript nmap <C-s>m :SyntasticToggleMode<cr>
       autocmd FileType typescript execute "normal! zR"
       autocmd FileType javascript nmap <C-s>c :SyntasticCheck<cr>
       autocmd User Node
                   \ if &filetype == "javascript" |
                   \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
                   \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
                   " npm install -g js-beautify
                   \   set equalprg=js-beautify |
                   \ endif
  augroup END

  " augroup filetype_rest
  "     autocmd!
  "     autocmd FileType rest  execute "normal! zn"
  " augroup END

"}}}

" Functions {{{

function! MyJSFormat()
    call JsBeautify()
    " jsBeautify doesn't honor spaces before functions, afaik 
    execute "silent! %s/function(/function (/g"
    " you have to double escape when using execute
    execute "silent! %s/function \\([a-zA-Z]\\+\\)(/function \\1 (/g"
    redraw|echomsg "reformatted."
endfunction

function! MyRangeJSFormat()
    call RangeJsBeautify()
    " jsBeautify doesn't honor spaces before functions, afaik 
    execute "silent! s/\\%Vfunction(/function (/g"
    " you have to double escape when using execute
    execute "silent! s/\\%V/function \\([a-zA-Z]\\+\\)(/function \\1 (/g"
    redraw|echomsg "reformatted."
endfunction

" function! RefreshToken()
"     normal! ^{ 
"     /Authorization: Bearer
"     normal! 3wd$
"     let @a=system('source ~/.zshrc && tokenize')
"     normal! "apkJ2k^
" endfunction
"
" function! GetCredential()
"     let @a=system('source ~/.zshrc && tokenize')
"     :execute "normal! /Authorization\<cr>3wd$"
"     normal! "apkJ
"     :call VrcQuery()
" endfunction
"
" nmap <silent> <C-c><C-j> :call GetCredential()<CR>
"
" function! UnfoldRestResponse()
"     let rstWin = bufnr('__REST_response__')
"     echomsg 'buffer number is: ' rstWin
"     if (bufexists('__REST_response__'))
"         execute "buffer " . rstWin
"         execute "normal! zn"
"     else
"         echomsg 'cannot find buffer: ' . rstWin
"     endif
" endfunction

function! Urldecode(str)
    let retval = a:str
    let retval = substitute(retval, '+', ' ', 'g')
    let retval = substitute(retval, '%\(\x\x\)', '\=nr2char("0x".submatch(1))', 'g')
    return retval
endfunction

if ! exists("g:running_ReSourceVimrc") 
    function! ReSourceVimrc() 
        let g:running_ReSourceVimrc = 1
        let l:this_session = v:this_session
        source ~/.vimrc
        let v:this_session = l:this_session
        unlet g:running_ReSourceVimrc
        redraw|echomsg "Re-sourced .vimrc"
    endfunction 
    " wat
    nnoremap <Leader><Leader> :call ReSourceVimrc()<CR> 
endif

" Cycle between line numbers, relative numbers, no numbers
if exists('+relativenumber')
    "CTRL-N is traditionally mapped to move the cursor down;
    "I never use it that way, and there are already four other
    "ways to do that
    nnoremap <expr> <C-N> CycleLNum()
    xnoremap <expr> <C-N> CycleLNum()
    onoremap <expr> <C-N> CycleLNum()

    " function to cycle between normal, relative, and no line numbering
    function! CycleLNum()
        if &l:rnu
            setlocal nonu nornu
        elseif &l:nu
            setlocal nu rnu
        else
            setlocal nu
        endif
        " sometimes (like in op-pending mode) the redraw doesn't happen
        " automatically
        redraw
        " do nothing, even in op-pending mode
        return ""
    endfunc
endif

" https://github.com/junegunn/fzf/wiki/Examples-(vim) 
function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \   'options': '+m',
            \   'down':    len(<sid>buflist()) + 2
            \ })<CR>
"}}}

" File Changed Shell Handler {{{
" Explains what has happened when Vim notices that the file you are editing
" was changed by another program

if has('eval') && has('autocmd')
    augroup FCSHandler
        au FileChangedShell * call FCSHandler(expand("<afile>:p"))
    augroup END

    function! FCSHandler(name)
        let msg = 'File "'.a:name.'"'
        let v:fcs_choice = ''
        if v:fcs_reason == 'deleted'
            let msg .= " no longer available - 'modified' set"
            call setbufvar(expand(a:name), '&modified', '1')
        elseif v:fcs_reason == 'time'
            let msg .= ' timestamp changed'
        elseif v:fcs_reason == 'mode'
            let msg .= ' permissions changed'
        elseif v:fcs_reason == 'changed'
            let msg .= ' contents changed'
            let v:fcs_choice = 'ask'
        elseif v:fcs_reason == 'conflict'
            let msg .= ' CONFLICT --'
            let msg .= ' is modified, but'
            let msg .= ' was changed outside Vim'
            let v:fcs_choice = 'ask'
            echohl Error
        else  " unknown values (future Vim versions?)
            let msg .= ' FileChangedShell reason='
            let msg .= v:fcs_reason
            let v:fcs_choice = 'ask'
        endif
        redraw!
        echomsg msg
        echohl None
    endfunction
endif

    




"}}}

" Vim Notes{{{
let g:notes_directories = ['~/Dropbox/Vim Notes']
"}}}

" gist-vim {{{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 4
let g:gist_post_private = 0
let g:gist_use_password_in_gitconfig = 0  
let g:gist_post_anonymous = 1
xnoremap <leader>g :Gist<cr>
"}}}

" FuzzyFinder {{{

let g:fuf_previewHeight=10
" i just want a quick way to access my api rest template in a sort index
" nnoremap <silent><leader>r :FufFile! ~/projects/cb/apis/*.rest<CR>
" nnoremap <silent><leader>r :find ~/projects/cb/apis<cr>
nnoremap <leader><C-f> :FufFile!<CR> 
nnoremap <leader><C-w> :FufFileWithFullCwd!<CR>
nnoremap <leader><C-b> :FufFileWithCurrentBufferDir!<CR>
nnoremap <leader><C-d> :FufDir!<CR>

"}}}

" Buffer Management {{{

" nnoremap <silent><Leader>cb :CommandTBuffer<CR>
" use bbye plugin to delete buffer, not window
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>o :only<cr>
" nnoremap <silent> <leader>b :CommandTMRU<CR>
" el capitan breaks command-t for buffer mgmt
" rather than fix it now i'll just use ctrlp
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>j :CommandTJump<CR>
" regular file search
nnoremap <silent> <leader>f :CommandT<CR>
" command-T config
let g:CommandTMaxHeight = 30
let g:CommandTFileScanner = 'watchman'
let g:CommandTMaxCachedDirectories = 10
let g:CommandTSmartCase = 1
" }}}

" Ags {{{

let g:ags_agexe = '/usr/local/bin/ag'
let g:ags_edit_show_line_numbers = 1
set grepprg="/usr/local/bin/ag"
nnoremap K :Ags "\b<C-R><C-W>\b"<CR>

nnoremap <leader>g :Ags 
nnoremap <silent><leader>gq :AgsQuit<CR>
nnoremap <silent><leader>gl :AgsLast<CR>

"}}}
"Vim Notes{{{

let g:notes_directories = ['~/Dropbox/Vim Notes']

"}}}

" Syntastic{{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = '/Users/barnold/.nvm/versions/node/v4.2.0/bin/eslint'
"" i have some js specific autocommands too for Syntastic
nmap <C-s>i :SyntasticInfo<cr>

"}}}
"
" Pandoc {{{

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#modules#disabled  = ["bibliographies"]
let g:pandoc#filetypes#pandoc_markdown = 0

"}}}

" golang {{{

nnoremap <leader>god :GoDoc<CR>
au FileType go nmap <leader>df <Plug>(go-def)
" au Filetype go nmap <leader>gb <Plug>(go-build)
au Filetype go set makeprg=go\ build\ ./...
nmap <leader>gb :make<CR>

"}}}

" ctrlp {{{
    let g:ctrlp_match_window = 'top,order:btt,min:1,max:10,results:10'
    " let g:ctrlp_switch_buffer = 'Et'
    let g:ctrlp_working_path_mode = 'wr'
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
" }}}

" FZF {{{
    set rtp +=~/.vim/bin
    let g:fzf_launcher = "/Users/barnold/.vim/bin/fzf_term %s"
    " https://github.com/junegunn/fzf/wiki/Examples-(vim)
    nnoremap <silent> <Leader>C :call fzf#run({
                \   'source':
                \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
                \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
                \   'sink':    'colo',
                \   'options': '+m',
                \   'left':    30
                \ })<CR>
                
    nnoremap <silent> <Leader>d :call fzf#run({
                \ 'dir': "~/projects/drive",
                \ 'sink': 'edit',
                \ 'options': '+m',
                \ 'left': 30
                \ })<CR> 

" }}}
" vim:filetype=vim sw=4 foldmethod=marker tw=78 expandtab:


