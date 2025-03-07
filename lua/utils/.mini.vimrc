set scrolloff=9
set incsearch
set hlsearch
" set guifont=LXGWWenKaiMono\ Nerd\ Font:h14
" set guifont=consolaslxgw:h14
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
" source ~/.config/minimal-vim/.key.vimrc

"--普通模式下使用回车键，向下/向上 增加一行
" nnoremap <S-Enter> O<Esc>
" nnoremap <Enter> o<Esc>

" nmap <c-j> mz:m+<cr>`z
" nmap <c-k> mz:m-2<cr>`z
" vmap <c-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <c-k> :m'<-2<cr>`>my`<mzgv`yo`z

"--在普通和插入模式下，向下交换行/向上交换行
" nnoremap <C-j> :m +1<Enter>
" nnoremap <C-k> :m -2<Enter>
" inoremap <C-j> <Esc> :m +1<Enter>gi
" inoremap <C-k> <Esc> :m -2<Enter>gi
" xnoremap <C-j> :m '>+1<Enter>gv=gv
" xnoremap <C-k> :m '<-2<Enter>gv=gv

nnoremap [<Space> O<Esc>'[
nnoremap ]<Space> o<Esc>

" nmap gk K
nmap      U          <C-R>
" nunmap <C-R>
" better hjkl
noremap      H          g^
noremap      L          g$
noremap  <c-j>      <c-d>
noremap  <c-k>      <c-u>
noremap  J          5gj
noremap  K          5gk
" vunmap K
noremap  j          gj
noremap  k          gk
vnoremap >          >gv
vnoremap <          <gv
" inoremap jk         <Esc>
" inoremap kk         <Esc>
" inoremap kj         <Esc>
" inoremap jj         <Esc>
" highlight last inserted text
nnoremap gV         `[v`]


" "clipboard
" nnoremap yy         "+yy
" nnoremap y          "+y
" nnoremap Y          "+y$
" nnoremap y          "+y
" vnoremap Y          "+Y
" vnoremap d          "+d
set clipboard=unnamedplus
" nnoremap x "_x
vnoremap x "_x
" nnoremap X "_X
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C

vnoremap P pgvy
vnoremap D "Id

nnoremap gp         o<esc>"*p
nnoremap \p         "*p
nnoremap \P         "*P
" nnoremap     >          >>
" nnoremap     <          <<

" vmap     iq         i"
" omap     iq         i"
" vmap     aq         a"
" omap     aq         a"

" map      <C-D>      <C-D>zz
" map      <C-U>      <C-U>zz
" noremap      <C-e>      3<C-e>zz
" noremap      <C-y>      3<C-y>zz


" for windows muscle memory

nmap    <C-S-q>   :q!<CR>
vmap     <C-c>      "+y
vmap     <C-x>      "+d   
nmap     <C-x>      :x<CR>
nmap     <C-s>      :w<cr>
nnoremap     <C-v>      p
vnoremap     <C-v>      pgvy
inoremap     <C-v>     <C-r>*
cnoremap     <C-v>     <C-r>*

nmap     <C-a>      ggVG
noremap    zv      <C-v>
" nmap     <C-z>     u
" imap     <C-z>      <esc>u   
" nmap     <C-z>      u   
" nmap     <C-S-z>    <C-r>
nmap     zw         <c-w>
nmap    zg         za
" nmap <enter> za


" noremap Q q
" map q @
" map qq @@

noremap ; :
" noremap : ;
