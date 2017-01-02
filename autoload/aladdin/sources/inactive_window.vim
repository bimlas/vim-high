function! aladdin#sources#inactive_window#define()
  let obj = aladdin#sources#PROTOTYPE#clone()
  let obj.hlgroup = 'Comment'
  let obj.enabled = 0

  augroup aladdin_inactive_window
    autocmd!
    exe 'autocmd WinEnter * call g:aladdin_loaded_sources['.obj._index.'].Update(0)'
    exe 'autocmd WinLeave * call g:aladdin_loaded_sources['.obj._index.'].Update(1)'
  augroup END

  function! obj.Update(enabled)
    let self.pattern = a:enabled ? '.*' : ''
    let self._haveToUpdate = 1
    call self.Highlight()
  endfunction

  return [obj]
endfunction
