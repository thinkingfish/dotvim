" Modeline and Notes {
" vim: set sw=4 ts=8 sts=4 et tw=79 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"
" This is the personal .vimrc file of Yao Yue, based on Steve Francia's spf13-vim project (http://spf13.com).
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
" http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" }

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix'
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        source ~/config/vim/autoload/pathogen.vim       " location of pathogen
        execute pathogen#infect()
        if !WINDOWS()
            set shell=/bin/sh
        endif

        set runtimepath^=~/config/vim/bundle/ctrlpvim
    " }
" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" General {

    filetype plugin indent on   " Automatically detect file types.
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set timeoutlen=2000         " keymapping times out slower
    if !has('gui')
        set term=ansi           " Make arrow and other keys work
    endif

    if has('clipboard')
        if has('unnamedplus')   " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                    " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set autowrite               " Automatically write a file when leaving a modified buffer
    set visualbell              " Use visual bell (screen flash) instead of beeping
    set nostartofline           " Do not go to start of line content, stay in the same column
    set cf                      " Enable error files & error jumping
    set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore     " Allow for cursor beyond last character
    set history=1000            " Store a ton of history (default is 20)
    set hidden                  " Allow buffer switching without saving
    set iskeyword-=.            " '.' is an end of word designator
    set iskeyword-=#            " '#' is an end of word designator
    set iskeyword-=-            " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Setting up the directories {
        set backup                      " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        " InitializeDirectories() is called later to setup directories
        endif
    " }

" }

" Vim UI {

    syntax enable                   " Syntax highlighting
    let g:solarized_termcolors=256
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    if has('gui')
        set background=light
        colorscheme solarized           " Load a colorscheme
    endif
    set cursorline                  " Highlight current line
    set scrolloff=5                 " Keep the cursor away from the top/bottom of screen

    hi clear SpellBad
    hi SpellBad cterm=underline
    " Set style for gVim
    hi SpellBad gui=undercurl

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set title                       " Show title
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set showcmd                     " Show (partial) command in the last lien of the screen
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list                        " Highlight problematic whitespace
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Define problematic whitespace

" }

" Formatting {

    "set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set smartindent                 " Smart autoindenting for C-like programs
    set expandtab                   " Convert tabs to spaces
    set tabstop=8                   " keep tabstop at 8 for maximum compatibility
    set shiftwidth=4                " Use indents of 4 spaces
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>,`:'         " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    highlight TrailingWhitespace ctermbg=red guibg=red
    autocmd FileType c,cpp,java,javascript,python,rst,ruby,rs,rust,yml,perl autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType haskell,python,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType markdown,rst,text setlocal spell
    " preceding line best in a plugin but here for now.
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken color highlighting in Haskell

    " indent_guides {
        if exists('g:indent_guildes') && isdirectory(expand("~/config/vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

" }

" Syntastic {
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_c_config_file = '.syntastic_c_config'
    let g:syntastic_c_auto_refresh_includes = 1
    let g:syntastic_c_check_header = 1

    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
    nnoremap <C-w>e :SyntasticCheck<CR> :SyntasticToggleMode<CR>
" }

" Key (re)Mappings {

    " The default leader is '\', using '*' as it is in a standard location
    let mapleader = '*'
    let maplocalleader = ','

    " Easier moving in tabs and windows
    " Only using horizontal directions H/L and saving J/K
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " QuickFix command mapping
    map <C-n> :cnext<CR>
    map <C-m> :cprevious<CR>
    nnoremap <leader>a :cclose<CR>

    " Go execution
    autocmd FileType go nmap <localleader>b  <Plug>(go-build)
    autocmd FileType go nmap <localleader>r  <Plug>(go-run)
    autocmd FileType go nmap <localleader>t  <Plug>(go-test)

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Toggle search highlighting rather than clear the current search results.
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Find git merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " Tagbar toggle
    nmap <leader>tb :TagbarToggle<CR>

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings
        inoremap <expr> <Esc>   pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

    " NerdTree {
        if isdirectory(expand("~/config/vim/bundle/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.o$', '\.lo$', '^\.deps$', '^\.libs$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " Fugitive shortcuts {
        if isdirectory(expand("~/config/vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

" }

" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backupdir': '.backup',
                    \ 'viewdir': '.backup',
                    \ 'directory': '.backup'}

        if has('persistent_undo')
            let dir_list['undodir'] = '.backup'
        endif

        let common_dir = parent . '/.' . prefix

        for [settingname, dirname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

" }
