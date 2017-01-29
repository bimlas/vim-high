" Core of vim-high custom highlighter Vim plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#Highlight(lighter) "{{{
  if a:lighter.autoHighlight
    call high#light#ManualHighlight(a:lighter, 1)
  endif
endfunction "}}}

function! high#light#ManualHighlight(lighter, enabled) "{{{
  if a:lighter.enabled && a:enabled && high#light#EnabledForFiletype(a:lighter, &filetype)
    call high#light#MatchAdd(a:lighter)
  else
    call high#light#MatchClear(a:lighter)
  endif
endfunction "}}}

function! high#light#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#light#AddLighter(name, lighter) "{{{
  let a:lighter.index = len(g:high.lighters)
  call extend(g:high.lighters, [a:lighter])
  call extend(g:high.named_lighters[a:name], [a:lighter])
endfunction "}}}

function! high#light#EnabledForFiletype(lighter, filetype) "{{{
  return (len(a:lighter.whitelist) == 0 || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (len(a:lighter.blacklist) == 0 || index(a:lighter.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#light#MatchAdd(lighter) "{{{
  if high#light#PatternChanged(a:lighter)
    call high#light#MatchClear(a:lighter)
  endif
  if high#light#GetMatchID(a:lighter) < 0
    call high#light#SetMatchID(a:lighter, matchadd(a:lighter.hlgroup, a:lighter.pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#light#MatchClear(lighter) "{{{
  if high#light#GetMatchID(a:lighter) >= 0
    call matchdelete(high#light#GetMatchID(a:lighter))
    call high#light#SetMatchID(a:lighter, -1)
  endif
endfunction "}}}

function! high#light#InitMatchID() "{{{
  if !exists('w:high_match_ids')
    let w:high_match_ids = {}
  endif
endfunction "}}}

function! high#light#GetMatchID(lighter) "{{{
  call high#light#InitMatchID()
  return get(get(w:, 'high_match_ids', []), a:lighter.index, -1)
endfunction "}}}

function! high#light#SetMatchID(lighter, id) "{{{
  call high#light#InitMatchID()
  let w:high_match_ids[a:lighter.index] = a:id
endfunction "}}}

function! high#light#PatternChanged(lighter) "{{{
  if !len(a:lighter.pattern_to_eval)
    return 0
  endif
  let a:lighter.pattern = eval(a:lighter.pattern_to_eval)
  " TODO: find a faster way to detect if the match is exists in the current
  " window.
  let current_match = filter(getmatches(), 'v:val.id == '.high#light#GetMatchID(a:lighter))
  return len(current_match) && (a:lighter.pattern != current_match[0].pattern)
endfunction "}}}

function! high#light#Customize(lighter, settings) "{{{
  for [key, value] in items(a:settings)
    let a:lighter[key] = value
  endfor
endfunction "}}}
