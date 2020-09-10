" allow user do something like let g:potion_command = /Users/sjl/src/potion/potion
if !exists("g:potion_command")
    let g:potion_command = "potion"
endif


nnoremap <buffer> <localleader>b :call potion#running#PotionShowBytecode()<cr>
nnoremap <buffer> <localleader>r :call potion#running#PotionCompileAndRunFile()<cr>
