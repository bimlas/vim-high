function! high#light#mixed_eol#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter('mixed_eol', lighter)

  call high#main#Customize(lighter, a:settings)

  let lighter.pattern = '\r'
endfunction
