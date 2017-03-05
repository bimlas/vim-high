" Highlight long lines, highlight part of line exceeding textwidth
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#long_line#Define()
  return {
  \ '_length': 0,
  \ '_single_column': 0,
  \ '__init_function': function('s:Init'),
  \ }
endfunction

function! s:Init(options)
  if a:options._length
    let a:options.pattern =
    \ '\%'.string(a:options+1).'v'.(a:options._single_column ? '' : '\\+')
  else
    let a:options.pattern_to_eval =
    \ '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(a:options._single_column ? '' : '\\+').'" : ""'
  endif
  call high#core#AddLighter(a:options)
endfunction
