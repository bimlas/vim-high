" Core of vim-high custom highlighter Vim plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

let s:match_id_index = 0

function! high#core#Highlight(group_settings) "{{{
  if a:group_settings.autoHighlight
    call high#core#ManualHighlight(a:group_settings, 1)
  endif
endfunction "}}}

function! high#core#ManualHighlight(group_settings, enabled) "{{{
  call high#core#InitMatchID()
  if a:group_settings.enabled && a:enabled && high#core#EnabledForFiletype(a:group_settings, &filetype)
    for lighter in high#group#GetMembers(a:group_settings.group_name)
      call high#core#MatchAdd(lighter)
    endfor
  else
    for lighter in high#group#GetMembers(a:group_settings.group_name)
      call high#core#MatchClear(lighter)
    endfor
  endif
endfunction "}}}

function! high#core#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#core#AddLighter(lighter) "{{{
  let a:lighter.match_id_index = s:match_id_index
  let s:match_id_index += 1
  call extend(g:high.lighter_groups[a:lighter.group_name], [a:lighter])
endfunction "}}}

function! high#core#EnabledForFiletype(lighter, filetype) "{{{
  return (empty(a:lighter.whitelist) || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (empty(a:lighter.blacklist) || index(a:lighter.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#core#MatchAdd(lighter) "{{{
  if high#core#PatternChanged(a:lighter)
    call high#core#MatchClear(a:lighter)
  endif
  if high#core#GetMatchID(a:lighter) < 0
    call high#core#SetMatchID(a:lighter, matchadd(a:lighter.hlgroup, a:lighter.pattern, a:lighter.priority))
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
  if !exists('w:high_match_ids['.a:lighter.match_id_index.']')
    return -1
  endif
  return w:high_match_ids[a:lighter.match_id_index]
endfunction "}}}

function! high#core#SetMatchID(lighter, id) "{{{
  let w:high_match_ids[a:lighter.match_id_index] = a:id
endfunction "}}}

function! high#core#PatternChanged(lighter) "{{{
  if empty(a:lighter.pattern_to_eval)
    return 0
  endif
  let a:lighter.pattern = eval(a:lighter.pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#core#GetMatchID(a:lighter))
  return !empty(current_match) && (a:lighter.pattern != current_match[0].pattern)
endfunction "}}}
