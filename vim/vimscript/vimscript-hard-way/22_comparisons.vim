"" == depends on the options set!

set noignorecase
if "foo" == "FOO"
    echom "vim is case insensitive"
elseif "foo" == "foo"
    echom "vim is case sensitive"
endif
" => vim is case sensitive

set ignorecase
if "foo" == "FOO"
    echom "no, it couldn't be"
elseif "foo" == "foo"
    echom "this must be the one"
endif
" => no, it couldn't be

"" Instead, use ==? ==#

" ==? ignore case
set noignorecase
if "foo" ==? "FOO"
    echom "first"
elseif "foo" ==? "foo"
    echom "second"
endif
" => first

" ==# case sensitive
set ignorecase
if "foo" ==# "FOO"
    echom "one"
elseif "foo" ==# "foo"
    echom "two"
endif
" => two
