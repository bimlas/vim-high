" Highlight mixed indentation (mixed tabs and spaces), highlight mixed indent
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_indent#Defaults()
  return {}
endfunction

function! high#light#mixed_indent#Rules(options)
  return {
  \ 'pattern': '^ .*\n\zs\t\+\|^\t.*\n\zs \+\|^ \+\zs\t\+\s*\|^\t\+\zs \+\s*',
  \ }
endfunction

function! high#light#mixed_indent#Init(lighter)
  call high#core#AddLighter(a:lighter)
endfunction
