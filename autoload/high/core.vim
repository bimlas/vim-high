" Core of vim-high custom highlighter Vim plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#core#Highlight(group_settings) "{{{
  if a:group_settings.__auto_highlight
    call high#core#HighlightGroup(a:group_settings, 1)
  endif
endfunction "}}}

function! high#core#HighlightGroup(group_settings, enabled) "{{{
  call high#core#InitMatchID()
  if a:enabled && high#group#IsEnabled(a:group_settings)
    if !high#group#IsInitialized(a:group_settings.__group_name)
      call high#group#Init(a:group_settings.__group_name)
    endif
    let have_to_update = high#group#HaveToUpdate(a:group_settings)
    for lighter in high#group#GetMembers(a:group_settings.__group_name)
      if have_to_update
        call high#core#MatchClear(lighter)
      endif
      call high#core#MatchAdd(lighter)
    endfor
  else
    for lighter in high#group#GetMembers(a:group_settings.__group_name)
      call high#core#MatchClear(lighter)
    endfor
  endif
endfunction "}}}

function! high#core#HighlightSingle(lighter, enabled) "{{{
  call high#core#InitMatchID()
  if a:enabled && high#group#IsEnabled(a:lighter)
    call high#core#MatchAdd(a:lighter)
  else
    call high#core#MatchClear(a:lighter)
  endif
endfunction "}}}

function! high#core#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#core#MatchAdd(lighter) "{{{
  if high#core#GetMatchID(a:lighter) < 0
    call high#core#SetMatchID(
    \ a:lighter,
    \ matchadd(a:lighter.hlgroup, a:lighter.pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#core#MatchClear(lighter) "{{{
  let id = high#core#GetMatchID(a:lighter)
  if id >= 0
    call matchdelete(id)
    call high#core#SetMatchID(a:lighter, -1)
  endif
endfunction "}}}

function! high#core#InitMatchID() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#core#GetMatchID(lighter) "{{{
  if !exists('w:high_match_ids['.a:lighter.__match_id_index.']')
    return -1
  endif
  return w:high_match_ids[a:lighter.__match_id_index]
endfunction "}}}

function! high#core#SetMatchID(lighter, id) "{{{
  let w:high_match_ids[a:lighter.__match_id_index] = a:id
endfunction "}}}
