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
\   'priority' : -1,
\   'pattern' : '',
\   'pattern_to_eval' : '',
\   'autoHighlight' : 1,
\   'index' : -1,
\ }
\ }
if exists('g:high_lighters["_"]')
  call high#main#Customize(g:high.defaults, remove(g:high_lighters, '_'))
endif

for [lighter, settings] in items(get(g:, 'high_lighters', {}))
  try
    call high#light#{lighter}#define(settings)
  catch
    let custom = high#main#Clone()
    call high#main#Customize(custom, settings)
    call high#main#AddLighter(custom)
  endtry
endfor

augroup high
  autocmd! WinEnter,BufWinEnter,FileType * for lighter in g:high.lighters | call high#main#Highlight(lighter) | endfor
augroup END
