function! high#light#mixed_eol#define(settings)
  let lighter = high#main#_Clone()
  call high#main#_AddLighter(lighter)

  call high#main#_Customize(lighter, a:settings)

  let lighter._pattern = '\r'
endfunction
