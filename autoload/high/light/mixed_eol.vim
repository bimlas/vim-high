" Highlight mixed EOL (mixed end-of-line), highlight ^M
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_eol#Define()
  return {
  \ 'pattern': '\r',
  \ }
endfunction
