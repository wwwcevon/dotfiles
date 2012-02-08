
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=v
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" customization

" set columns=124
" set lines=40
set number
set nobackup
set smartindent
set expandtab
set sts=4
set sw=4
if &term =~ 'xterm'
    " X11
    set t_Co=256
    color molokai
    " color nature
elseif &term =~ 'builtin_gui'
    " gvim
    set t_Co=256
    color molokai
    " color nature
else
    " tty
    " color nature
endif
set laststatus=2
set showtabline=2
" set spell
" color ron

helptags ~/.vim/doc

if v:version > 702
    "set persistant undo
    set undofile
    set undodir=~/.undo
endif

set tags=tags

" set autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menu

map <F2> <Esc>:NERDTree<Cr>
map <F3> <Esc>:TlistToggle<Cr>
map <F4> <Esc>:TaskList<Cr>
map <S-F5> <Esc>:EnableFastPHPFolds<Cr>
map <S-F6> <Esc>:EnablePHPFolds<Cr>
map <S-F7> <Esc>:DisablePHPFolds<Cr>
map <S-F12> <Esc>:IndentGuidesToggle<Cr>
map <C-c> <Esc>:qa<Cr>
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
nmap <SPACE> <SPACE>:noh<CR>
" autoindent the code
map <C-S-j> <Esc>gg=G

" bother when editing a system file without root access?
cmap w!! %!sudo tee > /dev/null %

" indent guide color setting
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#444444 ctermbg=238
autocmd FileType php setlocal textwidth=78
autocmd FileType python setlocal textwidth=78

" auto remove tailing spaces
autocmd BufWritePre * :%s/\s\+$//e

