function! high#light#long_line#define(settings)
  let source = high#main#_Clone()
  call high#main#_AddSource(source)

  let source.length = 0
  let source.single_column = 0

  call high#main#_Customize(source, a:settings)

  if source.length
    let source._pattern = '^.\{'.source.length.'}\zs.\+'
  else
    let source._pattern_to_eval = '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(source.single_column ? '' : '\\+').'" : ""'
  endif
  call high#main#_Customize(source, a:settings)
endfunction
