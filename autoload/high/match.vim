" Core of vim-high custom highlighter Vim plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#match#Add(lighter) "{{{
  if high#match#GetID(a:lighter) < 0
    call high#match#SetID(
    \ a:lighter,
    \ matchadd(a:lighter.hlgroup, a:lighter.pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#match#Clear(lighter) "{{{
  let id = high#match#GetID(a:lighter)
  if id >= 0
    call matchdelete(id)
    call high#match#SetID(a:lighter, -1)
  endif
endfunction "}}}

function! high#match#InitIDs() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#match#GetID(lighter) "{{{
  if !exists('w:high_match_ids['.a:lighter.__match_id_index.']')
    return -1
  endif
  return w:high_match_ids[a:lighter.__match_id_index]
endfunction "}}}

function! high#match#SetID(lighter, id) "{{{
  let w:high_match_ids[a:lighter.__match_id_index] = a:id
endfunction "}}}
