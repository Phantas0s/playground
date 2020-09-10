execute "echom 'Hello, world!'"
" => Hello, world!

execute "rightbelow vsplit " . bufname("#")
" concatenate string with result of bufname command
" bufname("#") returns path of previous buffer
" ... then execute the whole command
