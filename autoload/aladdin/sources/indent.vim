function! aladdin#sources#indent#define(settings)
  let source = aladdin#main#_Clone()
  let source.priority = -1
  let source.levels = 30
  let source.start_level = 0
  let source.size = 0
  let source.hlgroupA = 'StatusLine'
  let source.hlgroupB = 'StatusLineNC'
  call aladdin#main#_Customize(source, a:settings)

  for i in range(source.start_level, source.levels+1)
    call aladdin#main#_AddSource(extend(aladdin#main#_Clone(source), {'_pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i.'}\\zs\\( \\{'.(source.size > 0 ? source.size : '".&sw."').'}\\|\\t\\)"', 'hlgroup': source[i%2 ? 'hlgroupB' : 'hlgroupA']}))
  endfor
endfunction
