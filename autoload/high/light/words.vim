function! high#light#words#define(settings)
  let lighter = high#main#_Clone()
  call high#main#_AddLighter(lighter)
  " Saving it to use in other functions.
  let s:lighter = lighter

  let lighter.hlgroups = ['Pmenu', 'PmenuSel', 'PmenuSbar']
  let lighter.map_add = '<Leader>k'
  let lighter.map_clear = '<Leader>K'

  call high#main#_Customize(lighter, a:settings)
  let lighter._autoHighlight = 0
  let lighter._pattern_to_eval = 'printf("\\<%s\\>", escape(expand("<cword>"), "/\\"))'
  " Points the next color.
  let lighter._hlgroups_index = 0
  " Don't need to clone the list of already highlighted words, store it
  " outside of clone.
  let s:words = []

  exe 'nnoremap <silent> '.lighter.map_add.' :call high#light#words#AddWord()<CR>'
  exe 'nnoremap <silent> '.lighter.map_clear.' :call high#light#words#ClearWords()<CR>'
endfunction

function! high#light#words#AddWord() "{{{
  " Reuse an 'unhighlighted' clone if possible.
  let clone = get(filter(copy(s:words), 'high#main#_GetMatchID(v:val) < 0'), 0, {})
  " Otherwise create a new clone and store in the list to reach to clear the
  " highlighting.
  if !len(clone)
    let clone = high#main#_Clone(s:lighter)
    call high#main#_AddLighter(clone)
    call extend(s:words, [clone])
  endif

  " Set up the highlight group and switch to the next one.
  let clone.hlgroup = s:lighter.hlgroups[s:lighter._hlgroups_index]
  let s:lighter._hlgroups_index += 1
  if s:lighter._hlgroups_index >= len(s:lighter.hlgroups)
    let s:lighter._hlgroups_index = 0
  endif

  call high#main#_ManualHighlight(clone, 1)
endfunction "}}}

function! high#light#words#ClearWords() "{{{
  for word in s:words
    call high#main#_ManualHighlight(word, 0)
  endfor
endfunction "}}}
