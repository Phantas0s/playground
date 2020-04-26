set textwidth=80
" echo option textwidth, not variable textwidth thanks to&
echo &textwidth
" => 80

" set an option
let &textwidth=100
set textwidth?
" => textwidth=100
