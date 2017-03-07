" Highlight deep indentation, highlight deeply indented code
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#deep_indent#Define()
  return {
  \ 'hlgroup': 'LineNr',
  \ '_min_levels': 5,
  \ 'pattern_to_eval': '"\\v^\\s{".(&shiftwidth*high#group#GetSettings("deep_indent")._min_levels).",}|^\\t{".high#group#GetSettings("deep_indent")._min_levels.",}"',
  \ }
endfunction
