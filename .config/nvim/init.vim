set clipboard+=unnamedplus
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:loaded_gtags = 1
let g:loaded_gtags_cscope = 1
