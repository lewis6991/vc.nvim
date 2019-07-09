if exists('b:current_syntax')
   finish
endif

setlocal commentstring=//%s

syntax clear
syntax case match

syntax match vcComment "//.*" contains=@Spell
syntax match vcComment "#.*"  contains=@Spell

syntax match vcLibExt    "+libext+\S*" contains=vcLibExtExt
syntax match vcLibExtExt "\.\S\+"      contained

syntax match vcIncDir    "+incdir+\S*"    contains=vcIncDirDir
syntax match vcIncDirDir "+incdir+\zs\S*" contained contains=vcVariable

syntax match vcLibDir    "+libdir+\S*"    contains=vcLibDirDir
syntax match vcLibDirDir "+libdir+\zs\S*" contained contains=vcVariable

syntax match vcLibDir    "-y\s\+\S\+"     contains=vcLibDirDir
syntax match vcLibDirDir "-y\s\+\zs\S*"   contained contains=vcVariable

syntax match vcKeyword   "-L"

syntax match vcDefine      "+define+\S*"    contains=vcDefineName,vcDefineValue
syntax match vcDefineName  "+\zs[^+=]*\ze=" contained contains=vcVariable
syntax match vcDefineValue "=\zs\S\+"       contained contains=vcVariable

syntax match vcVariable "${\w\+}"
syntax match vcVariable "$\w\+"

hi def link vcComment      Comment
hi def link vcDefine       Keyword
hi def link vcDefineAssign Constant
hi def link vcDefineName   Operator
hi def link vcDefineValue  Operator
hi def link vcIncDir       Keyword
hi def link vcKeyword      Keyword
hi def link vcLibDir       Keyword
hi def link vcLibExt       Keyword
hi def link vcLibExtExt    Operator
hi def link vcVariable     Constant

let b:current_syntax = 'vc'
