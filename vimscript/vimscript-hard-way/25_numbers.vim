"" Numbers

" 100
echom 100
" 255
echom 0xff
" 8
echom 010
" 19... treated as decimal since it's not a valid octal!
echom 019

"" Float Formats

echo 100.1
echo 5.45e+3
echo 5.45e-2
" Sign of exponent positiv by default
echo 15.3e9
" Crash. Needs scientific notation (with decimal point and number after)
echo 5e10


"" Coercion

echo 2 * 2.0


" Division

echo 3 / 2
" => 1
echo 3 / 2.0
" => 1.5
