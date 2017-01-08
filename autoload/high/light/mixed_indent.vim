function! high#light#mixed_indent#define(settings)
  let lighter = high#main#_Clone()
  call high#main#_AddLighter(lighter)

  call high#main#_Customize(lighter, a:settings)
  let lighter._pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = high#main#_Clone(lighter)
  call high#main#_AddLighter(mixed_inline)
  let mixed_inline._pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
