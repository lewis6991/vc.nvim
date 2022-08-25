if vim.b.current_syntax ~= nil then
  return
end

vim.bo.commentstring = '//%s'

local syntax = vim.cmd.syntax

syntax'clear'
syntax'case match'

syntax[[match vcComment "//.*" contains=@Spell]]
syntax[[match vcComment "#.*"  contains=@Spell]]

syntax[[match vcLibExt    "+libext+\S*" contains=vcLibExtExt]]
syntax[[match vcLibExtExt "\.\S\+"      contained]]

syntax[[match vcIncDir    "+incdir+\S*"    contains=vcIncDirDir]]
syntax[[match vcIncDirDir "+incdir+\zs\S*" contained contains=vcVariable]]

syntax[[match vcLibDir    "+libdir+\S*"    contains=vcLibDirDir]]
syntax[[match vcLibDirDir "+libdir+\zs\S*" contained contains=vcVariable]]

syntax[[match vcLibDir    "-y\s\+\S\+"     contains=vcLibDirDir]]
syntax[[match vcLibDirDir "-y\s\+\zs\S*"   contained contains=vcVariable]]

syntax[[match vcKeyword   "-L"]]

syntax[[match vcDefine      "+define+\S*"    contains=vcDefineName,vcDefineValue]]
syntax[[match vcDefineName  "+\zs[^+=]*\ze=" contained contains=vcVariable]]
syntax[[match vcDefineValue "=\zs\S\+"       contained contains=vcVariable]]

syntax[[match vcVariable "${\w\+}"]]
syntax[[match vcVariable "$\w\+"]]

local hl = vim.api.nvim_set_hl

hl(0, 'vcComment'      , { link = 'Comment'  })
hl(0, 'vcDefine'       , { link = 'Keyword'  })
hl(0, 'vcDefineAssign' , { link = 'Constant' })
hl(0, 'vcDefineName'   , { link = 'Operator' })
hl(0, 'vcDefineValue'  , { link = 'Operator' })
hl(0, 'vcIncDir'       , { link = 'Keyword'  })
hl(0, 'vcKeyword'      , { link = 'Keyword'  })
hl(0, 'vcLibDir'       , { link = 'Keyword'  })
hl(0, 'vcLibExt'       , { link = 'Keyword'  })
hl(0, 'vcLibExtExt'    , { link = 'Operator' })
hl(0, 'vcVariable'     , { link = 'Constant' })

vim.b.current_syntax = 'vc'
