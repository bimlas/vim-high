" Highlight long lines, highlight part of line exceeding textwidth
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#long_line#Defaults()
  return {
  \ '_length': 0,
  \ '_single_column': 0,
  \ }
endfunction

function! high#light#long_line#Rules(options)
  if a:options._length
    return {'pattern': '^.\{'.a:options._length.'}\zs.\+'}
  else
    return {'pattern_to_eval':
    \ '&textwidth > 0 ? "\\%".string(&textwidth+1)."v.'.(a:options._single_column ? '' : '\\+').'" : ""'
    \ }
  endif
endfunction

function! high#light#long_line#Init(lighter)
  call high#core#AddLighter(a:lighter)
endfunction
