"" functions need to begin with uppercase

function Meow()
    echom 'Meow!'
endfunction

call Meow()
" => Meow

function GetMeow()
    return 'Meow String!'
endfunction

:echom GetMeow()
" => Meow String!

"" Directly calling function - only useful with functions with side effects

call Meow()
" => Meow!

" Don't do anything
call GetMeow()

" Function always return 0 implicitely, if no return
echom Meow()
" => Meow! 
" => 0

" return 0 if textwidth <# 80
function TextwidthIsTooWide()
    if &l:textwidth ># 80 " & treat option as variable, ># case sensitive whatever option :ignorecase
        return 1
    endif
endfunction

set textwidth=80
if TextwidthIsTooWide() " false
    echom "WARNING: Wide Text!"
endif

set textwidth=100
if TextwidthIsTooWide()
    echom "WARNING: Wide Text This Time!"
endif
" => WARNING: Wide Text This Time!
