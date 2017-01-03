function! aladdin#sources#indent#define(settings)
  let obj = []
  let preconfigured = g:aladdin.prototype._PrototypeClone()
  let preconfigured.priority = -1
  let preconfigured.hlgroupA = 'StatusLine'
  let preconfigured.hlgroupB = 'StatusLineNC'
  call preconfigured._Customize(a:settings)

  for i in range(5)
    call add(obj, extend(preconfigured._Clone(), {'pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i*2.    '}\\zs\\( \\{".&sw."}\\|\\t\\)"', 'hlgroup': preconfigured.hlgroupA}))
    call add(obj, extend(preconfigured._Clone(), {'pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.(i*2+1).'}\\zs\\( \\{".&sw."}\\|\\t\\)"', 'hlgroup': preconfigured.hlgroupB}))
  endfor

  return obj
endfunction
