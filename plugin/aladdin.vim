let g:aladdin = {
\ 'prototype': aladdin#sources#PROTOTYPE#define(),
\ 'loaded_sources': [],
\ 'source_index': 0,
\ }

for source in get(g:, 'aladdin_sources', [{'todo': {'hlgroup': 'WildMenu'}}, {'indent': {'hlgroupA': 'LineNr', 'hlgroupB': 'PandocDefinitionTerm'}}, {'inactive_window': {}}])
  call extend(g:aladdin.loaded_sources, aladdin#sources#{keys(source)[0]}#define(values(source)[0]))
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin.loaded_sources | call source.Highlight() | endfor
augroup END
