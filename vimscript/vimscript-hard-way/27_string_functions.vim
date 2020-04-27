"" Length

echo strlen("foo")
" => 3

echo len("foo")
" => 3


"" Splitting

echo split("one two three")
" => ['one', 'two', 'three']

" Other than whitespace for splitting
echo split("one,two,three", ",")
" => ['one', 'two', 'three']


"" Joining


echo join(['one', 'two', 'three'])
" => one two three
echo join(['one', 'two', 'three'], ",")
" => one,two,three


"" Lowwer and Upper Case

echom tolower("FOO")
" => foo
echom toupper("foo")
" => FOO


"" Exercises

echo split('1 2')
" => ['1', '2']
echo split ('1,,,2', ',')
" => ['1', '', '', '2']
