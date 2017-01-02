function! aladdin#sources#PROTOTYPE#define(index)
  let obj = {}
  let obj.whitelist = []
  let obj.blacklist = []
  let obj.pattern = ''
  let obj.hlgroup = 'ErrorMsg'
  let obj.priority = 1000
  let obj._matchID = -1
  let obj._haveToUpdate = 0

  function! obj._EnabledForFiletype(filetype)
    return (len(self.whitelist) == 0 || index(self.whitelist, a:filetype) >= 0)
    \ && (len(self.blacklist) == 0 || index(self.blacklist, a:filetype) < 0)
  endfunction

  function! obj._MatchAdd()
    if self._haveToUpdate
      call self._MatchClear()
    endif
    if self._matchID < 0
      let self._matchID = matchadd(self.hlgroup, self.pattern =~ '^\\=' ? eval(strpart(self.pattern, 2)) : self.pattern, self.priority)
    endif
  endfunction

  function! obj._MatchClear()
    if self._matchID >= 0
      call matchdelete(self._matchID)
      let self._matchID = -1
    endif
  endfunction

  function! obj.Highlight()
    if self._EnabledForFiletype(&filetype)
      call self._MatchAdd()
    else
      call self._MatchClear()
    endif
  endfunction

  return obj
endfunction
