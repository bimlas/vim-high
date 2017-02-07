" Highlight trailing whitespace, highlight whitespace on end of line
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#trailing_whitespace#Defaults()
  return {}
endfunction

function! high#light#trailing_whitespace#Rules(options)
  return {
  \ 'pattern': '\s\+$',
  \ }
endfunction

function! high#light#trailing_whitespace#Init(lighter)
  call high#core#AddLighter(a:lighter)
endfunction
