"" Relative / Absolute Paths


" display relative path of current file
echom expand('%')
" display absolute path of current file
" :p is a modifier - there are ton of them
echom expand('%:p')
" display absolute path of foo.txt in current directory, even if foo.txt doesn't exist
echom fnamemodify('foo.txt', ':p')


"" Listing Files


" Listing of file in current directory
echo globpath('.', '*')
"... to get a list
echo split(globpath('.', '*'), '\n')
echo split(globpath('.', '*.txt'), '\n')
" recursively list files
echo split(globpath('.', '**'), '\n')

