if vim.b.current_syntax ~= nil then
  return
end

vim.bo.commentstring = '//%s'

local syntax = vim.cmd.syntax

syntax'clear'
syntax'case match'

for _, attrs in ipairs {
  {'vcComment',     '//.*', contains='@Spell' },
  {'vcComment',     '#.*',  contains='@Spell' },

  {'vcLibExt',      [[+libext+\S*]], contains='vcLibExtExt' },
  {'vcLibExtExt',   [[\.\S\+]],      contained=true },

  {'vcIncDir',      [[+incdir+\S*]], contains='vcIncDirDir' },

  {'vcIncDirDir',   [[+incdir+\zs\S*]], contained=true, contains='vcVariable' },

  {'vcLibDir',      [[+libdir+\S*]],    contains='vcLibDirDir' },
  {'vcLibDirDir',   [[+libdir+\zs\S*]], contained=true, contains='vcVariable' },

  {'vcLibDir',      [[-y\s\+\S\+]],   contains='vcLibDirDir' },
  {'vcLibDirDir',   [[-y\s\+\zs\S*]], contained=true, contains='vcVariable' },

  {'vcKeyword',     '-L' },

  {'vcDefine',      [[+define+\S*]],    contains='vcDefineName,vcDefineValue' },
  {'vcDefineName',  [[+\zs[^+=]*\ze=]], contained=true, contains='vcVariable' },
  {'vcDefineValue', [[=\zs\S\+]],       contained=true, contains='vcVariable' },

  {'vcVariable',    [[${\w\+}]] },
  {'vcVariable',    [[$\w\+]] },
} do
  local args = {}

  for k, v in pairs(attrs) do
    if type(k) == 'string' then
      if type(v) == 'boolean' then
        args[#args+1] = k
      else
        args[#args+1] = string.format('%s=%s', k, v)
      end
    end
  end

  syntax{
    'match',
    attrs[1],
    string.format('"%s"', attrs[2]),
    unpack(args)
  }
end

for from, to in pairs {
  vcComment      = 'Comment' ,
  vcDefine       = 'Keyword' ,
  vcDefineAssign = 'Constant',
  vcDefineName   = 'Operator',
  vcDefineValue  = 'Operator',
  vcIncDir       = 'Keyword' ,
  vcKeyword      = 'Keyword' ,
  vcLibDir       = 'Keyword' ,
  vcLibExt       = 'Keyword' ,
  vcLibExtExt    = 'Operator',
  vcVariable     = 'Constant'
} do
  vim.api.nvim_set_hl(0, from, { link = to, default = true })
end

vim.b.current_syntax = 'vc'
