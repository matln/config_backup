set nocompatible              " required
filetype off                  " required
"set mouse=a
set hlsearch
set nu
":noh     "cancel highlight

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=marker
set foldlevel=99

" Enable folding with the spacebar
""nnoremap <space> za

Plugin 'tmhedberg/SimpylFold'

let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set cc=79 |
\ set expandtab |        "Tab替换成空格
\ set autoindent |       "自动缩进
\ set fileformat=unix |  "保存文件格式

Plugin 'vim-scripts/indentpython.vim'

"按照pep8标准自动格式化
Plugin 'tell-k/vim-autopep8'
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>)

"Flagging Unnecessary Whitespace
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

Bundle 'Valloric/YouCompleteMe'

"YCM
let g:ycm_autoclose_preview_window_after_completion=1
let mapleader = ","
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Plugin 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"需要先在系统安装flake8
Plugin 'nvie/vim-flake8'
"autocmd FileType python map <buffer> <F2> :call Flake8()<CR>

let python_highlight_all=1
syntax on

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

if has('gui_running')
    set background=dark
    colorscheme solarized
else
    colorscheme zenburn
endif

"Plugin 'jlanzarotta/bufexplorer'
call togglebg#map("<F5>")

map <F6> :call PRUN()<CR>
func! PRUN()
        exec "w"
        if &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear"
                exec "!time python3 %"
        endif
endfunc

Plugin 'scrooloose/nerdtree'
"F4快捷键快速切换打开和关闭目录树窗口
"map <F4> :NERDTreeToggle<CR>
noremap <F3> :NERDTreeFind 
"当剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
"ignore files in NERDTree"
let NERDTreeIgnore=['\.pyc$', '\~$'] 
"打开vim时自动打开NERDTree
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p
"窗口是否显示行号
let g:NERDTreeShowLineNumbers=1
""窗口尺寸
"let g:NERDTreeSize=25

" 使用winmanager在左上和左下合并显示nerdtree和tagbar
" 需要先安装ctags：sudo apt-get install exuberant-ctags
" 或从源码安装
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/winmanager'
let g:winManagerWindowLayout='NERDTree|Tagbar'
let g:winManagerWidth=25
let g:AutoOpenWinManager = 1 "这里要配合修改winmanager.vim文件，见下方说明
"在winmanager/plugins/winmanager.vim开头加上：
"if g:AutoOpenWinManager 
"	autocmd VimEnter * nested call s:ToggleWindowsManager()|1wincmd l 
"	"vim进入时自动执行 ToggleWindowsManager ，然后移动一次窗口焦点
"end

"按F4同时打开或关闭nerdtree，tagbar
nmap <silent> <F4> :NERDTreeToggle<CR>:TagbarToggle<CR>
"切换窗口到nerdtree
nnoremap <silent> <tab> H<C-W><C-H>

let g:NERDTree_title = "[NERDTree]"
function! NERDTree_Start()
	"执行一个退出命令，关闭自动出现的窗口"
	exe 'q'
	exe 'NERDTree'
endfunction

function! NERDTree_IsValid()
	return 1
endfunction

let g:Tagbar_title = "[Tagbar]"
function! Tagbar_Start()
	"执行一个退出命令，关闭自动出现的窗口"
	exe 'q'
	exe 'TagbarOpen'
endfunction

function! Tagbar_IsValid()
	return 1
endfunction

let g:tagbar_vertical = 25

"括号补全
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap { {<CR>}<ESC>
Plugin 'jiangmiao/auto-pairs'

"vim自动补齐Anaconda虚拟环境envs下的site-package
let g:ycm_python_binary_path = '/home/lijianchen/anaconda3/envs/pytorch/bin/python'

