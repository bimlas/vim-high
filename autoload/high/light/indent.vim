function! high#light#indent#define(settings)
  let source = high#main#_Clone()

  let source.priority = -1
  let source.levels = 15
  let source.start_level = 0
  let source.size = 0
  let source.hlgroupA = 'Pmenu'
  let source.hlgroupB = 'PmenuSel'

  call high#main#_Customize(source, a:settings)

  for i in range(source.start_level, source.levels+1)
    call high#main#_AddSource(extend(high#main#_Clone(source), {'_pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i.'}\\zs\\( \\{'.(source.size > 0 ? source.size : '".&sw."').'}\\|\\t\\)"', 'hlgroup': source[i%2 ? 'hlgroupB' : 'hlgroupA']}))
  endfor
endfunction
