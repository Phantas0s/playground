setlocal foldmethod=indent

a
    b
    c
        d
            e
    w
        e
        a
w
    f
g

" foldlevel line 3
echom foldlevel(3)
" => 0

" foldlevel line 4
echom foldlevel(4)
" => 1

" foldlevel line 5
echom foldlevel(5)
" => 1

" foldlevel line 6
echom foldlevel(6)
" => 2

" foldlevel continue to increase or stay the same till line 11
" From line 3 to 11, one fold
