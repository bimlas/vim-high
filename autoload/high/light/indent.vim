" Highlight the levels of indentation with different colors
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#indent#Define()
  return {
  \ 'priority': -2,
  \ '_levels': 15,
  \ '_start_level': 0,
  \ '_size': 0,
  \ '_hlgroupA': 'Pmenu',
  \ '_hlgroupB': 'PmenuSel',
  \ '__init_function': function('s:Init'),
  \ }
endfunction

function! s:Init(options)
  for i in range(a:options._start_level, a:options._levels-1)
    call high#core#AddLighter(extend(high#core#Clone(a:options), {
    \ 'pattern_to_eval':
    \   '"\\v^( {".&sw."}|\\t){'.i.'}\\zs( {'.(a:options._size > 0 ? a:options._size : '".&sw."').'}|\\t)"',
    \ 'hlgroup':
    \   a:options[i%2 ? '_hlgroupB' : '_hlgroupA'],
    \ }))
  endfor
endfunction
