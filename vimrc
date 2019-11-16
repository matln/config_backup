set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

"set mouse=a
set hlsearch
set nu
":noh     "cancel highlight
set backspace=indent,eol,start

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"nnoremap <ESC> :nohl<cr>
nnoremap <Up> kzz
nnoremap <Down> jzz
nnoremap - $
" ctrl + s 与 ctrl + q 在linux系统下分别为锁定屏幕和复原
" 在系统中禁用这两个按键，然后在vim中利用起来
" 首先在~/.bashrc中加入：stty -ixon
nnoremap <C-S> <C-u>
inoremap <C-Q> <C-[>
nnoremap <C-Q> <C-[>


" Enable folding
set foldmethod=marker
set foldlevel=99

Plugin 'tmhedberg/SimpylFold'

let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set cc=80 |
\ set expandtab |        "Tab替换成空格
\ set autoindent |       "自动缩进
\ set fileformat=unix |  "保存文件格式

set nowrap
set sidescroll=1

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
"vim自动补齐Anaconda虚拟环境envs下的site-package
let g:ycm_python_binary_path = '/home/lijianchen/anaconda3/envs/pytorch/bin/python'

"需要先在系统安装flake8, 通过pip
Plugin 'nvie/vim-flake8'
"autocmd FileType python map <buffer> <F2> :call Flake8()<CR>

let python_highlight_all=1
" highlight keyword "self", add the following line into the file `$VIMRUNTIME/syntax/python.vim`, need ROOT
"syn keyword pythonStatement self

" Plugin 'altercation/vim-colors-solarized'
syntax enable 
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
"colorscheme solarized


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
"let g:NERDTreeShowLineNumbers=1
"let g:NERDTreeStatusline='%t'
"状态栏不显示任何信息
let g:NERDTreeStatusline = '%#NonText#'

Plugin 'weilbith/nerdtree_choosewin-plugin'


" 使用winmanager在左上和左下合并显示nerdtree和tagbar
" 需要先安装ctags：sudo apt-get install exuberant-ctags
" 或从源码安装
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/winmanager'
let g:winManagerWindowLayout='NERDTree|Tagbar'
let g:NERDTreeWinSize= 15
let g:tagbar_width = 10
let g:tagbar_vertical = 23
let g:tagbar_left = 0
let g:winManagerWidth = 20

set splitright

"打开vim自动时自动打开winmanager
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
"切换窗口到tagbar
nnoremap <silent> <S-Tab> L<C-W><C-H>

"改变tagbar状态栏颜色
"see `:help g:tagbat_status_func` or
"https://raw.githubusercontent.com/vim-scripts/Tagbar/master/doc/tagbar.txt
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let colour = '%#StatusLine#'
    return colour . '[' . a:sort . '] ' . a:fname
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'

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


"括号补全
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap { {<CR>}<ESC>
"使用插件
Plugin 'jiangmiao/auto-pairs'

"安装ale实现实时代码检查，只支持vim8以上的版本
Plugin 'dense-analysis/ale'

"对python使用flake8进行语法检查
let g:ale_linters = {
\   'python': ['flake8'],
\}

"ale
"始终开启标志列
"let g:ale_sign_column_always = 1
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
highlight clear SignColumn
"let g:ale_set_highlights = 1
"自定义error和warning图标
let g:ale_sign_error = ' ✘'
let g:ale_sign_warning = ' !'
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，前往上一个错误或警告，前往下一个错误或警告
nmap <Leader>k <Plug>(ale_previous_wrap)
nmap <Leader>j <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>f :ALEDetail<CR>

"vim 分屏竖线颜色与符号
set fillchars=vert:\ 
highlight VertSplit ctermfg=NONE cterm=bold

"状态栏颜色（透明）
highlight StatusLine cterm=bold ctermfg=NONE

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✔︎ OK': printf(
    \   '!:%d ✘:%d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

"修改状态栏
"https://shapeshed.com/vim-statuslines/
"http://yyq123.blogspot.com/2009/10/vim-statusline.html
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
"set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{LinterStatus()}
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\ %{&fileformat}
set statusline+=\ %p%%
"set statusline+=\ %l:%c
set statusline+=\ %y
set statusline+=\ %{winnr()}
set statusline+=\ 


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

