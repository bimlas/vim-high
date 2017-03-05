" Highlight directories in Unite buffer (`Unite file` `Unite directory`)
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#unite_directory#Define()
  return {
  \ 'hlgroup': 'Directory',
  \ '__rules': {
  \   'whitelist': ['unite'],
  \   'pattern': '^\s\(file\s\|directory\s\)\?\zs.*/$',
  \ },
  \ }
endfunction
