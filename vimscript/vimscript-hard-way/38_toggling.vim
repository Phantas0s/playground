" toggle boolean option
nnoremap <leader>N :setlocal number!<cr>

nnoremap <leader>f :call FoldColumnToggle()<cr>
function! FoldColumnToggle()
    echom &foldcolumn
endfunction

" toggling functionality
nnoremap <leader>N :setlocal number!<cr>

" Can use that for every option
nnoremap <leader>f :call FoldColumnToggle()<cr>
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction


" Toggling Other Things



" first step
nnoremap <leader>q :call QuickfixToggle()<cr>
function! QuickfixToggle()
    copen
endfunction

"use of global variable
let g:quickfix_is_open = 0

nnoremap <leader>q :call QuickfixToggle()<cr>
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" To come back where we were when closing quickfix window
" not bulletproof: user might open new windows while quickfix open
let g:quickfix_is_open = 0

nnoremap <leader>q :call QuickfixToggle()<cr>
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        " bring back cursor when quickfix was open
        execute g:quickfix_return_to_window . "wincmd w"
    else
        " save the current window in new variable
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

