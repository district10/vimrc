" echo 'source path/to/this/file' > ~/.vimrc
" e.g.
"   source d:/tzx/git/vimrc/vimrc.vim
"   source ~/git/vimrc/vimrc.vim
"   for windows, copy this file to c://users/<user>/_vimrc

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936

let mapleader = ","
let g:mapleader = ","
let @f="A -<"

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

map <leader>a ggVG
map <leader>o o<esc>S<esc>
map <leader>u :undolist<cr>
map <leader>file :echo expand("%:p")<cr>:let @+=expand("%:p")<cr>
map <leader>wi vip :call Wikipedia()<cr>
map <leader>cc V :call CCFormating()<cr>
map <leader>sp vip :call PanguSpacing()<cr>
map <leader>rs vipJ :call PanguSpacing()<cr> gqqo<esc>
map <leader>tc :call TitleCaseRegion()<cr>
map <leader>gq vipgq
map <leader>t :call MA()<cr>
map <leader>T :call AM()<cr>

" markdown preview
if has("gui_running")
    if has("gui_gtk2")
"       source $VPP/vim-pandoc-preview.vim
    elseif has("gui_macvim")
    elseif has("gui_win32")
    endif
endif

set nocompatible
set cursorline
set ruler
set backspace=indent,eol,start
set history=1000
set autoread
set showcmd
set incsearch                                               " do incremental searching
set ignorecase
set smartcase
set expandtab ts=4 sw=4 sts=4 ai
set path=.,/usr/include,~/git/notes,~/dev/**,d:/tzx/git/notes,d:/tzx/git/caffe-rc3/include,d:/tzx/git/py-faster-rcnn,/usr/include/c++/**
set isfname-=,
set isfname-==
set isfname-={
set isfname-=}
" set lbr                                                     " linebreak
" set shortmess=atI                                           " :h iccf
set nu
set guioptions-=T                                           " set guioptions="", -m (menu bar), :help go-M
set showmatch
set showfulltag
set matchpairs=(:),{:},[:],<:>
set matchtime=5                                             " Show matchtime in 0.5s
set mouse=""
set iskeyword-=_                                            " two words: twenty_one
" \u4e00-\u9fa5, \u3040-\u30FF
"  20223-40869,   12352-12543

set nobackup
set nowritebackup
set noswapfile

function! CCFormating()
    silent! '<,'>s/\((\)/\1 /g
    silent! '<,'>s/\()\)/ \1/g
endfunction
function! TitleCaseRegion()
    silent! '<,'>s/\v<(.)(\w*)/\u\1\L\2/g
endfunction
function! PanguSpacing()                                " :call PanguSpacing()
    silent! '<,'>s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\([a-zA-Z0-9@#&=\[\$\%\^\-\+(\/\\]\)/\1 \2/g
    silent! '<,'>s/\([a-zA-Z0-9!#&;=\]\,\.\:\?\$\%\^\-\+\)\/\\]\)\([\u4e00-\u9fa5\u3040-\u30FF]\)/\1 \2/g
endfunction
function! PanguSpacingExtra()                           " :call PanguSpacingExtra()
    call PanguSpacing()
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\.\($\|\s\+\)/\1。/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\),\s*/\1，/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\);\s*/\1；/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)!\s*/\1！/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\):\s*/\1：/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)?\s*/\1？/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\\\s*/\1、/g
    silent! %s/(\([\u4e00-\u9fa5\u3040-\u30FF]\)/（\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\))/\1）/g
    silent! %s/\[\([\u4e00-\u9fa5\u3040-\u30FF]\)/『\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\]/\1』/g
    silent! %s/<\([\u4e00-\u9fa5\u3040-\u30FF]\)/《\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)>/\1》/g
endfunction

function! Wikipedia()
    "silent! %s/\[\d\+\]//g "    "[23]" -> "", this function is too dangerous
endfunction

map Q gq            " use Q for formatting

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 14
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h24
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-z> <C-O>u           " Undo in insert mode
if version >= 703
    " Turn undofile on
    set undofile
    " Set undofile path
    set undodir=~/tmp/vim/
endif

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        " autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END
else
    set autoindent
endif " has("autocmd")

"if !exists(":DiffOrig")
"  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
"          \ | wincmd p | diffthis
"endif

