" Highlight directories in Unite buffer (`Unite file` `Unite directory`)
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#unite_directory#define(settings)
  let lighter = high#core#Clone()
  call high#core#AddLighter('unite_directory', lighter)

  let lighter.hlgroup = 'Directory'

  call high#core#Customize(lighter, a:settings)
  let lighter.whitelist = ['unite']

  let lighter.pattern = '^\s\(file\s\|directory\s\)\?\zs.*/$'
endfunction
