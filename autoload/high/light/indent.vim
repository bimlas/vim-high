function! high#light#indent#define(settings)
  let lighter = high#main#Clone()

  let lighter._levels = 15
  let lighter._start_level = 0
  let lighter._size = 0
  let lighter._hlgroupA = 'Pmenu'
  let lighter._hlgroupB = 'PmenuSel'

  call high#main#Customize(lighter, a:settings)

  for i in range(lighter._start_level, lighter._levels+1)
    call high#main#AddLighter('indent', extend(high#main#Clone(lighter), {'pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i.'}\\zs\\( \\{'.(lighter._size > 0 ? lighter._size : '".&sw."').'}\\|\\t\\)"', 'hlgroup': lighter[i%2 ? '_hlgroupB' : '_hlgroupA']}))
  endfor
endfunction
