" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
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


