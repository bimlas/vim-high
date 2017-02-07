" Highlight directories in Unite buffer (`Unite file` `Unite directory`)
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#unite_directory#Defaults()
  return {
  \ 'hlgroup': 'Directory',
  \ }
endfunction

function! high#light#unite_directory#Rules(options)
  return {
  \ 'whitelist': ['unite'],
  \ 'pattern': '^\s\(file\s\|directory\s\)\?\zs.*/$',
  \ }
endfunction

function! high#light#unite_directory#Init(lighter)
  call high#core#AddLighter(a:lighter)
endfunction
