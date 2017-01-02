function! aladdin#sources#todo#define()
  let obj = aladdin#sources#PROTOTYPE#clone()
  let obj.whitelist = ['asciidoc', 'markdown']
  let obj.pattern = 'TODO'
  let obj.hlgroup = 'ErrorMsg'
  return [obj]
endfunction
