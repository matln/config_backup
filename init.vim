" Neovim config
" Firstly, build symbolic link:
" ln -s ~/.init.vim ~/.config/nvim/init.vim

" Vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" --------------  Basic Settings -------------------- {{{
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
    autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
    " autocmd FileType python noremap <buffer> <F2> :call Flake8()<CR>
augroup END
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
      \      'left': [['Mode', 'paste'], ['GitInfo'], [ 'Filename', 'Modified' ]],
      \      'right': [[ 'CocStatus' ], [ 'LineInfo' ], [ 'FileEncoding', 'FileFormat' ]],
      \  },
      \   'inactive': {
      \      'left': [[ 'InFilename' ]],
      \      'right': [[ 'LineInfo' ], [ 'FileEncoding', 'FileFormat']],
      \  },
      \  'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \  'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \  'mode_map': {
      \      'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
      \      'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
      \  },
      \  'component': { 'percent': '%2p%%', 'percentwin': '%P' },
      \  'component_function': { 'Mode': 'GetMode', 'GitInfo': 'GetGitInfo', 'Filename': 'GetFilenameIcon',
      \      'LineInfo': 'GetLineInfo', 'InFilename': 'GetInFilenameIcon', 'FileFormat': 'GetFileFormat',
      \      'FileEncoding': 'GetFileEncoding', 'Modified': 'GetModified', 'CocStatus': 'coc#status'
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

"}}}

" -------------------------------------- LeaderF -------------------------- {{{
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }

" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" let g:Lf_PopupColorscheme = 'dracula'
" let g:Lf_StlColorscheme = 'dracula'

" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_PreviewResult = { 'File': 0, 'Buffer': 0, 'Mru': 0, 'Tag': 0, 'BufTag': 1, 'Function': 1,
        \ 'Line': 0, 'Colorscheme': 0, 'Rg': 0, 'Gtags': 0 }
let g:Lf_PopupPalette = {
        \  'dark': {
        \      'Lf_hl_popup_inputText': { 'guifg': '#87ceeb', 'guibg': '#44475A' },
        \      'Lf_hl_popup_window': { 'guifg': '#F8F8F2', 'guibg': '#282A36' },
        \      'Lf_hl_popup_blank': { 'guifg': 'NONE', 'guibg': '#44475A' },
        \      'Lf_hl_cursorline': { 'guifg': 'NONE' },
        \      'Lf_hl_popup_prompt': { 'guifg': 'NONE' },
        \      'Lf_hl_popup_total': { 'guifg': '#282A36', 'guibg': '#BD93F9' },
        \      'Lf_hl_popup_lineInfo': { 'guifg': '#F8F8F2', 'guibg': '#6272A4' },
        \      'Lf_hl_popup_inputMode': { 'guifg': '#282A36', 'guibg': '#BD93F9' },
        \      'Lf_hl_popup_category': { 'guifg': '#282A36', 'guibg': '#FF5555' },
        \      'Lf_hl_popup_fuzzyMode': { 'guifg': '#282A36', 'guibg': '#FFB86C' },
        \      'Lf_hl_popup_nameOnlyMode': { 'guifg': '#282A36', 'guibg': '#FFB86C' },
        \      'Lf_hl_popup_fullPathMode': { 'guifg': '#282A36', 'guibg': '#FFB86C' },
        \      'Lf_hl_popup_regexMode': { 'guifg': '#282A36', 'guibg': '#FFB86C' },
        \      'Lf_hl_popup_cwd': { 'guifg': 'NONE', 'guibg': '#44475A' },
        \      }
        \  }
 
noremap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>p :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>b :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>h :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>t :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>l :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

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
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"  }}}



" List ends here. Plugins become visible to Vim after this call.
call plug#end()
