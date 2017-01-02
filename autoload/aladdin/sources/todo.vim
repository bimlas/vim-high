function! aladdin#sources#todo#define(index)
  let obj = aladdin#sources#PROTOTYPE#define(0)
  let obj.whitelist = ['asciidoc', 'markdown']
  let obj.pattern = 'TODO'
  let obj.hlgroup = 'ErrorMsg'
  return [obj]
endfunction
