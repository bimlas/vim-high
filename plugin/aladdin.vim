let s:aladdin_sources = []
for source in get(g:, 'aladdin_sources', ['todo', 'indent'])
  call extend(s:aladdin_sources, aladdin#sources#{source}#define())
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in s:aladdin_sources | call source.Highlight() | endfor
augroup END
