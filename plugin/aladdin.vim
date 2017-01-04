let g:aladdin = {
\ 'prototype': aladdin#sources#PROTOTYPE#define(),
\ 'loaded_sources': [],
\ }

let s:default_sources = {
\ 'NOTexists': {
\   '_pattern': 'NOTE'
\ },
\ 'todo': {
\   'hlgroup': 'WildMenu',
\ },
\ 'indent': {
\   'hlgroupA': 'LineNr',
\   'hlgroupB': 'PandocDefinitionTerm',
\   },
\ 'words': {},
\ 'inactive_window': {
\   'blacklist': ['asciidoc'],
\ },
\ }

for [source, settings] in items(get(g:, 'aladdin_sources', s:default_sources))
  try
    call aladdin#sources#{source}#define(settings)
  catch
    let custom = g:aladdin.prototype._Clone()
    call custom._Customize(settings)
    call g:aladdin.prototype._AddSource(custom)
  endtry
endfor

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for source in g:aladdin.loaded_sources | call source.Highlight() | endfor
augroup END
