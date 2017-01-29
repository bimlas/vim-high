" Highlight trailing whitespace, highlight whitespace on end of line
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#whitespace#define(settings)
  let lighter = high#light#Clone()
  call high#light#AddLighter('whitespace', lighter)

  call high#light#Customize(lighter, a:settings)

  let lighter.pattern = '\s\+$'
endfunction