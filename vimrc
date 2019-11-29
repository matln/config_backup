set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" --------------  Basic Settings -------------------- {{{
"set mouse=a
set helplang=cn        " 中文帮助文档
set encoding=utf-8
set hlsearch incsearch    " 高亮搜索结果, incsearch则令Vim在你正打着搜索内容时就高亮下一个匹配项
set ignorecase    " 搜索时大小写不敏感
set number        " 显示行号
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab        "Tab替换成空格
set autoindent       "自动缩进
set nowrap
set sidescroll=1
set splitright
set laststatus=2
"vim 分屏竖线颜色与符号
set fillchars=vert:\ 
highlight VertSplit ctermfg=NONE cterm=bold
" Enable folding
set foldmethod=marker
set foldlevel=99

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
" }}}

" ---------------------- Mappings ------------------- {{{
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
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
" }}}


" -------------------- Colorscheme ------------------ {{{
Plugin 'dracula/vim', { 'name': 'dracula' }
set rtp+=~/.vim/bundle/dracula
colorscheme dracula
set termguicolors
syntax on

""vim italic
"set t_ZH=^[[3m
"set t_ZR=^[[23m
"the above two lines not work for me, even do the `^[` by `<C-v><esc>`
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"set background=dark
" Plugin 'altercation/vim-colors-solarized'
"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
"colorscheme solarized
" }}}


" ------------------- bash settings ----------------- {{{
augroup shell
    autocmd!
    autocmd BufNewFile,BufRead *.sh
    \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
" }}}

" ------------------- perl settings ----------------- {{{
augroup perl
    autocmd!
    autocmd BufNewFile,BufRead *.pl
    \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType perl
    \ nnoremap <silent> <buffer> <cr> A;<esc>o|
    \ nnoremap <silent> <buffer> <localleader>; mqA;<esc>`q
    " https://vi.stackexchange.com/questions/3721/why-do-i-get-a-missing-quote-error-when-using-the-following-in-a-mapping-using-e
    " \ nnoremap <silent> <buffer> <localleader>; :execute "normal! mqA;<C-v><esc>`q"<cr>
augroup END
" }}}

" ------------------- vimscript settings ----------------- {{{
augroup vimscript
    autocmd!
    command! -nargs=0 VimSetcomment call s:SET_COMMENT("vim")
    command! -nargs=0 VimSetcommentV call s:SET_COMMENTV("vim")
    autocmd FileType vim vnoremap <silent> <buffer> <localleader>/ <ESC>:VimSetcommentV<CR>	
    autocmd FileType vim nnoremap <silent> <buffer> <localleader>/ <ESC>:VimSetcomment<CR>	

    autocmd FileType vim noremap <silent> <buffer> <F6> :<c-u>w<CR>:source vimscript.vim<CR>	
augroup END
" }}}

" ------------------ python settings ---------------- {{{
Plugin 'vim-scripts/indentpython.vim'

"Flagging Unnecessary Whitespace
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" 按照pep8标准自动格式化
Plugin 'tell-k/vim-autopep8'

let python_highlight_all=1
" highlight keyword "self", add the following line into the file `$VIMRUNTIME/syntax/python.vim`, need ROOT
"syn keyword pythonStatement self

"需要先在系统安装flake8, 通过pip
Plugin 'nvie/vim-flake8'
augroup python
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal textwidth=79 cc=80 fileformat=unix
    command! -nargs=0 PythonSetcomment call s:SET_COMMENT("python")
    command! -nargs=0 PythonSetcommentV call s:SET_COMMENTV("python")
    autocmd FileType python vnoremap <silent> <buffer> <localleader>/ <ESC>:PythonSetcommentV<CR>
    autocmd FileType python nnoremap <silent> <buffer> <localleader>/ <ESC>:PythonSetcomment<CR>	
    autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
    " autocmd FileType python noremap <buffer> <F2> :call Flake8()<CR>
augroup END
" }}}


" ------------------- Annotation -------------------- {{{
"  https://github.com/iqiy/11Env/blob/master/_vimrc
" 和pycharm一样，<localleader>/ 注释与取消，多行时首先<C-v>选中多行
"非视图模式下所调用的函数
function! s:SET_COMMENT(type)
    let lindex=line(".")
    let str=getline(lindex)
    "查看当前是否为注释行
    let CommentMsg=s:IsComment(str, a:type)
    call s:SET_COMMENTV_LINE(lindex,CommentMsg[1],CommentMsg[0], a:type)
