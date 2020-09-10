echo ['foo', 3, 'bar']

" nest lists
echo ['foo', [3, 'bar']]

" indexing
echo [0, [1,2]][1]
" => [1,2]

" From last element
echo [0, [1,2]][-2]
" => 0


"" Slicing


echo ['a', 'b', 'c', 'd', 'e'][0:2]
" => ['a', 'b', 'c']
echo ['a', 'b', 'c', 'd', 'e'][0:100000]
" => ['a', 'b', 'c', 'd', 'e']
echo ['a', 'b', 'c', 'd', 'e'][-2:-1]
" => ['d', 'e']
echo ['a', 'b', 'c', 'd', 'e'][:1]
" => ['a', 'b']
echo ['a', 'b', 'c', 'd', 'e'][3:]
" => ['d', 'e']

" Strings
echo "abcd"[0:2]
" => abc
echo "abcd"[-1]
" => empty string! Don't use negative index on strings


"" Concatenation


echo ['a', 'b'] + ['c']
; => ['a', 'b', 'c']


"" List Functions


let foo = ['a']
call add(foo, 'b')
echo foo
" => ['a', 'b']

echo len(foo)

echo get(foo, 0, 'default')
" => a
echo get(foo, 100, 'default')
" => default

echo index(foo, 'b')
" => 1
echo index(foo, 'nope')
" => -1
" careful: when not found, return -1

echo join(foo)
" => a b
echo join(foo, '----')
" => a----b
echo join([1, 2, 3], '')
" => 123

call reverse(foo)
echo foo
" => ['b', 'a']
call reverse(foo)
echo foo
" => ['a', 'b']

