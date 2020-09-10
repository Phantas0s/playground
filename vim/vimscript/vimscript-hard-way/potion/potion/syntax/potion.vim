if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword loop times to while
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class return
highlight link potionKeyword Keyword

syntax keyword potionFunction print join string
highlight link potionFunction Function

" Need a match regex since comment in potion begins by #
" and # is always never in option iskeyword
" (using very magic mode - always to use for consistency)
syntax match potionComment "\v#.*$"
highlight link potionComment Comment

syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\."
syntax match potionOperator "\v\/"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="
highlight link potionOperator Operator

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String

let b:current_syntax = "potion"
