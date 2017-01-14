function! high#light#unite_directory#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter(lighter)

  let lighter.hlgroup = 'Directory'

  call high#main#Customize(lighter, a:settings)
  let lighter.whitelist = ['unite']

  let lighter._pattern = '^\s\(file\s\|directory\s\)\?\zs.*/$'
endfunction