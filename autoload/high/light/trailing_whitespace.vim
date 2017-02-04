" Highlight trailing whitespace, highlight whitespace on end of line
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#trailing_whitespace#define(settings)
  let lighter = high#core#Clone()
  call high#core#AddLighter('whitespace', lighter)

  call high#core#Customize(lighter, a:settings)

  let lighter.pattern = '\s\+$'
endfunction
