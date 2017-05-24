" Highlight directories in Unite and Denite buffer (`Unite file`)
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#unite_directory#Define()
  return {
  \ 'hlgroup': 'Directory',
  \ 'whitelist': ['unite', 'denite'],
  \ 'pattern': '^\s\(file\s\|directory\s\)\?\zs.*/$',
  \ }
endfunction
