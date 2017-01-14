function! high#main#Highlight(lighter) "{{{
  if a:lighter._autoHighlight
    call high#main#ManualHighlight(a:lighter, 1)
  endif
endfunction "}}}

function! high#main#ManualHighlight(lighter, enabled) "{{{
  if a:enabled && high#main#EnabledForFiletype(a:lighter, &filetype)
    call high#main#MatchAdd(a:lighter)
  else
    call high#main#MatchClear(a:lighter)
  endif
endfunction "}}}

function! high#main#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#main#AddLighter(lighter) "{{{
  let a:lighter._index = len(g:high.lighters)
  call extend(g:high.lighters, [a:lighter])
endfunction "}}}

function! high#main#EnabledForFiletype(lighter, filetype) "{{{
  return (len(a:lighter.whitelist) == 0 || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (len(a:lighter.blacklist) == 0 || index(a:lighter.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#main#MatchAdd(lighter) "{{{
  if high#main#PatternChanged(a:lighter)
    call high#main#MatchClear(a:lighter)
  endif
  if high#main#GetMatchID(a:lighter) < 0
    call high#main#SetMatchID(a:lighter, matchadd(a:lighter.hlgroup, a:lighter._pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#main#MatchClear(lighter) "{{{
  if high#main#GetMatchID(a:lighter) >= 0
    call matchdelete(high#main#GetMatchID(a:lighter))
    call high#main#SetMatchID(a:lighter, -1)
  endif
endfunction "}}}

function! high#main#InitMatchID() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#main#GetMatchID(lighter) "{{{
  call high#main#InitMatchID()
  return get(get(w:, 'high_match_ids', []), a:lighter._index, -1)
endfunction "}}}

function! high#main#SetMatchID(lighter, id) "{{{
  call high#main#InitMatchID()
  let w:high_match_ids[a:lighter._index] = a:id
endfunction "}}}

function! high#main#PatternChanged(lighter) "{{{
  if !len(a:lighter._pattern_to_eval)
    return 0
  endif
  let a:lighter._pattern = eval(a:lighter._pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#main#GetMatchID(a:lighter))
  return len(current_match) && (a:lighter._pattern != current_match[0].pattern)
endfunction "}}}

function! high#main#Customize(lighter, settings) "{{{
  for [key, value] in items(a:settings)
    let a:lighter[key] = value
  endfor
endfunction "}}}
