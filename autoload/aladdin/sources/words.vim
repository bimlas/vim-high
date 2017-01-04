function! aladdin#sources#words#define(settings)
  let obj = g:aladdin.prototype._Clone()
  let obj.hlgroup = 'Pmenu'
  let obj.map = 'b'
  call obj._Customize(a:settings)
  let obj._autoHighlight = 0
  let obj._pattern_to_eval = 'printf("\\<%s\\>", escape(expand("<cword>"), "/\\"))'
  call g:aladdin.prototype._AddSource(obj)

  exe 'nnoremap '.obj.map.' :call g:aladdin.loaded_sources['.obj._index.']._ManualHighlight(1)<CR>'
endfunction
