let g:aladdin_source_index = 0
let g:aladdin_loaded_sources = []

let g:aladdin_prototype = aladdin#sources#PROTOTYPE#define()
for source in get(g:, 'aladdin_sources', [{'todo': {'hlgroup': 'WildMenu'}}, {'indent': {'hlgroupA': 'LineNr', 'hlgroupB': 'PandocDefinitionTerm'}}, {'inactive_window': {}}])
  call extend(g:aladdin_loaded_sources, aladdin#sources#{keys(source)[0]}#define(values(source)[0]))
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin_loaded_sources | call source.Highlight() | endfor
augroup END
