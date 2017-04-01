" Highlight mixed indentation (mixed tabs and spaces), highlight mixed indent
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_indent#Define()
  return {
  \ 'pattern': '^ .*\n\zs\t\+\|^\t.*\n\zs \+\|^ \+\zs\t\+\s*\|^\t\+\zs \+\s*',
  \ }
endfunction
