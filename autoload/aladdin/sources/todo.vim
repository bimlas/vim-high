function! aladdin#sources#todo#define(settings)
  let obj = aladdin#sources#PROTOTYPE#clone()
  let obj.whitelist = ['asciidoc', 'markdown']
  let obj.pattern = 'TODO'
  let obj.hlgroup = 'ErrorMsg'
  call obj._Customize(a:settings)

  return [obj]
endfunction
