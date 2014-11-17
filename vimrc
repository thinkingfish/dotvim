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
	    return has('macunix')
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
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }


" Use bundles config {
    if filereadable(expand("~/.vimrc.bundle"))
        source ~/.vimrc.bundle
    endif
" }

" General {

    set background=dark         " Assume a dark background
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')   " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                    " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set autowrite               " Automatically write a file when leaving a modified buffer
    set visualbell			    " Use visual bell (screen flash) instead of beeping
    set nostartofline			" Do not go to start of line content, stay in the same column
    set cf                      " Enable error files & error jumping
    set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore     " Allow for cursor beyond last character
    set history=1000            " Store a ton of history (default is 20)
    set spell                   " Spell checking on
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
        endif
    " }

" }

" Vim UI {

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

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
    autocmd FileType c,cpp,java,go,javascript,python,ruby,rust,yml,perl autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType haskell,python,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken color highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

