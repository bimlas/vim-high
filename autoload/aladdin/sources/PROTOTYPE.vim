function! aladdin#sources#PROTOTYPE#define()
  let obj = {}
  let obj.whitelist = []
  let obj.blacklist = []
  let obj.pattern = ''
  let obj.hlgroup = 'ErrorMsg'
  let obj.priority = 1000

  function! obj._EnabledForFiletype()
    return ((len(self.whitelist) > 0) && (index(self.whitelist, &filetype) >= 0))
    \ || ((len(self.blacklist) > 0) && (index(self.blacklist, &filetype) < 0))
  endfunction

  function! obj.Highlight()
    if self._EnabledForFiletype()
      call matchadd(self.hlgroup, self.pattern =~ '^\\=' ? eval(strpart(self.pattern, 2)) : self.pattern, self.priority)
    else
      call clearmatches()
    endif
  endfunction

  return obj
endfunction
