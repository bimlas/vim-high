function! aladdin#sources#inactive_window#define(settings)
  let obj = g:aladdin.prototype._Clone()
  let obj.hlgroup = 'Comment'
  call obj._Customize(a:settings)

  augroup aladdin_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call g:aladdin.loaded_sources['.obj._index.'].__Update(0)'
    exe 'autocmd WinLeave * call g:aladdin.loaded_sources['.obj._index.'].__Update(1)'
  augroup END "}}}

  function! obj.__Update(enabled) "{{{
    let self.pattern = a:enabled ? '.*' : ''
    let self._haveToUpdate = 1
    call self.Highlight()
  endfunction "}}}

  return [obj]
endfunction
