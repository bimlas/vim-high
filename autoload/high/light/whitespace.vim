function! high#light#whitespace#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter(lighter)

  call high#main#Customize(lighter, a:settings)

  let lighter.pattern = '\s\+$'
endfunction
