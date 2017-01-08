if exists('g:loaded_high')
  finish
endif
let g:loaded_high = 1

let g:high = {
\ 'lighters': [],
\ 'defaults': {
\   'whitelist' : [],
\   'blacklist' : [],
\   'hlgroup' : 'ErrorMsg',
\   'priority' : 1000,
\   '_pattern' : '',
\   '_pattern_to_eval' : '',
\   '_autoHighlight' : 1,
\   '_index' : -1,
\ }
\ }
if exists('g:high_defaults')
  call high#main#_Customize(g:high.defaults, g:high_defaults)
endif

for [lighter, settings] in items(get(g:, 'high_lighters', {}))
  try
    call high#light#{lighter}#define(settings)
  catch
    let custom = high#main#_Clone()
    call high#main#_Customize(custom, settings)
    call high#main#_AddLighter(custom)
  endtry
endfor

augroup high
  autocmd! WinEnter,BufWinEnter,FileType * for lighter in g:high.lighters | call high#main#Highlight(lighter) | endfor
augroup END
