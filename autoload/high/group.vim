" Group related functions
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#group#Register(group) "{{{
  let new = high#core#Clone()
  if high#utils#IsAutoloaded(a:group)
    let new = high#core#Customize(new, high#light#{a:group}#Defaults())
    if exists('g:high_lighters')
      call high#core#Customize(new, get(g:high_lighters, a:group, {}))
    endif
    call high#core#Customize(new, high#light#{a:group}#Rules(new))
  else
    let new.initialized = 1
    if exists('g:high_lighters')
      call high#core#Customize(new, get(g:high_lighters, a:group, {}))
    endif
  endif
  let new.group = a:group
  if !has_key(g:high.lighter_groups, a:group)
    let g:high.lighter_groups[a:group] = []
  endif
  let g:high.registered_groups[a:group] = new
  return new
endfunction "}}}

function! high#group#IsRegistered(group) "{{{
  return has_key(g:high.registered_groups, a:group)
endfunction "}}}

function! high#group#GetSettings(group) "{{{
  return get(g:high.registered_groups, a:group, {})
endfunction "}}}

function! high#group#Init(group) "{{{
  if !has_key(g:high.lighter_groups, a:group)
  \ || !high#utils#IsAutoloaded(a:group)
  \ || len(g:high.lighter_groups[a:group])
    return
  endif
  call high#light#{a:group}#Init(high#group#GetSettings(a:group))
endfunction "}}}

function! high#group#GetMembers(group) "{{{
  return get(g:high.lighter_groups, a:group, [])
endfunction "}}}
