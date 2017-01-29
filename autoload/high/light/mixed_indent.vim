" Highlight mixed indentation (mixed tabs and spaces), highlight mixed indent
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_indent#define(settings)
  let lighter = high#light#Clone()
  call high#light#AddLighter('mixed_indent', lighter)

  call high#light#Customize(lighter, a:settings)
  let lighter.pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = high#light#Clone(lighter)
  call high#light#AddLighter('mixed_indent', mixed_inline)
  let mixed_inline.pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
