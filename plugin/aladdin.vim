if exists('g:loaded_aladdin')
  finish
endif
let g:loaded_aladdin = 1

let g:aladdin = {
\ 'patterns': [],
\ }

for [source, settings] in items(get(g:, 'aladdin_sources', {}))
  try
    call aladdin#sources#{source}#define(settings)
  catch
    let custom = aladdin#main#_Clone()
    call aladdin#main#_Customize(custom, settings)
    call aladdin#main#_AddSource(custom)
  endtry
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin.patterns | call aladdin#main#Highlight(source) | endfor
augroup END
