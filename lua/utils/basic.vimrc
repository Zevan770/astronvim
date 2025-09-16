set scrolloff=9
set incsearch
set hlsearch
" set guifont=LXGWWenKaiMono\ Nerd\ Font:h14
" set guifont=consolaslxgw:h14
set ignorecase
set smartcase
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4

" nmap <c-j> mz:m+<cr>`z
" nmap <c-k> mz:m-2<cr>`z
" vmap <c-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <c-k> :m'<-2<cr>`>my`<mzgv`yo`z
" inoremap <C-j> <Esc> :m +1<Enter>gi
" inoremap <C-k> <Esc> :m -2<Enter>gi

nnoremap [<Space> O<Esc>'[
nnoremap ]<Space> o<Esc>

" nmap gk K
nmap      U          <C-R>
" nunmap <C-R>
" better hjkl
noremap      gh          g^
noremap      gl          g$
"noremap  <c-j>      <c-d>
"noremap  <c-k>      <c-u>
noremap  J          5gj
noremap  K          5gk
" vunmap K
noremap  j          gj
noremap  k          gk
xnoremap >          >gv
xnoremap <          <gv
" highlight last inserted text
nnoremap gV         `[v`]
noremap       m     <C-d>
xnoremap      m     <C-d>
noremap       ,     <C-u>
xnoremap      ,     <C-u>
noremap      M m
xnoremap     M m


" "clipboard
" nnoremap yy         "+yy
" nnoremap y          "+y
" nnoremap Y          "+y$
" nnoremap y          "+y
" xnoremap Y          "+Y
" xnoremap d          "+d
set clipboard=unnamedplus
" nnoremap x "_x
xnoremap x "_x
" nnoremap X "_X
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C

xnoremap P pgvy
xnoremap Y "Iy
xnoremap D "Id

nnoremap gp         o<esc>]p
nnoremap gP         O<esc>[p

" map      <C-D>      <C-D>zz
" map      <C-U>      <C-U>zz
" noremap      <C-e>      3<C-e>zz
" noremap      <C-y>      3<C-y>zz


nmap    <C-S-q>   :q!<CR>

nmap     <C-x>      :x<CR>
nmap     <C-s>      :w<cr>
nmap     <C-c>      :close<CR>

nmap     <C-a>      ggVG
noremap    zv      <C-v>
nmap     zw         <c-w>
"nmap     <space>w         <c-w>
nmap    zg         za
" nmap <enter> za
nnoremap <A-left> <c-o>
nnoremap <A-right> <c-i>
onoremap <space> iw

"map <X1Mouse> <C-O>
"map <X2Mouse> <C-I>
"inoremap , ,<c-g>u
"inoremap . .<c-g>u
"inoremap ; ;<c-g>u

"" works good
"xmap qq Q
"noremap @ q
"noremap q @
"noremap Q @@
"nnoremap qq Q

"noremap ; :
" noremap : ;
" vim:tw=78:ts=8:noet:ft=vim:norl:
