" echo 'source path/to/this/file' > ~/.vimrc
" e.g.
"   source d:/tzx/git/vimrc/vimrc.vim
"   source ~/git/vimrc/vimrc.vim
"   for windows, copy this file to c://users/<user>/_vimrc
"   for nvim/neovim, mkdir -p ~/.config/nvim && ln -s ~/.vimrc ~/.config/nvim/init.vim

set nu
set expandtab ts=4 sw=4 sts=4 ai
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
set nocompatible
set cursorline
set ruler
set backspace=indent,eol,start
set history=1000
set autoread
set showcmd
set incsearch                                               " do incremental searching
set hlsearch
set ignorecase
set smartcase
set guioptions-=T                                           " set guioptions="", -m (menu bar), :help go-M
set showmatch
set showfulltag
set matchpairs=(:),{:},[:],<:>
set matchtime=5                                             " Show matchtime in 0.5s
set mouse=""
set iskeyword-=_                                            " two words: twenty_one
set nobackup
set nowritebackup
set noswapfile
set linespace=3

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