endfunction

"视图模式下所调用的函数
function! s:SET_COMMENTV(type)
    let lbeginindex=line("'<") "得到视图中的第一行的行数
    let lendindex=line("'>") "得到视图中的最后一行的行数
    "为各行设置
    let i=lbeginindex
    while i<=lendindex
        let str=getline(i)
        "查看当前是否为注释行
        let CommentMsg=s:IsComment(str, a:type)
        call s:SET_COMMENTV_LINE(i,CommentMsg[1],CommentMsg[0], a:type)
        let i=i+1
    endwhile
endfunction

"设置注释, index:在第几行, pos:在第几列, comment_flag: 0:添加注释符 1:删除注释符
function! s:SET_COMMENTV_LINE(index, pos, comment_flag, type)
    let poscur = [0,0,0,0]
    let poscur[1]=a:index
    let poscur[2]=a:pos+1
    call setpos(".",poscur) "设置光标的位置

    if a:type == "python"
        if a:comment_flag==0
            execute "normal! i# "
        else
            execute "normal! xx"
        endif
    elseif a:type == "vim"
        if a:comment_flag==0
            execute "normal! i\" "
        else
            execute "normal! xx"
        endif
    endif

endfunction

" 查看当前是否为注释行并返回相关信息, str: 一行代码
function! s:IsComment(str, type)
    let ret=[0, 0] "第一项为是否为注释行（0,1）,第二项为要处理的列，
    if a:type == "python"
        let l:sign = "# "
    elseif a:type == "vim"
        let l:sign = "\" "
    endif
    let i=0
    let strlen=len(a:str)
    if (a:str[0]==l:sign[0] && a:str[1]==l:sign[1]) | let ret[0] = 1 | endif
    return ret
endfunction
" }}}

" YCM
Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" vim自动补齐Anaconda虚拟环境envs下的site-package
if has('mac')
    let g:ycm_python_binary_path = '/Users/lijianchen/anaconda3/envs/pytorch/bin/python'
elseif has('unix')
    let g:ycm_python_binary_path = '/home/lijianchen/anaconda3/envs/pytorch/bin/python'
endif


noremap <F6> :call PRUN()<CR>
function! PRUN()
    execute "w"
    if &filetype == 'sh'
        execute "!clear"
        execute "!time bash %"
	elseif &filetype == 'perl'
        execute "!clear"
        execute "!time perl %"
    elseif &filetype == 'python'
        execute "!clear"
        execute "!time python3 %"
    endif
endfunction


" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'weilbith/nerdtree_choosewin-plugin'
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


" winmanager
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

" ale
" 安装ale实现实时代码检查，只支持vim8以上的版本
Plugin 'dense-analysis/ale'

"对python使用flake8进行语法检查
let g:ale_linters = {
\   'python': ['flake8'],
\}

"始终开启标志列
"let g:ale_sign_column_always = 1
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
highlight clear SignColumn
"let g:ale_set_highlights = 1
"自定义error和warning图标
let g:ale_sign_error = ' ✘'
let g:ale_sign_warning = " \uf0e7"
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，前往上一个错误或警告，前往下一个错误或警告
"nnoremap 不知道为什么出错
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>


" --------------------------- statusline ------------------------- {{{
"状态栏颜色（透明）
"highlight StatusLine cterm=bold ctermfg=NONE

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))
"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors
"     return l:counts.total == 0 ? '✔︎ OK': printf(
"     \   '!:%d ✘:%d',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction

" "修改状态栏
" "https://shapeshed.com/vim-statuslines/
" "http://yyq123.blogspot.com/2009/10/vim-statusline.html
" set statusline=
" "set statusline=\ \>\ %f%m
" "set statusline+=%#PmenuSel#
" set statusline+=%#LineNr#
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %{LinterStatus()}
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ %{&fileformat}
" set statusline+=\ %p%%
" "set statusline+=\ %l:%c
" "set statusline+=\ %t
" set statusline+=\ %y
" set statusline+=\ %{winnr()}
" set statusline+=\ 

