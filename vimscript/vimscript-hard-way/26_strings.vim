echom "Hello"


"" Concatenation

echom "Hello, " + "world"
" => 0
echom "3 mice" + "2 cats"
" => 5
echom 10 + "10.10"
" => 20

echom "Hello, " . "world"
" => Hello, world
echom 10 . "foo"
" => 10foo
echom 10.1 . "foo"
" => error: Using float as a string

"" Special characters

echom "foo \"bar\""
" => foo "bar"
echom "foo\\bar"
" => foo\bar
echo "foo\nbar"
" => foo
" => bar

" echom always display exact characters in string
echom "foo\nbar"
" => foo^@bar


"" Literal Strings


echom '\n\\'
" => \n\\
" exception: two single quotes in a row makes one single quote
echom 'that''s enough'
" => that's enough

"" Exercises

echo "foo\tbar"
" => foo    bar
