function! aladdin#sources#words#define(settings)
  let obj = g:aladdin.prototype._Clone()
  call g:aladdin.prototype._AddSource(obj)
  let obj.hlgroups = ['Pmenu', 'PmenuSel', 'PmenuSbar']
  let obj.map_add = 'b'
  let obj.map_clear = 'B'
  call obj._Customize(a:settings)
  let obj._autoHighlight = 0
  let obj._pattern_to_eval = 'printf("\\<%s\\>", escape(expand("<cword>"), "/\\"))'
  let obj._hlgroups_index = 0

  " Don't need to clone the list of already highlighted words, so store it
  " outside of object.
  let s:words = []

  exe 'nnoremap <silent> '.obj.map_add.' :call g:aladdin.loaded_sources['.obj._index.'].__AddWord()<CR>'
  exe 'nnoremap <silent> '.obj.map_clear.' :call g:aladdin.loaded_sources['.obj._index.'].__ClearWords()<CR>'

  function! obj.__AddWord() "{{{
    " Reuse an 'unhighlighted' clone if possible.
    let clone = get(filter(copy(s:words), 'v:val._GetMatchID() < 0'), 0, {})
    " Otherwise create a new clone and store in the list to reach to clear the
    " highlighting.
    if !len(clone)
      let clone = self._Clone()
      call g:aladdin.prototype._AddSource(clone)
      call extend(s:words, [clone])
    endif

    " Set up the highlight group and switch to the next one.
    let clone.hlgroup = self.hlgroups[self._hlgroups_index]
    let self._hlgroups_index += 1
    if self._hlgroups_index >= len(self.hlgroups)
      let self._hlgroups_index = 0
    endif

    call clone._ManualHighlight(1)
  endfunction "}}}

  function! obj.__ClearWords() "{{{
    for word in s:words
      call word._ManualHighlight(0)
    endfor
  endfunction "}}}

endfunction
