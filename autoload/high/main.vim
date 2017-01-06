let s:settings = {}
let s:settings.whitelist = []
let s:settings.blacklist = []
let s:settings.hlgroup = 'ErrorMsg'
let s:settings.priority = 1000
let s:settings._pattern = ''
let s:settings._pattern_to_eval = ''
let s:settings._autoHighlight = 1
let s:settings._index = -1

function! high#main#Highlight(source) "{{{
  if a:source._autoHighlight
    call high#main#_ManualHighlight(a:source, 1)
  endif
endfunction "}}}

function! high#main#_ManualHighlight(source, enabled) "{{{
  if a:enabled && high#main#_EnabledForFiletype(a:source, &filetype)
    call high#main#_MatchAdd(a:source)
  else
    call high#main#_MatchClear(a:source)
  endif
endfunction "}}}

function! high#main#_Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : s:settings)
endfunction "}}}

function! high#main#_AddSource(source) "{{{
  let a:source._index = len(g:high.lighters)
  call extend(g:high.lighters, [a:source])
endfunction "}}}

function! high#main#_EnabledForFiletype(source, filetype) "{{{
  return (len(a:source.whitelist) == 0 || index(a:source.whitelist, a:filetype) >= 0)
  \ && (len(a:source.blacklist) == 0 || index(a:source.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#main#_MatchAdd(source) "{{{
  if high#main#_PatternChanged(a:source)
    call high#main#_MatchClear(a:source)
  endif
  if high#main#_GetMatchID(a:source) < 0
    call high#main#_SetMatchID(a:source, matchadd(a:source.hlgroup, a:source._pattern, a:source.priority))
  endif
endfunction "}}}

function! high#main#_MatchClear(source) "{{{
  if high#main#_GetMatchID(a:source) >= 0
    call matchdelete(high#main#_GetMatchID(a:source))
    call high#main#_SetMatchID(a:source, -1)
  endif
endfunction "}}}

function! high#main#_InitMatchID() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#main#_GetMatchID(source) "{{{
  call high#main#_InitMatchID()
  return get(get(w:, 'high_match_ids', []), a:source._index, -1)
endfunction "}}}

function! high#main#_SetMatchID(source, id) "{{{
  call high#main#_InitMatchID()
  let w:high_match_ids[a:source._index] = a:id
endfunction "}}}

function! high#main#_PatternChanged(source) "{{{
  if !len(a:source._pattern_to_eval)
    return 0
  endif
  let a:source._pattern = eval(a:source._pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#main#_GetMatchID(a:source))
  return len(current_match) && (a:source._pattern != current_match[0].pattern)
endfunction "}}}

function! high#main#_Customize(source, settings) "{{{
  for [key, value] in items(a:settings)
    let a:source[key] = value
  endfor
endfunction "}}}
