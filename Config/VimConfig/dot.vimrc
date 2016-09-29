""""""""""""""""""""""""""""""""""""""""""""""""
" 显示设置
""""""""""""""""""""""""""""""""""""""""""""""""
"" 不显示乌干达儿童
set shortmess=atI 	
set nu
syntax on
""不显示图形按钮
set go=      		
""""""""""""""""""""""""""""""""""""""""""""""""
" 键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "

"-------- normal mode --------
"------ file opt
"" open vimrc
nmap <silent> <leader>f. :e $MYVIMRC<CR>
"" reload _vimrc
nmap <leader>r. :so $MYVIMRC<CR>

"" save current file
nmap <leader>fs :w<CR>
"" open file in new tab
nmap <leader>bb :tabe<Space>
"" open file in cur tab
nmap <leader>ff :e<Space>
"" close cur file
nmap <leader>bd :tabc<CR>

"-------- insert mode --------
"------ move cursor
iunmap <M-b>
iunmap <M-f>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <M-b> <S-Left>
inoremap <M-f> <S-Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
"------ edit content
inoremap <C-d> <Del>
inoremap <M-d> <C-o>dw

"-------- commond mode --------
"------ move cursor
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"------ edit content
cnoremap <C-d> <Del>
cnoremap <M-d> <C-o>dw

