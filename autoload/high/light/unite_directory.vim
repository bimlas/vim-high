function! high#light#unite_directory#define(settings)
  let lighter = high#main#_Clone()
  call high#main#_AddLighter(lighter)

  let lighter.hlgroup = 'Directory'

  call high#main#_Customize(lighter, a:settings)
  let lighter.whitelist = ['unite']

  let lighter._pattern = '^\s\(file\s\|directory\s\)\?\zs.*/$'
endfunction
