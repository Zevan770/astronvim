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
vnoremap >          >gv
vnoremap <          <gv
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
vnoremap Y "Iy
vnoremap D "Id

nnoremap gp         o<esc>]p
nnoremap gP         O<esc>[p

" map      <C-D>      <C-D>zz
" map      <C-U>      <C-U>zz
" noremap      <C-e>      3<C-e>zz
" noremap      <C-y>      3<C-y>zz


nmap    <C-S-q>   :q!<CR>

nmap     <C-x>      :x<CR>
nmap     <C-s>      :w<cr>

nmap     <C-a>      ggVG
noremap    zv      <C-v>
nmap     zw         <c-w>
nmap    zg         za
" nmap <enter> za
nnoremap <A-left> <c-o>
nnoremap <A-right> <c-i>

map <X1Mouse> <C-O>
map <X2Mouse> <C-I>
imap , ,<c-g>u
imap . .<c-g>u
imap ; ;<c-g>u

"noremap ; :
" noremap : ;
