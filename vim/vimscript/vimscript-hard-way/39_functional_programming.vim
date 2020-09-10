function! Sorted(l)
    " create full copy of the list
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction

" echo Sorted([3,2,4,1])
" => [1, 2, 3, 4]

function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

function! Assoc(el, i, val)
    let new_el = deepcopy(a:el)
    let new_el[a:i] = a:val
    return new_el
endfunction

" let l1 = ['1', '2', '10']
" let l2 = Assoc(l1, 2, 3)
" echo l1
" echo l2

" let d1 = {'a': 1, 'b': 2, 'c':10}
" let d2 = Assoc(d1, 'c', 3)
" echo d1
" echo d2

function! Pop(el, i)
    let new_el = deepcopy(a:el)
    call remove(new_el, a:i)
    return new_el
endfunction

function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    call map(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

" let mylist = [[1, 2], [3, 4]]
" echo Mapped(function("Reversed"), mylist)

function! Filtered(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

" let mylist = [[1, 2], [], ['foo'], []]
" echo Filtered(function('len'), mylist)

" Inversed of Filtered (return element when predicate is false)
function! Removed(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, '!' . string(a:fn) . '(v:val)')
    return new_list
endfunction

" let mylist = [[1, 2], [], ['foo'], []]
" echo Removed(function('len'), mylist)

"" Functions as variables

let Myfunc = function("Append")
echo Myfunc([1, 2], 3)
" => [1, 2, 3]

let funcs = [function("Append"), function("Pop")]
echo funcs[1](['a', 'b', 'c'], 1)
" => ['a', 'c']

"" TODO Implement Reduce
