" to experiment with regex support

" max = 10

" print "Starting"

" for i in range(max):
"     print "Counter:", i

" print "Done"

execute "normal! gg/print\<cr>"
" => beginning of the file, search print, put on first match

execute "normal! gg/for .+ in .+\<cr>"
" => doesn't work

execute "normal! gg/for .\\+ in .\\+:\<cr>"
" => works
execute 'normal gg/for .\+ in .\+:\<cr>'
" => doesn't work
" => literal string takes <cr> as character, not special character
execute "normal gg" . '/for .\+ in .\+:' . "\<cr>"
" => works!


"" Very Magic - 4 mode of parsing regular expression, but we don't care except for \v (Very Magic)

execute "normal! gg" . '/\vfor .+ in .+:' . "\<cr>"
" => works!
