" Highlight anything, create custom highlight in Vim
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

if exists('g:loaded_high')
  finish
endif
let g:loaded_high = 1

"                            DEFAULT SETTINGS                             {{{1
" ============================================================================

let g:high = {
\ 'lighters': [],
\ 'named_lighters': {},
\ 'defaults': {
\   'enabled': 1,
\   'name': '',
\   'whitelist' : [],
\   'blacklist' : [],
\   'hlgroup' : 'ErrorMsg',
\   'priority' : -1,
\   'pattern' : '',
\   'pattern_to_eval' : '',
\   'autoHighlight' : 1,
\   'match_id_index' : -1,
\ }
\ }

"                              COMMANDLINE                                {{{1
" ============================================================================

command! -nargs=1 -complete=customlist,high#commandline#listLighters
\ HighDisable call high#commandline#toggle(<f-args>, 0)
command! -nargs=1 -complete=customlist,high#commandline#listLighters
\ HighEnable call high#commandline#toggle(<f-args>, 1)
command! -nargs=1 -complete=customlist,high#commandline#listLighters
\ HighToggle call high#commandline#toggle(<f-args>)

"                              INIT LIGHTERS                              {{{1
" ============================================================================

if exists('g:high_lighters["_"]')
  call high#light#Customize(g:high.defaults, remove(g:high_lighters, '_'))
endif

for [lighter, settings] in items(get(g:, 'high_lighters', {}))
  let g:high.named_lighters[lighter] = []
  try
    call high#light#{lighter}#define(settings)
  catch
    let custom = high#light#Clone()
    call high#light#Customize(custom, settings)
    call high#light#AddLighter(lighter, custom)
  endtry
endfor

"                              AUTOCOMMANDS                               {{{1
" ============================================================================

augroup high
  autocmd! WinEnter,BufWinEnter,FileType *
  \ for lighter in g:high.lighters
  \ | call high#light#Highlight(lighter)
  \ | endfor
augroup END
