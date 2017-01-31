" Core of vim-high custom highlighter Vim plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#core#Highlight(lighter) "{{{
  if a:lighter.autoHighlight
    call high#core#ManualHighlight(a:lighter, 1)
  endif
endfunction "}}}

function! high#core#ManualHighlight(lighter, enabled) "{{{
  call high#core#InitMatchID()
  if a:lighter.enabled && a:enabled && high#core#EnabledForFiletype(a:lighter, &filetype)
    call high#core#MatchAdd(a:lighter)
  else
    call high#core#MatchClear(a:lighter)
  endif
endfunction "}}}

function! high#core#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#core#AddLighter(name, lighter) "{{{
  let a:lighter.match_id_index = len(g:high.lighters)
  call extend(g:high.lighters, [a:lighter])
  if !has_key(g:high.named_lighters, a:name)
    let g:high.named_lighters[a:name] = []
  endif
  call extend(g:high.named_lighters[a:name], [a:lighter])
endfunction "}}}

function! high#core#EnabledForFiletype(lighter, filetype) "{{{
  return (len(a:lighter.whitelist) == 0 || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (len(a:lighter.blacklist) == 0 || index(a:lighter.blacklist, a:filetype) < 0)
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
  return get(get(w:, 'high_match_ids', []), a:lighter.match_id_index, -1)
endfunction "}}}

function! high#core#SetMatchID(lighter, id) "{{{
  let w:high_match_ids[a:lighter.match_id_index] = a:id
endfunction "}}}

function! high#core#PatternChanged(lighter) "{{{
  if !len(a:lighter.pattern_to_eval)
    return 0
  endif
  let a:lighter.pattern = eval(a:lighter.pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#core#GetMatchID(a:lighter))
  return len(current_match) && (a:lighter.pattern != current_match[0].pattern)
endfunction "}}}

function! high#core#Customize(lighter, settings) "{{{
  for [key, value] in items(a:settings)
    let a:lighter[key] = value
  endfor
endfunction "}}}
