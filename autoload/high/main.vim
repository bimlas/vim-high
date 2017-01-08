let s:settings = {}
let s:settings.whitelist = []
let s:settings.blacklist = []
let s:settings.hlgroup = 'ErrorMsg'
let s:settings.priority = 1000
let s:settings._pattern = ''
let s:settings._pattern_to_eval = ''
let s:settings._autoHighlight = 1
let s:settings._index = -1

function! high#main#Highlight(lighter) "{{{
  if a:lighter._autoHighlight
    call high#main#_ManualHighlight(a:lighter, 1)
  endif
endfunction "}}}

function! high#main#_ManualHighlight(lighter, enabled) "{{{
  if a:enabled && high#main#_EnabledForFiletype(a:lighter, &filetype)
    call high#main#_MatchAdd(a:lighter)
  else
    call high#main#_MatchClear(a:lighter)
  endif
endfunction "}}}

function! high#main#_Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : s:settings)
endfunction "}}}

function! high#main#_AddLighter(lighter) "{{{
  let a:lighter._index = len(g:high.lighters)
  call extend(g:high.lighters, [a:lighter])
endfunction "}}}

function! high#main#_EnabledForFiletype(lighter, filetype) "{{{
  return (len(a:lighter.whitelist) == 0 || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (len(a:lighter.blacklist) == 0 || index(a:lighter.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#main#_MatchAdd(lighter) "{{{
  if high#main#_PatternChanged(a:lighter)
    call high#main#_MatchClear(a:lighter)
  endif
  if high#main#_GetMatchID(a:lighter) < 0
    call high#main#_SetMatchID(a:lighter, matchadd(a:lighter.hlgroup, a:lighter._pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#main#_MatchClear(lighter) "{{{
  if high#main#_GetMatchID(a:lighter) >= 0
    call matchdelete(high#main#_GetMatchID(a:lighter))
    call high#main#_SetMatchID(a:lighter, -1)
  endif
endfunction "}}}

function! high#main#_InitMatchID() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#main#_GetMatchID(lighter) "{{{
  call high#main#_InitMatchID()
  return get(get(w:, 'high_match_ids', []), a:lighter._index, -1)
endfunction "}}}

function! high#main#_SetMatchID(lighter, id) "{{{
  call high#main#_InitMatchID()
  let w:high_match_ids[a:lighter._index] = a:id
endfunction "}}}

function! high#main#_PatternChanged(lighter) "{{{
  if !len(a:lighter._pattern_to_eval)
    return 0
  endif
  let a:lighter._pattern = eval(a:lighter._pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#main#_GetMatchID(a:lighter))
  return len(current_match) && (a:lighter._pattern != current_match[0].pattern)
endfunction "}}}

function! high#main#_Customize(lighter, settings) "{{{
  for [key, value] in items(a:settings)
    let a:lighter[key] = value
  endfor
endfunction "}}}
