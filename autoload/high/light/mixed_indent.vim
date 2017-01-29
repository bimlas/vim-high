" Highlight mixed indentation (mixed tabs and spaces), highlight mixed indent
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_indent#define(settings)
  let lighter = high#core#Clone()
  call high#core#AddLighter('mixed_indent', lighter)

  call high#core#Customize(lighter, a:settings)
  let lighter.pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = high#core#Clone(lighter)
  call high#core#AddLighter('mixed_indent', mixed_inline)
  let mixed_inline.pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
