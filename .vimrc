set nocp  " no vi compatibility
set showmode            "shows matching ({ - })
set encoding=utf8
set termencoding=utf8
set tabpagemax=30 "max number of tabs
set showtabline=2 "two lines display for tabs
set wmnu "affiche le menu
set wildmode=list:longest,list:full "affiche toutes les possibilités
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz "ignorer certains types de fichiers pour la complétion des includes
set nolist
set nu
set backspace=2   "normal backspace
set tabstop=8     " 8 spaces = 1 tab
set softtabstop=8
set shiftwidth=8  " number of space char inserted for indent
set expandtab     " replace tab by spaces
set mouse=nv      " mouse enable for normal and visual mode
set so=5            "specify number of lines to maintain between cursor and top/bottom screen when scrolling file
set incsearch
set hlsearch
set foldcolumn=4        " rec level
set title

"persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

filetype indent on
syntax enable


"wraped line"
noremap <buffer> <silent> <Up> gk
noremap <buffer> <silent> <Down> gj
noremap <buffer> <silent> <Home> g<Home>
noremap <buffer> <silent> <End> g<End>

inoremap <buffer> <silent> <Up> <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End> <C-o>g<End>

"maps
map <S-Up> gk <Left>
map <S-Down> gj <Left>
"map <C-M> g<C-]>    
map ^M ^]    
map ^? ^T    

"tags related
set tags=./tags,./TAGS,tags;,TAGS,../../../tags;
let g:ctags_statusline=1
let generate_tags=1

"tab related
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <F2> :mark k<CR>H :mark l<CR>:%s/\t/        /g<CR>`lzt`k<ESC><CR>:nohlsearch<CR>
" remove all tabs and replace cursor to the position it was before pressing F2

call pathogen#infect()

" term co
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Commenting blocks of code.
augroup comment_type
        autocmd!
        autocmd FileType c,cpp,java,scala               let b:comment_leader = '//'
        autocmd FileType sh,zsh,zsh-theme,python        let b:comment_leader = '#'
        autocmd FileType make,md                        let b:comment_leader = '#'
        autocmd FileType conf,fstab                     let b:comment_leader = '#'
        autocmd FileType tex                            let b:comment_leader = '%'
        autocmd FileType mail                           let b:comment_leader = '>'
        autocmd FileType vim                            let b:comment_leader = '"'
        autocmd FileType vhdl,vhd                       let b:comment_leader = '--'
augroup END

"commenting stuff
noremap <silent> <C-d> : <C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> <C-e> : <C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"toggle tlise mapping
map <F6> :TlistToggle<CR>

" unfold at opening
au BufRead,BufNewFile * normal zR

"status line
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

augroup indent_group
        "remove all autocommands for the current group.
        autocmd!
        autocmd FileType c,cpp set cindent
        autocmd FileType make set noexpandtab shiftwidth=8
augroup END

augroup omni_group
        autocmd!
        autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
augroup END

augroup latex_group
        autocmd!
"        autocmd BufRead,BufNewFile *.tex set runtimepath=~/.vim/bundle
        autocmd BufRead,BufNewFile *.tex set spelllang=fr spell
        autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

augroup folds_setup
        "prevent folds to open/close when opening/closing brackets
        autocmd!
        autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
        autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END

"let $GROFF_NO_SGR=1 ?? dont remember what both thoses lines are for.
"#source $VIMRUNTIME/ftplugin/man.vim
source ~/.vim/bundle/man.vim
nnoremap <silent>K :<C-U>exe "Man" v:count "<cword>"<CR>

highlight Tabs ctermbg=24
highlight ColorColumn ctermbg=24 ctermfg=34

function ToggleHighlight()
        if exists("t:hi_toggle") == 0
                let t:hi_toggle=0
        endif
        if t:hi_toggle == 0
                let t:m0=matchadd('ErrorMsg', '\s\+$', -1)
                let t:m1=matchadd('Tabs', '\t', -1)
                let t:m2=matchadd('ColorColumn', '\%>80v', -10)
                let t:hi_toggle=1
        else
                "delete matchadd
                call matchdelete(t:m0)
                call matchdelete(t:m1)
                call matchdelete(t:m2)
                let t:hi_toggle=0
        endif
endfunction

map <F3> :call ToggleHighlight()<CR>

filetype plugin on
"au BufNewFile,BufRead,BufEnter *.c,*.h set omnifunc=ccomplete#Complete
au BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


set completeopt-=preview

