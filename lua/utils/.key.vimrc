"--普通模式下使用回车键，向下/向上 增加一行
" nnoremap <S-Enter> O<Esc>
" nnoremap <Enter> o<Esc>


"--在普通和插入模式下，向下交换行/向上交换行
" nnoremap <C-j> :m +1<Enter>
" nnoremap <C-k> :m -2<Enter>
" inoremap <C-j> <Esc> :m +1<Enter>gi
" inoremap <C-k> <Esc> :m -2<Enter>gi
" xnoremap <C-j> :m '>+1<Enter>gv=gv
" xnoremap <C-k> :m '<-2<Enter>gv=gv

"--格式化（规范化）文本，即对选定的文本进行换行或重排，适应指定的文本宽度。
" map      Q          gq
" bookmark 切换书签

"search
map      <leader>nh :noh<CR>


nmap      U          <C-R>
xmap      U          <C-R>
" better hjkl
noremap      H          g^
noremap      L          g$
noremap  J          5gj
noremap  K          5gk
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
xnoremap x "_x
" nnoremap X "_X
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C

xnoremap p pgvy
xnoremap P Pgvy

nnoremap \o         o<esc>"*p
nnoremap \O         O<esc>"*p
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
nmap     <C-s>      :w<cr>
nnoremap     <C-v>      p
vnoremap     <C-v>      pgvy
inoremap     <C-v>     <C-r>*
cnoremap     <C-v>     <C-r>*

nmap     <C-a>      ggVG
nnoremap    zv      <C-v>
nmap     <C-z>     u
imap     <C-z>      <esc>u   
nmap     <C-z>      u   
nmap     <C-S-z>    <C-r>
nmap     zw         <c-w>
nmap    zg         za


" noremap Q q
" map q @
" map qq @@

noremap ; :
" noremap : ;
