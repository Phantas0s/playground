echom "bar bar bar"
echom "foo foo foo"
execute "normal! gg/foo\<cr>dd"
" => move to top of file, search foo, delete the line

execute "normal! mqA;\<esc>`q"
" => store current location in mark q
" => insert end of line
" => write a semi colon
" => out of insert mode
" => return to location of mark q

