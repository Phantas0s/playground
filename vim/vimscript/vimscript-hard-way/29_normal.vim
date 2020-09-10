normal G
" => move cursor to last line
normal ggdd
" => delete first line of file


"" Avoiding Mappings

nnoremap G dd
normal G
" => will delete the line!
normal! G
" => won't take mapping set by user into account and goes EOF


"" Special Characters

" normal doesn't parse special characters
:normal! /foo<cr>
" => ... doesn't work!

nnoremap <leader>d dddd
