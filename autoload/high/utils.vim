" Utility functions, helpers
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#utils#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#utils#ListOfGroupNames() "{{{
  let autoloaded = map(
  \ split(globpath(&runtimepath, 'autoload/high/light/*'), '\n'),
  \ 'fnamemodify(v:val, ":p:t:r")')

  if exists('g:high_lighters')
    let user_defined = keys(g:high_lighters)
    call filter(user_defined, 'index(autoloaded, v:val) < 0')
  else
    let user_defined = []
  endif
  return sort(autoloaded + user_defined)
endfunction "}}}
