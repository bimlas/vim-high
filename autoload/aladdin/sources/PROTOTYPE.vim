function! aladdin#sources#PROTOTYPE#define()
  let obj = {}
  let obj.whitelist = []
  let obj.blacklist = []
  let obj.pattern = ''
  let obj.hlgroup = 'ErrorMsg'
  let obj.priority = 1000
  let obj._haveToUpdate = 0
  let obj._index = 0

  function! obj.Highlight() "{{{
    if self._EnabledForFiletype(&filetype)
      call self._MatchAdd()
    else
      call self._MatchClear()
    endif
  endfunction "}}}

  function! obj._Clone() "{{{
    let clone = self._PrototypeClone()
    let clone._index = g:aladdin.source_index
    let g:aladdin.source_index += 1
    return clone
  endfunction "}}}

  function! obj._PrototypeClone() "{{{
    return deepcopy(self)
  endfunction "}}}

  function! obj._EnabledForFiletype(filetype) "{{{
    return (len(self.whitelist) == 0 || index(self.whitelist, a:filetype) >= 0)
    \ && (len(self.blacklist) == 0 || index(self.blacklist, a:filetype) < 0)
  endfunction "}}}

  function! obj._MatchAdd() "{{{
    if self._haveToUpdate
      call self._MatchClear()
    endif
    if self._GetMatchID() < 0
      call self._SetMatchID(matchadd(self.hlgroup, self.pattern =~ '^\\=' ? eval(strpart(self.pattern, 2)) : self.pattern, self.priority))
    endif
  endfunction "}}}

  function! obj._MatchClear() "{{{
    if self._GetMatchID() >= 0
      call matchdelete(self._GetMatchID())
      call self._SetMatchID(-1)
    endif
  endfunction "}}}

  function! obj._InitMatchID() "{{{
    if !exists('w:aladdin_match_ids')
      let w:aladdin_match_ids = {}
    endif
  endfunction "}}}

  function! obj._GetMatchID() "{{{
    call self._InitMatchID()
    return get(get(w:, 'aladdin_match_ids', []), self._index, -1)
  endfunction "}}}

  function! obj._SetMatchID(id) "{{{
    call self._InitMatchID()
    let w:aladdin_match_ids[self._index] = a:id
  endfunction "}}}

  function! obj._Customize(settings) "{{{
    for [key, value] in items(a:settings)
      let self[key] = value
    endfor
  endfunction "}}}

  return obj
endfunction
