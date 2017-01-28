" Highlight mixed EOL (mixed end-of-line), highlight ^M
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_eol#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter('mixed_eol', lighter)

  call high#main#Customize(lighter, a:settings)

  let lighter.pattern = '\r'
endfunction
