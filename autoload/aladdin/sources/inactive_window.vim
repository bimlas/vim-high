function! aladdin#sources#inactive_window#define(settings)
  let obj = g:aladdin.prototype._Clone()
  let obj.hlgroup = 'Comment'
  call obj._Customize(a:settings)
  let obj._autoHighlight = 0
  let obj.pattern = '.*'

  augroup aladdin_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call g:aladdin.loaded_sources['.obj._index.']._MatchClear()'
    exe 'autocmd WinLeave * call g:aladdin.loaded_sources['.obj._index.']._MatchAdd()'
  augroup END "}}}

  return [obj]
endfunction