"   source $VIMRUNTIME/mswin.vim
"
"       vnoremap <C-X> "+x
"       vnoremap <S-Del> "+x
"       vnoremap <C-C> "+y
"       vnoremap <C-Insert> "+y
"       map <C-V>       "+gP
"       map <S-Insert>      "+gP
"       cmap <C-V>      <C-R>+
"       cmap <S-Insert>     <C-R>+
"       exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
"       exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
"       imap <S-Insert>     <C-V>
"       vmap <S-Insert>     <C-V>
"       noremap <C-Q>       <C-V>   " Use CTRL-Q to do what CTRL-V used to do
"       noremap <C-S>       :update<CR> " Use CTRL-S for saving, also in Insert mode
"       vnoremap <C-S>      <C-C>:update<CR>
"       inoremap <C-S>      <C-O>:update<CR>
"       " CTRL-A is Select all
"       noremap <C-A> gggH<C-O>G
"       inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"       cnoremap <C-A> <C-C>gggH<C-O>G
"       onoremap <C-A> <C-C>gggH<C-O>G
"       snoremap <C-A> <C-C>gggH<C-O>G
"       xnoremap <C-A> <C-C>ggVG

" Delete trailing white space on save
func! DeleteTrailingWS()
    exe "normal mz"
    retab
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.* :call DeleteTrailingWS()
autocmd BufWrite *.tzxnote :call AM()

func! AM()
    exe "normal mz"
    exec ":%! d2q"
    exe "normal `z"
endfunc

func! MA()
    exe "normal mz"
    exec ":%! q2d"
    exe "normal `z"
endfunc

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> r :call VisualSelection('replace')<CR>
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

language messages en_US.utf-8

"set diffexpr="" MyDiff()
function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       let eq = '"'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
endfunction

" silent execute NeoKbd()
function! NeoKbd()
    imap a b
    imap b s
    " a -> s
    " b -> s
endfunction
" so this won't work as expected
"
" instead, use `:set keymap=dvorak` (works only in insert mode)

" source abbr.vim, put abbr.vim in your .vim/plugin/
"   直接用输入法输入 unicode 字符是最好的。
"   在 C:\texlive\2016\texmf-dist\doc\latex\unicode-math 有一个 pdf 示例。
"   [List of logic symbols - Wikipedia](https://en.wikipedia.org/wiki/List_of_logic_symbols)
"
ab 2see                 refs and see also
ab 2whudoc              http://whudoc.qiniudn.com/2017/
ab 2kbd                 <kbd></kbd>

ab 2epsilon             ϵ
ab 2varepsilon          ε

ab 2vardigamma          ϛ

ab 2theta               θ
ab 2vartheta            ϑ

ab 2pi                  π
ab 2varpi               ϖ

ab 2rho                 ρ
ab 2varrho              ϱ

ab 2sigma               σ
ab 2varsigma            ς

ab 2phi                 ϕ
ab 2varphi              φ

ab 2mscrH               ℋ
ab 2mscrL               ℒ
ab 2mscrR               ℛ
ab 2Re                  ℜ
ab 2matheth             ð
ab 2BbbC                ℂ

set formatoptions=BmMcroql

set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf

set linespace=3

" https://github.com/vim-scripts/fcitx.vim/blob/master/so/fcitx.vim
" fcitx.vim  记住插入模式小企鹅输入法的状态
" Author:       lilydjwg
" Maintainer:   lilydjwg
" Note:         另有使用 Python3 接口的新版本
" ---------------------------------------------------------------------
" Load Once:
if (has("win32") || has("win95") || has("win64") || has("win16"))
	" Windows 下不要载入
	finish
endif
if !exists('$DISPLAY') || exists('$SSH_TTY') || has('gui_macvim')
	finish
endif
if &cp || exists("g:loaded_fcitx") || !executable("fcitx-remote")
	finish
endif
let s:keepcpo = &cpo
let g:loaded_fcitx = 1
set cpo&vim
" ---------------------------------------------------------------------
" Functions:
function Fcitx2en()
	let inputstatus = system("fcitx-remote")
	if inputstatus == 2
		let b:inputtoggle = 1
		call system("fcitx-remote -c")
	endif
endfunction
function Fcitx2zh()
	try
		if b:inputtoggle == 1
			call system("fcitx-remote -o")
			let b:inputtoggle = 0
		endif
	catch /inputtoggle/
		let b:inputtoggle = 0
	endtry
endfunction
" ---------------------------------------------------------------------
" Autocmds:
au InsertLeave * call Fcitx2en()
au InsertEnter * call Fcitx2zh()
" ---------------------------------------------------------------------
"  Restoration And Modelines:
let &cpo=s:keepcpo
unlet s:keepcpo
