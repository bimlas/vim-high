function! aladdin#sources#inactive_window#define(settings)
  let obj = g:aladdin.prototype._Clone()
  call g:aladdin.prototype._AddSource(obj)
  let obj.hlgroup = 'Comment'
  call obj._Customize(a:settings)
  let obj._autoHighlight = 0
  let obj._pattern = '.*'

  augroup aladdin_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call g:aladdin.loaded_sources['.obj._index.']._ManualHighlight(0)'
    exe 'autocmd WinLeave * call g:aladdin.loaded_sources['.obj._index.']._ManualHighlight(1)'
  augroup END "}}}
endfunction
