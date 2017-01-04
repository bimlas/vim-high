let g:aladdin = {
\ 'prototype': aladdin#sources#PROTOTYPE#define(),
\ 'loaded_sources': [],
\ }

for [source, settings] in items(get(g:, 'aladdin_sources', {'todo': {'hlgroup': 'WildMenu'}, 'indent': {'hlgroupA': 'LineNr', 'hlgroupB': 'PandocDefinitionTerm'}, 'words': {}, 'inactive_window': {'blacklist': ['asciidoc']}}))
  call aladdin#sources#{source}#define(settings)
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin.loaded_sources | call source.Highlight() | endfor
augroup END
