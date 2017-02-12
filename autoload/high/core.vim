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

function! high#core#RegisterGroup(group) "{{{
  if has_key(g:high.registered_groups, a:group)
    return g:high.registered_groups[a:group]
  endif
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

function! high#core#IsRegisteredGroup(group) "{{{
  return has_key(g:high.registered_groups, a:group)
endfunction "}}}

function! high#core#GetGroupSettings(group) "{{{
  return get(g:high.registered_groups, a:group, {})
endfunction "}}}

function! high#core#InitGroup(group) "{{{
  if !has_key(g:high.lighter_groups, a:group)
  \ || !high#utils#IsAutoloaded(a:group)
  \ || len(g:high.lighter_groups[a:group])
    return
  endif
  call high#light#{a:group}#Init(high#core#GetGroupSettings(a:group))
endfunction "}}}

function! high#core#GetGroupMembers(group) "{{{
  return get(g:high.lighter_groups, a:group, [])
endfunction "}}}

function! high#core#Clone(...) "{{{
  return deepcopy(a:0 ? a:1 : g:high.defaults)
endfunction "}}}

function! high#core#AddLighter(lighter) "{{{
  let a:lighter.match_id_index = len(g:high.every_lighter)
  call extend(g:high.every_lighter, [a:lighter])
  call extend(g:high.lighter_groups[a:lighter.group], [a:lighter])
endfunction "}}}

function! high#core#EnabledForFiletype(lighter, filetype) "{{{
  return (len(a:lighter.whitelist) == 0 || index(a:lighter.whitelist, a:filetype) >= 0)
  \ && (len(a:lighter.blacklist) == 0 || index(a:lighter.blacklist, a:filetype) < 0)
endfunction "}}}

function! high#core#MatchAdd(lighter) "{{{
  if !a:lighter.initialized
    call high#light#{a:lighter.group}#Init(a:lighter)
    let a:lighter.initialized = 1
  endif
  if high#core#PatternChanged(a:lighter)
    call high#core#MatchClear(a:lighter)
  endif
  if high#core#GetMatchID(a:lighter) < 0
    call high#core#SetMatchID(a:lighter, matchadd(a:lighter.hlgroup, a:lighter.pattern, a:lighter.priority))
  endif
endfunction "}}}

function! high#core#MatchClear(lighter) "{{{
  if !a:lighter.initialized
    return
  endif
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
  return a:lighter
endfunction "}}}
