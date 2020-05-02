" setlocal foldmethod=indent
" setlocal foldignore=

setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum) " v:lnum - line number passed to function

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -1
endfunction

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$' "beginning of line, any number of whitespace, end of line
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

" result
" a       0
" b       >1
"     c   1
"     d   1
" e       0
