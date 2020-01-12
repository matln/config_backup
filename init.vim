" Neovim config
" Firstly, build symbolic link:
" ln -s ~/.init.vim ~/.config/nvim/init.vim

" Vim-plug
call plug#begin('~/.local/share/nvim/plugged')

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
set splitbelow
set laststatus=2
"vim 分屏竖线颜色与符号
set fillchars=vert:\ 
highlight VertSplit ctermfg=NONE cterm=bold
" Enable folding
set foldmethod=marker
set foldlevel=99

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
" }}}

" ---------------------- Mappings ------------------- {{{
let mapleader = ","
let maplocalleader = ","
"split navigations
nnoremap <C-J> jzz
nnoremap <C-K> kzz
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
" autopairs 插件默认把 <C-H> 映射成了 <BS>
let g:AutoPairsMapCh = 0
inoremap <C-H> <Left>
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
onoremap - $
nnoremap - $
vnoremap - $
" ctrl + s 与 ctrl + q 在linux系统下分别为锁定屏幕和复原
" 在系统中禁用这两个按键，然后在vim中利用起来
" 首先在~/.bashrc中加入：stty -ixon
nnoremap <C-S> <C-u>
nnoremap <silent> <C-Q> :nohl<CR>
" inside nest parentheses
onoremap in( :<c-u>normal! f(vi(<cr>    
" inside previous parentheses
onoremap ip( :<c-u>normal! F)vi(<cr>    
" shell command
nnoremap <leader>s :!

" 删除而非剪贴
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim
" "_是黑洞寄存器，通常的 x,d 操作把内容放在了匿名寄存器
" 删除
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
vnoremap d "_d
vnoremap dd "_dd
" 剪贴：通过 visual 模式下的 x，或者前面加<leader>表示原来的剪贴
" nnoremap <leader>x ""x
" nnoremap <leader>X ""X
" nnoremap <leader>d ""d
" nnoremap <leader>dd ""dd
" nnoremap <leader>D ""D
" vnoremap <leader>d ""d
" vnoremap <leader>dd ""dd
" 系统剪切板与匿名寄存器相通
set clipboard=unnamed
" }}}


" -------------------- Colorscheme ------------------ {{{
Plug 'dracula/vim', { 'as': 'dracula' }
set rtp+=~/.local/share/nvim/plugged/dracula
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
Plug 'vim-scripts/indentpython.vim'

"Flagging Unnecessary Whitespace
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" 按照pep8标准自动格式化
Plug 'tell-k/vim-autopep8'

let python_highlight_all=1
" highlight keyword "self", add the following line into the file `$VIMRUNTIME/syntax/python.vim`, need ROOT
"syn keyword pythonStatement self

"需要先在系统安装flake8, 通过pip
Plug 'nvie/vim-flake8'
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


" -------------------------------- RUN ------------------------- {{{

noremap <F6> :call PRUN()<CR>
" `time` 是 shell 中的计时器，`%` 是 vimscript 中的，表示正在编辑文件的相对路径 
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
"  }}}


" --------------------------------- NERDTree -------------------------- {{{
Plug 'scrooloose/nerdtree'
Plug 'weilbith/nerdtree_choosewin-plugin'
"F4快捷键快速切换打开和关闭目录树窗口
noremap <silent> <F3> :NERDTreeToggle<CR>
noremap <F2> :NERDTreeFind
"当剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
"ignore files in NERDTree"
let NERDTreeIgnore=['\.pyc$', '\~$', '\.lock']
"打开vim时自动打开NERDTree
"autocmd vimenter *.py,*.sh,*.pl NERDTree|wincmd p
"窗口是否显示行号
"let g:NERDTreeShowLineNumbers=1
"let g:NERDTreeStatusline='%t'
"状态栏不显示任何信息
let g:NERDTreeStatusline = '%#NonText#'
let g:NERDTreeWinSize= 25
"  }}}


" ----------------------------------- 括号补全 -------------------------- {{{
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutFastWrap = '<C-e>'
"  }}}


" ----------------------------- vista.vim --------------------------- {{{
Plug 'liuchengxu/vista.vim'
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


"  }}}

" --------------------------- lightline ------------------------- {{{
" git wrapper
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline.vim
" https://github.com/itchyny/lightline.vim/issues/369
" colorscheme 记得在 dracula.vim 中分别调换下 warning 和 error 的文字背景颜色
let g:lightline = {
      \  'colorscheme': 'dracula',
      \  'active': {
      \      'left': [['Mode', 'paste'], ['GitInfo'], [ 'Filename', 'Modified' ], [ 'VistaNearestFunction' ]],
      \      'right': [
      \          [ 'CocStatus' ],
      \          [ 'LineInfo' ],
      \          [ 'FileEncoding', 'FileFormat' ] ],
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
      \      'Mode':                   'GetMode',
      \      'GitInfo':                'GetGitInfo',
      \      'Filename':               'GetFilenameIcon',
      \      'LineInfo':               'GetLineInfo',
      \      'InFilename':             'GetInFilenameIcon',
      \      'FileFormat':             'GetFileFormat',
      \      'FileEncoding':           'GetFileEncoding',
      \      'Modified':               'GetModified',
      \      'VistaNearestFunction':   'NearestMethodOrFunction', 
      \      'CocStatus':              'coc#status'
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

" GitInfo {{{
function! GetGitInfo() abort
    if s:IsSpecial()
        return ""
    endif
    let GitBranch = "\uf126 " . fugitive#head()
    return GitBranch 
endfunction
" }}}

" Filename {{{
function! s:IsSpecial() abort
    " qf: markdown toc
    return &buftype == 'terminal' || &filetype =~ '\v(help|startify|nerdtree|qf)'
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
    let icon = strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . " " : "no ft"
    return join([icon, filename], "")
endfunction

function! GetInFilenameIcon() abort
    if s:IsSpecial()
        return toupper(&filetype) 
    elseif empty(expand('%:t'))
        return '[No Name]'
    endif
    let filename = s:GetFilename()
    let icon = strlen(&filetype) ? " " . WebDevIconsGetFileTypeSymbol() : "no ft"
    return join([icon, filename], "")
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

" show the nearest method/function in your statusline
function! NearestMethodOrFunction() abort
    let lens = len(get(b:, 'vista_nearest_method_or_function', ''))
    if lens == 0
        return ''
    else
        return "\uF794#" . get(b:, 'vista_nearest_method_or_function', '')
    endif
endfunction
" }}}
"}}}

" -------------------------------------- fzf -------------------------- {{{
if has('mac')
    set rtp+=/usr/local/opt/fzf
elseif has('unix')
    set rtp+=~/.fzf
endif
Plug 'junegunn/fzf.vim'
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
"  }}}


" ------------------------------ markdown ---------------------------- {{{
if has('mac')
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_toc_autofit = 1
    autocmd! BufNewFile,BufRead *.md setlocal wrap
    autocmd FileType markdown nnoremap <silent> <buffer> <localleader>t :Toc<cr>:vertical resize 40<cr>|
    \ nnoremap <silent> <buffer> <localleader>w :w<cr>:Toc<cr>:vertical resize 40<cr><c-w><c-h>

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
    " let g:mkdp_browser = 'chrome'
endif 
"  }}}

" ----------------------------- coc.nvim ---------------------------- {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

let g:coc_status_error_sign = '✘:'
let g:coc_status_warning_sign = "\uf0e7:"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
"  }}}



" List ends here. Plugins become visible to Vim after this call.
call plug#end()
