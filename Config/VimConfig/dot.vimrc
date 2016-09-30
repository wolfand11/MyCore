""""""""""""""""""""""""""""""""""""""""""""""""
" ��ʾ����
""""""""""""""""""""""""""""""""""""""""""""""""
"" ����ʾ�ڸɴ��ͯ
set shortmess=atI 	
set nu
syntax on
"" ����ʾͼ�ΰ�ť
set go=      		
"" ���ñ���
set encoding=utf-8  
set termencoding=utf-8  
set fileencoding=chinese 
set fileencodings=ucs-bom,utf-8,chinese   
set langmenu=zh_CN.utf-8  
language messages zh_cn.utf-8   
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
"" ���ñ�����ɫ
:highlight Normal guibg=Gray

""""""""""""""""""""""""""""""""""""""""""""""""
" ��������
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
"" quit vim
nmap <leader>qq :q<CR>

"-------- insert mode --------
"------ move cursor
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
