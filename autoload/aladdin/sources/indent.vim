function! aladdin#sources#indent#define()
  let obj = []
  let priority = -1
  for i in range(5)
    call add(obj, extend(deepcopy(aladdin#sources#PROTOTYPE#clone()), {'pattern': '\= "^\\( \\{".&sw."}\\|\\t\\)\\{'.i*2.    '}\\zs\\( \\{".&sw."}\\|\\t\\)"', 'hlgroup': 'StatusLine',   'priority': priority}))
    call add(obj, extend(deepcopy(aladdin#sources#PROTOTYPE#clone()), {'pattern': '\= "^\\( \\{".&sw."}\\|\\t\\)\\{'.(i*2+1).'}\\zs\\( \\{".&sw."}\\|\\t\\)"', 'hlgroup': 'StatusLineNC', 'priority': priority}))
  endfor
  return obj
endfunction
