function! high#light#long_line#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter(lighter)

  let lighter._length = 0
  let lighter._single_column = 0

  call high#main#Customize(lighter, a:settings)

  if lighter._length
    let lighter.pattern = '^.\{'.lighter._length.'}\zs.\+'
  else
    let lighter.pattern_to_eval = '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(lighter._single_column ? '' : '\\+').'" : ""'
  endif
  call high#main#Customize(lighter, a:settings)
endfunction
