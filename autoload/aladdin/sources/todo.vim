function! aladdin#sources#todo#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_AddSource(source)

  let source._pattern = 'TODO'

  call aladdin#main#_Customize(source, a:settings)
endfunction
