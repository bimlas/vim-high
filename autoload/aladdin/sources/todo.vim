function! aladdin#sources#todo#define(settings)
  let obj = g:aladdin.prototype._Clone()
  let obj.whitelist = ['asciidoc', 'markdown']
  let obj.hlgroup = 'ErrorMsg'
  let obj._pattern = 'TODO'
  call obj._Customize(a:settings)
  call g:aladdin.prototype._AddSource(obj)
endfunction
