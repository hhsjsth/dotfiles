" 在插入模式下ctrl+v为粘贴
inoremap <C-V> <C-R>+
inoremap <C-BS> <C-W>

" undo and  redo
" inoremap <C-Z> <C-O>u
" inoremap <C-Y> <C-O><C-R>
" nnoremap <C-Z> u
" nnoremap <C-Y> <C-R>
nnoremap <leader>u <C-R>
" inoremap <leader>u <C-O><C-R>
" vnoremap <leader>u <C-O><C-R>

" ^ 能够跳到行首第一个字符, 兼容 if/else 和函数的折叠, ]} 兼容紧凑型花括号和换行花括号，能在花括号的语句中间实现折叠，能在函数头处实现折叠，但是可能由于 vscode 的 bug 不能将注释放在代码后面，只能放在上面"
" nnoremap <leader>z ^j]}$v^[{bzf0
nnoremap <leader>z ^j]}j0vb^[{bzf^
" nnoremap <leader>z jva{obolzf
" nnoremap <leader>z 0vj]}lzf " 0 能够跳到行首, ]} 兼容紧凑型花括号和换行花括号，但是不能在花括号的语句中间实现折叠，只能在函数头出实现折叠 "

" save
" normal mode: save
nnoremap <C-S> :w<CR>
" insert mode: escape to normal and save
inoremap <C-S> <C-O>:w<CR>
" visual mode: escape to normal and save
" vnoremap <C-S> <Esc>:w<CR>

" visual mode copy
" vnoremap <C-C> y

" ============ 某些常用老习惯快捷键 ============ "
" ============================================= "

map <A-[> ^[
inoremap jk <Esc>

" ======================================== "
" ============ 使用d删除不剪切 ============ "
" the following mappings will produce:
" d => "delete"
" leader d => "cut"
" nnoremap x "_x
" nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nnoremap c "_c
nnoremap C "_C

vnoremap d "_d
" vnoremap dd "_dd
vnoremap D "_D
vnoremap c "_c
vnoremap C "_C


" nnoremap <leader>x x
" nnoremap <leader>X X
nnoremap <space>d d
nnoremap <space>dd dd
nnoremap <space>D D
nnoremap <space>c c
nnoremap <space>C C
vnoremap <space>d d
vnoremap <space>D D
" vnoremap <leader>dd dd
vnoremap <space>c c
vnoremap <space>C C
" ============ 使用d删除不剪切 ============ "
" ======================================== "
nmap yae :%y +<CR>
