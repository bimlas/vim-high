" Highlight the levels of indentation with different colors
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#indent#define(settings)
  let lighter = high#core#Clone()

  let lighter._levels = 15
  let lighter._start_level = 0
  let lighter._size = 0
  let lighter._hlgroupA = 'Pmenu'
  let lighter._hlgroupB = 'PmenuSel'

  call high#core#Customize(lighter, a:settings)

  for i in range(lighter._start_level, lighter._levels-1)
    call high#core#AddLighter('indent', extend(high#core#Clone(lighter), {
    \ 'pattern_to_eval':
    \   '"\\v^( {".&sw."}|\\t){'.i.'}\\zs( {'.(lighter._size > 0 ? lighter._size : '".&sw."').'}|\\t)"',
    \ 'hlgroup':
    \   lighter[i%2 ? '_hlgroupB' : '_hlgroupA'],
    \ }))
  endfor
endfunction
