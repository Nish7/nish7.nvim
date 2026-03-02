syntax case match

syntax match prologComment /%.*/
syntax region prologString start=/'/ end=/'/
syntax match prologNumber /\<\d\+\>/

syntax match prologVariable /\<[A-Z_][A-Za-z0-9_]*\>/
syntax match prologAtom /\<[a-z][A-Za-z0-9_]*\>/

syntax match prologPredicate /\<[a-z][A-Za-z1-9_]*\ze(/
syntax match prologOperator /:-\|-->\|,\|\.\|=\.\.\|=\:=\|>=\|<=\|=\|!=/
syntax match prologListDelim /[\[\]\|]/

highlight link prologComment Comment
highlight link prologString String
highlight link prologNumber Number
highlight link prologVariable Identifier
highlight link prologAtom Constant
highlight link prologPredicate Function
highlight link prologOperator Operator
highlight link prologListDelim Delimiter


let b:current_syntax = "prolog"
