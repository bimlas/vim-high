" Highlight mixed EOL (mixed end-of-line), highlight ^M
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#mixed_eol#Defaults()
  return {}
endfunction

function! high#light#mixed_eol#Rules(options)
  return {
  \ 'pattern': '\r',
  \ }
endfunction

function! high#light#mixed_eol#Init(lighter)
  call high#core#AddLighter(a:lighter)
endfunction
