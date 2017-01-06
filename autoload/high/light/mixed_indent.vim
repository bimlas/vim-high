function! high#light#mixed_indent#define(settings)
  let source = high#main#_Clone()
  call high#main#_AddSource(source)

  call high#main#_Customize(source, a:settings)
  let source._pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = high#main#_Clone(source)
  call high#main#_AddSource(mixed_inline)
  let mixed_inline._pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
