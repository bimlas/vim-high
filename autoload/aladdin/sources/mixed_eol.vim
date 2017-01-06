function! aladdin#sources#mixed_eol#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_AddSource(source)

  call aladdin#main#_Customize(source, a:settings)

  let source._pattern = '\r'
endfunction
