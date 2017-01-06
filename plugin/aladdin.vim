let g:aladdin = {
\ 'loaded_sources': [],
\ }
"\ 'prototype': aladdin#sources#PROTOTYPE#define(),

let s:default_sources = {
\ 'todo': {
\   'hlgroup': 'WildMenu',
\ },
\ 'inactive_window': {
\   'blacklist': ['asciidoc'],
\ },
\ 'indent': {
\   'hlgroupA': 'LineNr',
\   'hlgroupB': 'PandocDefinitionTerm',
\   },
\ 'mixed_indent': {},
\ 'mixed_eol': {},
\ 'long_line': {},
\ 'title_description': {},
\ 'words': {},
\ 'NOTexists': {
\   '_pattern': 'NOTE'
\ },
\ }

for [source, settings] in items(get(g:, 'aladdin_sources', s:default_sources))
  try
    call aladdin#sources#{source}#define(settings)
  catch
    let custom = aladdin#main#_Clone()
    call aladdin#main#_Customize(custom, settings)
    call aladdin#main#_AddSource(custom)
  endtry
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin.loaded_sources | call aladdin#main#Highlight(source) | endfor
augroup END
