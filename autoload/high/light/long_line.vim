" Highlight long lines, highlight part of line exceeding textwidth
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#long_line#define(settings)
  let lighter = high#core#Clone()
  call high#core#AddLighter('long_line', lighter)

  let lighter._length = 0
  let lighter._single_column = 0

  call high#core#Customize(lighter, a:settings)

  if lighter._length
    let lighter.pattern = '^.\{'.lighter._length.'}\zs.\+'
  else
    let lighter.pattern_to_eval =
    \ '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(lighter._single_column ? '' : '\\+').'" : ""'
  endif
  call high#core#Customize(lighter, a:settings)
endfunction
