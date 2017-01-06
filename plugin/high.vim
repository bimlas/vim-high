if exists('g:loaded_high')
  finish
endif
let g:loaded_high = 1

let g:high = {
\ 'lighters': [],
\ }

for [source, settings] in items(get(g:, 'high_lighters', {}))
  try
    call high#light#{source}#define(settings)
  catch
    let custom = high#main#_Clone()
    call high#main#_Customize(custom, settings)
    call high#main#_AddSource(custom)
  endtry
endfor

augroup high
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:high.lighters | call high#main#Highlight(source) | endfor
augroup END
