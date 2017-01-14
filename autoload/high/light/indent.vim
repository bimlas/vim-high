function! high#light#indent#define(settings)
  let lighter = high#main#Clone()

  let lighter.levels = 15
  let lighter.start_level = 0
  let lighter.size = 0
  let lighter.hlgroupA = 'Pmenu'
  let lighter.hlgroupB = 'PmenuSel'

  call high#main#Customize(lighter, a:settings)

  for i in range(lighter.start_level, lighter.levels+1)
    call high#main#AddLighter(extend(high#main#Clone(lighter), {'_pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i.'}\\zs\\( \\{'.(lighter.size > 0 ? lighter.size : '".&sw."').'}\\|\\t\\)"', 'hlgroup': lighter[i%2 ? 'hlgroupB' : 'hlgroupA']}))
  endfor
endfunction
