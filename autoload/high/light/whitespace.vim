function! high#light#whitespace#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter('whitespace', lighter)

  call high#main#Customize(lighter, a:settings)

  let lighter.pattern = '\s\+$'
endfunction
