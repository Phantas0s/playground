" +----------+
" | PART ONE |
" +----------+

nnoremap <leader>g :grep -R <cWORD> .<cr>
" try it on: foo

" if mapping use on the following, 
" foo;ls
" ls will be executed as well! Imagine with rm :D 

" solution
nnoremap <leader>g :grep -R '<cWORD>' .<cr>

" try on
" that's
" Doesn't work! The quote inside word interferes with quote in grep command

nnoremap <leader>g :execute "grep -R " . shellescape("<cWORD>") . " ."<cr>

" try on
" that's
" Still doesn't work!
" shellescape executed before <cWORD> (or any special string) expanded

echom shellescape("<cWORD>")
" => '<cWORD>'
echom shellescape(expand("<cWORD>"))
" => 'echom'
" Works!

nnoremap <leader>g :execute "grep -R " . shellescape(expand("<cWORD>")) . " ."<cr>
" try on
" that's
" => !grep -n -R 'that'\''s' . /dev/null 2>&1| tee /tmp/nvimzWRR0E/324
" Works now (but 'that'\''s' ????)

" Don't want to go to first result automatically = grep!
nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>

" Automatically open quickfix window
nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" Remove grep output
:nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" +----------+
" | PART TWO |
" +----------+

nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
function! GrepOperator(type)
    echom "Test"
endfunction
" => print Test after a motion (for example iw)

" Visual mode
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>
" visualmode() return one-character string representation the last type of visual mode used v, V or Ctrl-v

" What happens if we use operator in normal mode?
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    echom a:type
endfunction

" pressing viw<leader>g => v
" pressing V<leader>g => V
" pressing <leader>giw => char (used chaterwise motion with operator)
" pressing <leader>gG => line (used linewise motion)

" How to get the text the user is searching for?

nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    echom @@
endfunction
" => return the text we want to cover
" If using == instead of ==#, == v would match V as well if option ignorecase is set!
" @@ is the unamed register, where yank stuff goes

" Escaping text as we did at the beginning
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    echom shellescape(@@)
endfunction

" Running Grep
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
endfunction


" +------------+
" | PART THREE |
" +------------+

" Don't destroy visual selection when select via motion + restore unamed register
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    " save content on unamed register to bring it back at the end
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        " motion, not visual selection anymore
        normal! `[y`]
    else
        return
    endif
    
    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

" Add a namespace
" SID -> tries to find function in script and not in global namespace (issu when mapping used outside of script)
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

" s: -> current script namespace
function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction
