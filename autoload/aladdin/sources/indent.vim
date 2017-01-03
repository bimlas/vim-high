function! aladdin#sources#indent#define(settings)
  let obj = []
  let preconfigured = g:aladdin.prototype._PrototypeClone()
  let preconfigured.priority = -1
  let preconfigured.levels = 30
  let preconfigured.start_level = 0
  let preconfigured.size = 0
  let preconfigured.hlgroupA = 'StatusLine'
  let preconfigured.hlgroupB = 'StatusLineNC'
  call preconfigured._Customize(a:settings)

  for i in range(preconfigured.start_level, preconfigured.levels+1)
    call add(obj, extend(preconfigured._Clone(), {'pattern_to_eval': '"^\\( \\{".&sw."}\\|\\t\\)\\{'.i.'}\\zs\\( \\{'.(preconfigured.size > 0 ? preconfigured.size : '".&sw."').'}\\|\\t\\)"', 'hlgroup': preconfigured[i%2 ? 'hlgroupB' : 'hlgroupA']}))
  endfor

  return obj
endfunction
