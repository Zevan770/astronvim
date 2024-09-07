" set clipboard-=unnamed
"设置在光标距离窗口顶部或底部一定行数时，开始滚动屏幕内容的行为
set scrolloff=9
" --递增搜索功能：在执行搜索（使用 / 或 ? 命令）时，
" Vim 会 在您输入搜索模式的过程中逐步匹配并高亮显示匹配的文本。
set incsearch
set guifont=
"--将搜索匹配的文本高亮显示
set hlsearch
set guifont=JetbrainsMono\ Nerd\ font\ mono:h14
"--在搜索时忽略大小写
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set easymotion
source ~/.config/nvim/lua/utils/.key.vimrc
