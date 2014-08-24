set nocp  " no vi compatibility
syntax enable

"""""""""""""""
set showmode            "shows matching ({ - })
set encoding=utf8
set termencoding=utf8

set tabpagemax=30 "max number of tabs
set showtabline=2 "two lines display for tabs

set wmnu "affiche le menu
set wildmode=list:longest,list:full "affiche toutes les possibilités
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz "ignorer certains types de fichiers pour la complétion des includes
"au BufRead,BufNewFile *.c*,*.h* set list
"au BufRead,BufNewFile *.c*,*.h*,*.vst* set listchars=tab:>-   "print tab
set nolist

set incsearch
set hlsearch


"""""""""""""""

set nu

set backspace=2   "normal backspace
set tabstop=8     " 4 spaces = 1 tab
set softtabstop=8
set shiftwidth=8  " number of space char inserted for indent
set expandtab     " replace tab by spaces
set mouse=nv      " mouse enable for normal and visual mode

set tags=./tags,./TAGS,tags;,TAGS,../../../tags;

filetyp indent on

"wraped line"
noremap <buffer> <silent> <Up> gk
noremap <buffer> <silent> <Down> gj
noremap <buffer> <silent> <Home> g<Home>
noremap <buffer> <silent> <End> g<End>

inoremap <buffer> <silent> <Up> <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End> <C-o>g<End>

au BufRead,BufNewFile Makefile*,makefile* set noexpandtab


" ctags
let g:ctags_statusline=1
let generate_tags=1
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" remove all tabs and replace cursor to the position it was before pressing F2
map <F2> :mark k<CR>H :mark l<CR>:%s/\t/    /g<CR>`lzt`k<ESC>

call pathogen#infect()

set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized


" Commenting blocks of code.
autocmd FileType c,cpp,java,scala               let b:comment_leader = '//'
autocmd FileType sh,zsh,zsh-theme,python        let b:comment_leader = '#'
autocmd FileType make,md                        let b:comment_leader = '#'
autocmd FileType conf,fstab                     let b:comment_leader = '#'
autocmd FileType tex                            let b:comment_leader = '%'
autocmd FileType mail                           let b:comment_leader = '>'
autocmd FileType vim                            let b:comment_leader = '"'
autocmd FileType vhdl,vhd                       let b:comment_leader = '--'

noremap <silent> <C-d> : <C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>

"toggle tlise mapping
map <F6> :TlistToggle<CR>

set foldmethod=syntax   " auto fold
set foldcolumn=4        " rec level

" unfold at opening
au BufRead,BufNewFile * normal zR
"set formatoptions-=o "dont continue comments when pushing o/O

"""""""""""""""""""""""""""""""""""""""""
"STATUS LINE"

set statusline=[%f]                                " file name
set statusline+=\ %#todo#                          " todo highligths
set statusline+=%(%{Tlist_Get_Tagname_By_Line()}%) " function name
set statusline+=%*                                 " normal highlight
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}      " non unix file warning
set statusline+=%*
set statusline+=%=                                 " left/right separator
set statusline+=%c,                                " columns
set statusline+=%l/%L                              " lines/total lines
set statusline+=\ %P                               " file %

"simple

set laststatus=2

set title
au BufRead,BufNewFile *.tex set runtimepath=~/.vim/bundle
au BufRead,BufNewFile *.tex set spelllang=fr spell

"let $GROFF_NO_SGR=1
"source $VIMRUNTIME/ftplugin/man.vim
source ~/.vim/bundle/man.vim
nnoremap <silent>K :<C-U>exe "Man" v:count "<cword>"<CR>

highlight Tabs ctermbg=24
highlight ColorColumn ctermbg=24 ctermfg=34

au BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp let m0=matchadd('ErrorMsg', '\s\+$', -1)
au BufRead,BufNewFile * let m1=matchadd('Tabs', '\t', -1)

filetype plugin on
au BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp let m2=matchadd('ColorColumn', '\%>80v', -10)
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
"au BufNewFile,BufRead,BufEnter *.c,*.h set omnifunc=ccomplete#Complete
au BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile *.zsh-theme set filetype=zsh


set completeopt-=preview

