function! s:newAladdinSource()
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
      call matchadd(self.hlgroup, self.pattern, self.priority)
    else
      call clearmatches()
    endif
  endfunction

  return obj
endfunction

function! s:todo()
  let obj = s:newAladdinSource()
  let obj.whitelist = ['asciidoc', 'markdown']
  let obj.pattern = 'TODO'
  let obj.hlgroup = 'ErrorMsg'
  return obj
endfunction

let s:aladdin_patterns = [s:todo()]

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for pattern in s:aladdin_patterns | call pattern.Highlight() | endfor
augroup END
