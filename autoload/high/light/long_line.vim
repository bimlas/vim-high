" Highlight long lines, highlight part of line exceeding textwidth
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://github.com/whatyouhide/vim-lengthmatters

function! high#light#long_line#Define()
  return {
  \ '_length': 0,
  \ '_single_column': 0,
  \ '__init_function': function('s:Init'),
  \ }
endfunction

function! s:Init(options) "{{{
  if a:options._length
    let a:options.pattern =
    \ '\%'.(a:options._length+1).'v.'.(a:options._single_column ? '' : '\+')
  else
    let a:options.__update_function = function('s:Update')
  endif
  call high#group#AddMember(a:options)
endfunction "}}}

function! s:Update(options) "{{{
  let a:options.pattern =
  \ &textwidth > 0 ? '\%'.(&textwidth+1).'v.'.(a:options._single_column ? '' : '\+') : ''
endfunction "}}}
