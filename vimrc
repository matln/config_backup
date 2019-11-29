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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab        "Tab替换成空格
set autoindent       "自动缩进

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"nnoremap <ESC> :nohl<cr>
nnoremap <Up> kzz
nnoremap <Down> jzz
onoremap - $
nnoremap - $
vnoremap - $
" ctrl + s 与 ctrl + q 在linux系统下分别为锁定屏幕和复原
" 在系统中禁用这两个按键，然后在vim中利用起来
" 首先在~/.bashrc中加入：stty -ixon
nnoremap <C-S> <C-u>
nnoremap <silent> <C-Q> :nohl<CR>
let mapleader = ","
let maplocalleader = ","
" inside nest parentheses
onoremap in( :<c-u>normal! f(vi(<cr>    
" inside previous parentheses
onoremap ip( :<c-u>normal! F)vi(<cr>    




Plugin 'dracula/vim', { 'name': 'dracula' }


" Enable folding
set foldmethod=marker
set foldlevel=99

Plugin 'tmhedberg/SimpylFold'

let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.sh
\ setlocal tabstop=2 |
\ setlocal softtabstop=2 |
\ setlocal shiftwidth=2 |

au BufNewFile,BufRead *.pl
\ nnoremap <silent> <buffer> <cr> <S-A>;<C-c>o|
\ setlocal tabstop=2 |
\ setlocal softtabstop=2 |
\ setlocal shiftwidth=2 |

au BufNewFile,BufRead *.py
\ set textwidth=79 |
\ set cc=80 |
\ set fileformat=unix    "保存文件格式>
" 和pycharm一样，<leader>/ 注释，多行时首先<C-v>选中多行
" autocmd FileType python vnoremap <buffer> <localleader>/ 0I# <esc>	
" autocmd FileType python nnoremap <buffer> <localleader>/ 0I# <esc>	

" -----------------------------------------------------------------------------
"  https://github.com/iqiy/11Env/blob/master/_vimrc
" 和pycharm一样，<localleader>/ 注释与取消，多行时首先<C-v>选中多行
" -----------------------------------------------------------------------------
autocmd FileType python vnoremap <silent> <buffer> <localleader>/ <ESC>:SetcommentV<CR>	
autocmd FileType python nnoremap <silent> <buffer> <localleader>/ <ESC>:Setcomment<CR>	
command! -nargs=0 Setcomment call s:SET_COMMENT()
command! -nargs=0 SetcommentV call s:SET_COMMENTV()

"非视图模式下所调用的函数
function! s:SET_COMMENT()
    let lindex=line(".")
    let str=getline(lindex)
    "查看当前是否为注释行
    let CommentMsg=s:IsComment(str)
    call s:SET_COMMENTV_LINE(lindex,CommentMsg[1],CommentMsg[0])
endfunction

"视图模式下所调用的函数
function! s:SET_COMMENTV()
    let lbeginindex=line("'<") "得到视图中的第一行的行数
    let lendindex=line("'>") "得到视图中的最后一行的行数
    "为各行设置
    let i=lbeginindex
    while i<=lendindex
        let str=getline(i)
        "查看当前是否为注释行
        let CommentMsg=s:IsComment(str)
        call s:SET_COMMENTV_LINE(i,CommentMsg[1],CommentMsg[0])
        let i=i+1
    endwhile
endfunction

"设置注释
"index:在第几行
"pos:在第几列
"comment_flag: 0:添加注释符 1:删除注释符
function! s:SET_COMMENTV_LINE(index,pos, comment_flag)
    let poscur = [0, 0,0, 0]
    let poscur[1]=a:index
    let poscur[2]=a:pos+1
    call setpos(".",poscur) "设置光标的位置

    if a:comment_flag==0
        "插入# 
        exec "normal! i# "
     else
        ""删除# 
        exec "normal! xx"
    endif
endfunction

" 查看当前是否为注释行并返回相关信息
" str:一行代码
function! s:IsComment(str)
    let ret= [0, 0] "第一项为是否为注释行（0,1）,第二项为要处理的列，
    let strlen=len(a:str)
    if (a:str[0]=='#' && a:str[1]==' ')
        let ret[0]=1
    endif
    return ret
endfunction
"---------------end---------------"

set nowrap
set sidescroll=1

Plugin 'vim-scripts/indentpython.vim'

"按照pep8标准自动格式化
Plugin 'tell-k/vim-autopep8'
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

"Flagging Unnecessary Whitespace
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

Bundle 'Valloric/YouCompleteMe'

"YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"vim自动补齐Anaconda虚拟环境envs下的site-package
let g:ycm_python_binary_path = '/Users/lijianchen/anaconda3/envs/pytorch/bin/python'
"let g:ycm_python_binary_path = '/home/lijianchen/anaconda3/envs/pytorch/bin/python'

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
        exec "!clear"
        exec "!time bash %"
	elseif &filetype == 'perl'
        exec "!clear"
        exec "!time perl %"
    elseif &filetype == 'python'
        exec "!clear"
        exec "!time python3 %"
    endif
endfunc


Plugin 'scrooloose/nerdtree'
"F4快捷键快速切换打开和关闭目录树窗口
noremap <silent> <F3> :NERDTreeToggle<CR>
noremap <F2> :NERDTreeFind 
"当剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
"ignore files in NERDTree"
let NERDTreeIgnore=['\.pyc$', '\~$'] 
"打开vim时自动打开NERDTree
"autocmd vimenter *.py,*.sh,*.pl NERDTree|wincmd p
"窗口是否显示行号
"let g:NERDTreeShowLineNumbers=1
"let g:NERDTreeStatusline='%t'
"状态栏不显示任何信息
let g:NERDTreeStatusline = '%#NonText#'
let g:NERDTreeWinSize= 25

Plugin 'weilbith/nerdtree_choosewin-plugin'

" " 使用winmanager在左上和左下合并显示nerdtree和tagbar
" " 需要先安装ctags：sudo apt-get install exuberant-ctags
" " 或从源码安装
" Plugin 'majutsushi/tagbar'
" "改变tagbar状态栏颜色
" "see `:help g:tagbat_status_func` or
" "https://raw.githubusercontent.com/vim-scripts/Tagbar/master/doc/tagbar.txt
" function! TagbarStatusFunc(current, sort, fname, ...) abort
"     let colour = '%#StatusLine#'
"     return colour . '[' . a:sort . '] ' . a:fname
" endfunction
" let g:tagbar_status_func = 'TagbarStatusFunc'
" autocmd BufReadPost *.cpp,*.c,*.sh,*.py,*.pl call tagbar#autoopen()
" noremap <F4> :TagbarToggle<CR>
" 
" let g:tagbar_width = 25
" " let g:tagbar_vertical = 23
" let g:tagbar_left = 0

" let g:tagbar_ctags_bin='/usr/bin/ctags'

" Plugin 'matln/winmanager'
" let g:winManagerWindowLayout='NERDTree|Tagbar'
" let g:winManagerWidth = 20

set splitright

" "打开vim自动时自动打开winmanager
" let g:AutoOpenWinManager = 1 "这里要配合修改winmanager.vim文件，见下方说明
" "在winmanager/plugins/winmanager.vim开头加上：
" "if g:AutoOpenWinManager 
" "	autocmd VimEnter * nested call s:ToggleWindowsManager()|1wincmd l 
" "	"vim进入时自动执行 ToggleWindowsManager ，然后移动一次窗口焦点
" "end
" 
" "按F4同时打开或关闭nerdtree，tagbar
" nnoremap <silent> <F4> :NERDTreeToggle<CR>:TagbarToggle<CR>
" "切换窗口到nerdtree
" nnoremap <silent> <S-Tab> H<C-W><C-H>
" "切换窗口到tagbar
" "nnoremap <silent> <S-Tab> L<C-W><C-H>

" let g:NERDTree_title = "[NERDTree]"
" function! NERDTree_Start()
" 	"执行一个退出命令，关闭自动出现的窗口"
" 	exe 'q'
" 	exe 'NERDTree'
" endfunction
" 
" function! NERDTree_IsValid()
" 	return 1
" endfunction
" 
" let g:Tagbar_title = "[Tagbar]"
" function! Tagbar_Start()
" 	exe 'TagbarOpen'
" endfunction
" 
" function! Tagbar_IsValid()
" 	return 1
" endfunction


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
nmap <Leader>d :ALEDetail<CR>

"vim 分屏竖线颜色与符号
set fillchars=vert:\ 
highlight VertSplit ctermfg=NONE cterm=bold

"状态栏颜色（透明）
"highlight StatusLine cterm=bold ctermfg=NONE

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
"set statusline=\ \>\ %f%m
"set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{LinterStatus()}
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ %{&fileformat}
set statusline+=\ %p%%
"set statusline+=\ %l:%c
"set statusline+=\ %t
set statusline+=\ %y
set statusline+=\ %{winnr()}
set statusline+=\ 

" fzf
set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'
"<Leader>f在当前目录搜索文件
nnoremap <silent> <Leader>f :Files<CR>
"<Leader>b切换Buffer中的文件
nnoremap <silent> <Leader>b :Buffers<CR>
"<Leader>p在当前所有加载的Buffer中搜索包含目标词的所有行，:BLines只在当前Buffer中搜索
nnoremap <silent> <Leader>p :Lines<CR>
"<Leader>h在Vim打开的历史文件中搜索，相当于是在MRU中搜索，:History：命令历史查找
nnoremap <silent> <Leader>h :History<CR>
"调用Rg进行搜索，包含隐藏文件
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
command! -bar -bang -nargs=? -complete=buffer Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

"Jump to tags in the current buffer
function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

