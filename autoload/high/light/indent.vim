" Highlight the levels of indentation with different colors
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#indent#Defaults()
  return {
  \ '_levels': 15,
  \ '_start_level': 0,
  \ '_size': 0,
  \ '_hlgroupA': 'Pmenu',
  \ '_hlgroupB': 'PmenuSel',
  \ }
endfunction

function! high#light#indent#Rules(options)
  return {}
endfunction

function! high#light#indent#Init(lighter)
  for i in range(a:lighter._start_level, a:lighter._levels-1)
    call high#core#AddLighter(extend(high#core#Clone(a:lighter), {
    \ 'pattern_to_eval':
    \   '"\\v^( {".&sw."}|\\t){'.i.'}\\zs( {'.(a:lighter._size > 0 ? a:lighter._size : '".&sw."').'}|\\t)"',
    \ 'hlgroup':
    \   a:lighter[i%2 ? '_hlgroupB' : '_hlgroupA'],
    \ }))
  endfor
endfunction
