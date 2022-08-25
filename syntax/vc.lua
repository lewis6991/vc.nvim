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

local function hl_link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to, default = true })
end

hl_link('vcComment'      , 'Comment' )
hl_link('vcDefine'       , 'Keyword' )
hl_link('vcDefineAssign' , 'Constant')
hl_link('vcDefineName'   , 'Operator')
hl_link('vcDefineValue'  , 'Operator')
hl_link('vcIncDir'       , 'Keyword' )
hl_link('vcKeyword'      , 'Keyword' )
hl_link('vcLibDir'       , 'Keyword' )
hl_link('vcLibExt'       , 'Keyword' )
hl_link('vcLibExtExt'    , 'Operator')
hl_link('vcVariable'     , 'Constant')

vim.b.current_syntax = 'vc'
