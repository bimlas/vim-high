function! high#light#long_line#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter(lighter)

  let lighter.length = 0
  let lighter.single_column = 0

  call high#main#Customize(lighter, a:settings)

  if lighter.length
    let lighter._pattern = '^.\{'.lighter.length.'}\zs.\+'
  else
    let lighter._pattern_to_eval = '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(lighter.single_column ? '' : '\\+').'" : ""'
  endif
  call high#main#Customize(lighter, a:settings)
endfunction
