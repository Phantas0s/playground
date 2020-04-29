" ALWAYS use trailing comma
echo {'a': 1, 100: 'foo',}
" => {'a': 1, '100': 'foo'}
" coerce every key as string


" indexing


echo {'a':1, 100:'foo',}['a']
" => 1
echo {'a':1, 100:'foo',}[100]
" => foo
" Index is coerced before looking it up
echo {'a':1, 100:'foo',}.a
" => 1
echo {'a':1, 100:'foo',}.100
" => foo


" Assigning and Adding


let foo = {'a': 1}
let foo.a = 100
let foo.b = 200
echo foo
" => {'a': 100, 'b': 200}


" Removing entries


let test = remove(foo, 'a')
unlet foo.b
echo foo
" => {}
echo test
" => 100

unlet foo['asdf']
" => ERROR

" Prefer remove: do stuff unlet don't


" Dictionary functions


echom get({'a': 100}, 'a', 'default')
" => 100
echom get({'a': 100}, 'b', 'default')
" => default

echom has_key({'a': 100}, 'a')
" => 1
echom has_key({'a': 100}, 'b')
" => 0

echo items({'a': 100, 'b': 200})
" [['a', 100], ['b', 200]]

echo keys({'a': 100, 'b':200})
" => ['a', 'b']
echo values({'a': 100, 'b':200})
" => [100, 200]
