if 1 "true
    echom "ONE"
endif
" => ONE

if "something" "false
    echom "INDEED"
endif

if "9801"
    echom "WTF?"
endif

if 0
    echom "if"
elseif "nope!"
    echom "elseif"
else
    echom "finally!"
endif
" => finally!

