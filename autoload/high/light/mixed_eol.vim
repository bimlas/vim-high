function! high#light#mixed_eol#define(settings)
  let source = high#main#_Clone()
  call high#main#_AddSource(source)

  call high#main#_Customize(source, a:settings)

  let source._pattern = '\r'
endfunction
