function DisplayName(name)
    echom 'Hello! My name is:'
    " Needs scope a:
    echom a:name
endfunction
call DisplayName('Orgus Poglus')

" Variable-length arguments

function Varg(...)
    echom a:0
    echom a:1
    " Can't use echom with a list
    echo a:000
endfunction

call Varg('a','b')
" => 2
" => a
" => ['a', 'b']

"varargs with regular argument

function Varg2(foo, ...)
    echom a:foo
    echom a:0
    echom a:1
endfunction

call Varg2("a", "b", "c")

" Assignment

" Throw an error - can't reassign argument variable
function Assign(foo)
    let a:foo = "Nope"
    echom a:foo
endfunction

" Good
function AssignGood(foo)
    let foo_tmp = a:foo
    let foo_tmp = "Yep"
    echom foo_tmp
endfunction
call AssignGood("No?")
" => Yep



