function! aladdin#sources#mixed_indent#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_AddSource(source)
  call aladdin#main#_Customize(source, a:settings)
  let source._pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = aladdin#main#_Clone(source)
  call aladdin#main#_AddSource(mixed_inline)
  let mixed_inline._pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
