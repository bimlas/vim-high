function! high#light#words#define(settings)
  let source = high#main#_Clone()
  call high#main#_AddSource(source)
  " Saving it to use in other functions.
  let s:source = source

  let source.hlgroups = ['Pmenu', 'PmenuSel', 'PmenuSbar']
  let source.map_add = '<Leader>k'
  let source.map_clear = '<Leader>K'

  call high#main#_Customize(source, a:settings)
  let source._autoHighlight = 0
  let source._pattern_to_eval = 'printf("\\<%s\\>", escape(expand("<cword>"), "/\\"))'
  " Points the next color.
  let source._hlgroups_index = 0
  " Don't need to clone the list of already highlighted words, store it
  " outside of clone.
  let s:words = []

  exe 'nnoremap <silent> '.source.map_add.' :call high#light#words#AddWord()<CR>'
  exe 'nnoremap <silent> '.source.map_clear.' :call high#light#words#ClearWords()<CR>'
endfunction

function! high#light#words#AddWord() "{{{
  " Reuse an 'unhighlighted' clone if possible.
  let clone = get(filter(copy(s:words), 'high#main#_GetMatchID(v:val) < 0'), 0, {})
  " Otherwise create a new clone and store in the list to reach to clear the
  " highlighting.
  if !len(clone)
    let clone = high#main#_Clone(s:source)
    call high#main#_AddSource(clone)
    call extend(s:words, [clone])
  endif

  " Set up the highlight group and switch to the next one.
  let clone.hlgroup = s:source.hlgroups[s:source._hlgroups_index]
  let s:source._hlgroups_index += 1
  if s:source._hlgroups_index >= len(s:source.hlgroups)
    let s:source._hlgroups_index = 0
  endif

  call high#main#_ManualHighlight(clone, 1)
endfunction "}}}

function! high#light#words#ClearWords() "{{{
  for word in s:words
    call high#main#_ManualHighlight(word, 0)
  endfor
endfunction "}}}
