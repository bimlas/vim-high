function! aladdin#sources#long_line#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_AddSource(source)

  let source.length = 0
  let source.single_column = 0

  call aladdin#main#_Customize(source, a:settings)

  if source.length
    let source._pattern = '^.\{'.source.length.'}\zs.\+'
  else
    let source._pattern_to_eval = '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(source.single_column ? '' : '\\+').'" : ""'
  endif
  call aladdin#main#_Customize(source, a:settings)
endfunction