Plugin 'itchyny/lightline.vim'
Plugin 'maximbaz/lightline-ale'
Plugin 'ryanoasis/vim-devicons'
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline.vim
" https://github.com/itchyny/lightline.vim/issues/369
" colorscheme 记得在 dracula.vim 中分别调换下 warning 和 error 的文字背景颜色
let g:lightline = {
      \  'colorscheme': 'dracula',
      \  'active': {
      \      'left': [['Mode', 'paste'], [ 'Filename', 'Modified' ]],
      \      'right': [
      \          [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \          [ 'LineInfo' ],
      \          [ 'FileEncoding', 'FileFormat'] ],
      \  },
      \   'inactive': {
      \      'left': [[ 'InFilename' ]],
      \      'right': [
      \          [ 'LineInfo' ],
      \          [ 'FileEncoding', 'FileFormat'] ],
      \  },
      \  'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \  'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \  'mode_map': {
      \      'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
      \      'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
      \   },
      \  'component': {
      \      'percent': '%2p%%', 'percentwin': '%P'
      \  },
      \  'component_function': {
      \      'Mode':            'GetMode',
      \      'Filename':        'GetFilenameIcon',
      \      'InFilename':      'GetInFilenameIcon',
      \      'LineInfo':        'GetLineInfo',
      \      'FileFormat':      'GetFileFormat',
      \      'FileEncoding':    'GetFileEncoding',
      \      'Modified':        'GetModified',
      \  },
      \  'component_expand': {
      \      'linter_checking': 'lightline#ale#checking',
      \      'linter_warnings': 'lightline#ale#warnings',
      \      'linter_errors': 'lightline#ale#errors',
      \      'linter_ok': 'lightline#ale#ok',
      \  },
      \  'component_type': {
      \      'linter_checking': 'left',
      \      'linter_warnings': 'warning',
      \      'linter_errors': 'error',
      \      'linter_ok': 'left',
      \  },
      \ }
" Mode {{{
function! GetMode() abort
    if &buftype == 'terminal'
        return toupper(&buftype)
    elseif s:IsSpecial()
        return toupper(&filetype)
    endif
    return get(g:lightline.mode_map, mode(), '')
endfunction
" }}}

" Filename {{{
function! s:IsSpecial() abort
    return &buftype == 'terminal' || &filetype =~ '\v(help|startify|nerdtree|undotree)'
endfunction

function! s:GetFilename()
    let isReadonly = &readonly ? "\uf023 " : ""
    return isReadonly . expand('%:t')
endfunction

function! GetFilenameIcon() abort
    if s:IsSpecial()
        return "" 
    endif
    if empty(expand('%:t'))
        return '[No Name]'
    endif
    let filename = s:GetFilename()
    let icon = strlen(&filetype) ? " " . WebDevIconsGetFileTypeSymbol() : "no ft"
    return join([filename, icon], "")
endfunction

function! GetInFilenameIcon() abort
    if s:IsSpecial()
        return toupper(&filetype) 
    endif
    if empty(expand('%:t'))
        return '[No Name]'
    endif
    let filename = s:GetFilename()
    let icon = strlen(&filetype) ? " " . WebDevIconsGetFileTypeSymbol() : "no ft"
    return join([filename, icon], "")
endfunction

function! s:IsModified() abort
    return s:IsSpecial() ?  ""  :
    \      &modified     ?  ' ' :
    \      &modifiable   ?  ""  : '-'
endfunction

function! GetModified() abort
    if s:IsSpecial()
        return ""
    endif
    let isModified = s:IsModified()
    return empty(isModified) ? "" : isModified
endfunction
" }}}

" LineInfo {{{
function! GetLineInfo() abort
    if s:IsSpecial()
        return ""
    endif
    return printf("%2d:%-2d ☰  %2d%%", line('.'), col('.'), 100 * line('.') / line('$'))
endfunction
" }}}

" FileFormat {{{
function! GetFileFormat()
    if s:IsSpecial() || winwidth(0) <= 70
        return ""
    endif
    return &fileformat . " " . WebDevIconsGetFileFormatSymbol()
endfunction

" FileEncoding {{{
function! GetFileEncoding()
    if s:IsSpecial() || winwidth(0) <= 70
        return ""
    endif
    return empty(&fenc) ? &enc : &fenc
endfunction
" }}}
" }}}


" https://fontawesome.com/icons?d=gallery&m=free
" install nerd-font: https://github.com/ryanoasis/nerd-fonts
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 :"
let g:lightline#ale#indicator_errors = "\uf05e :"
let g:lightline#ale#indicator_ok = "\uf00c"
"}}}

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
nnoremap <Leader>h :History
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

