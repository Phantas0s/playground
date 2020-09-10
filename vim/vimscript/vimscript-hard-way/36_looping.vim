" for loops

let c = 0
for i in [1, 2 ,3, 4]
    let c+=i
endfor
echom c
" => 10

" while loops

let c = 1
let total = 0

while c <= 4
    let total += c
    let c += 1
endwhile
echom total
" => 10

" on dictionary (not in the book, added for reference)

let dic = {'a': 1, 'b': 2}
echo items(dic)
" => [['a', 1], ['b', 2]]

for [key, value] in items(dic)
    echom 'key: ' . key 
    echom 'value: ' . value
endfor
" => key: a
" => value: 1
" => key: b
" => value: 2
