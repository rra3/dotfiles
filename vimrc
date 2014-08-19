" Modeline and notes {
" Bobby's vimrc. Heavily influenced by spf13 vim config: https://github.com/spf13/spf13-vim
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" NeoBundle Support {
        set nocompatible               " be iMproved
        filetype off                   " required!

    if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#rc(expand('~/.vim/bundle/'))

    " Let NeoBundle manage NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'
        NeoBundle 'Shougo/neobundle-vim-scripts'
    " Installation check
    NeoBundleCheck
        if !has('vim_starting')
          " Call on_source hook when reloading .vimrc.
          call neobundle#call_hook('on_source')
        endif
    " set rtp+=~/.vim/bundle/vundle/
        " call vundle#rc()
" }

" Bundles {

    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
    " }

    filetype plugin indent on     " required for bundles!
" }

" General {
    " tab settings
    set tabstop=4           " number of spaces a tab counts for
    set shiftwidth=2        " spaces for autoindents
    set softtabstop=2
    "set shiftround          " makes indenting a multiple of shiftwidth
    set expandtab           " turn a tab into spaces  let mapleader = ','
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set encoding=utf-8          "          necessary to show Unicode glyphs in vim-powerline
    set laststatus=2            "          Always show the statusline (vim-powerline)
    set ignorecase              " Ignore case when searching
    " set shellcmdflag = "-ic"
    "/usr/local/bin is not in my shell path o.O
    let $PATH = expand("$PATH:/usr/local/bin")


    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
    set cursorline
    set showmode
    set nu " linenumbers
    set noswapfile " .swp is annoying
    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
     set nobackup                  " Backups are nice ...
     set shell=zsh\ --login
    " http://stackoverflow.com/questions/18270355/how-to-ignore-angular-directive-lint-error-with-vim-and-syntastic
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
    " new in vim 7.4 - I can get rid of numbers.vim!
    set relativenumber
    imap <C-s> <Esc>:w<cr>
    augroup filetype_json
        autocmd!
        autocmd FileType json set equalprg=json_reformat
    augroup END
" }

" Appearance {
    syntax enable
    set background=dark
    colorscheme gruvbox
    set guifont=Menlo\ Regular\ for\ Powerline:h12

    if !has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        " I like to see the toolbar        
        " set go+=T
    endif
" }
" Ack! {
    " let g:ackprg="/usr/local/bin/ack -H --nocolor --nogroup --column"
    " Experimenting with The Silver Searcher!
      let g:ackprg = '/usr/local/bin/ag --ignore \*log --nogroup --nocolor --column'
      " The Silver Searcher
      if executable('ag')
          " Use ag over grep
          set grepprg=ag\ --nogroup\ --nocolor
          " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
          let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
          " ag is fast enough that CtrlP doesn't need to cache
          let g:ctrlp_use_caching = 0
      endif

 " }

" CtrlP {
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_clear_cache_on_exit = 1
    let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" }

" Vim Notes {
    let g:notes_directories = ['~/Dropbox/Vim Notes']
" }

" ctags {
    " set tags=./tags
" }

" QuickRun {
    let g:quickrun_config = {}
    let g:quickrun_config.ruby = { 'command' : '~/.rvm/bin/ruby' }
" }

" gist-vim {
    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 4
    let g:gist_post_private = 0
    let g:gist_use_password_in_gitconfig = 1  
    " let g:github_api_url = 'http://gitsum.cb.careerbuilder.com/api/v3'
    " vnoremap <space>g :Gist<cr>
" }

" CoffeeScript{
    let coffee_compiler = '/usr/local/bin/coffee'
" }

" Syntastic{
    let g:syntastic_check_on_open=1
" }
"
" Vim Node{
    autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
    autocmd User Node
    \ if &filetype == "javascript" |
    \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
    \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
    \ endif
" }

" QuickFix Window {
    set cmdheight=2"
" }

" rspec {
        " http://robots.thoughtbot.com/running-specs-from-vim
        " let g:rspec_command_launcher = "iterm"
        let g:rspec_command = "Dispatch rspec {spec}"
" }
" vim-go  {
    let $GOPATH= expand("$HOME/mygo")
    " let g:go_bin_path = "/usr/local/bin"
" }
" vim-airline {
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_detect_whitespace=0
"  }
"
" key bindings {

    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.mappings"))
            source ~/.vimrc.mappings
        endif
    " }

