function! high#light#mixed_indent#define(settings)
  let lighter = high#main#Clone()
  call high#main#AddLighter(lighter)

  call high#main#Customize(lighter, a:settings)
  let lighter.pattern = '^ .*\n\zs\t\+\|^\t.*\n\zs \+'

  " Highlight inline mixed indent too.
  let mixed_inline = high#main#Clone(lighter)
  call high#main#AddLighter(mixed_inline)
  let mixed_inline.pattern = '^ \+\zs\t\+\s*\|^\t\+\zs \+\s*'
endfunction
