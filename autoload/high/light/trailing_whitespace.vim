" Highlight trailing whitespace, highlight whitespace on end of line
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://github.com/ntpeters/vim-better-whitespace

function! high#light#trailing_whitespace#Define()
  return {
  \ 'pattern': '\s\+$',
  \ }
endfunction
