let g:aladdin_loaded_sources = []

let s:index = 0
for source in get(g:, 'aladdin_sources', ['todo', 'indent', 'inactive_window'])
  call extend(g:aladdin_loaded_sources, aladdin#sources#{source}#define(s:index))
  let s:index = len(g:aladdin_loaded_sources)
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin_loaded_sources | call source.Highlight() | endfor
augroup END
