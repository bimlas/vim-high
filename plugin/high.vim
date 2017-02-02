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
\ 'every_lighter': [],
\ 'lighter_groups': {},
\ 'defaults': {
\   'enabled': 1,
\   'group': '',
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
  call high#core#Customize(g:high.defaults, remove(g:high_lighters, '_'))
endif

for [group, settings] in items(get(g:, 'high_lighters', {}))
  try
    call high#light#{group}#define(settings)
  catch
    let custom = high#core#Clone()
    call high#core#Customize(custom, settings)
    call high#core#AddLighter(group, custom)
  endtry
endfor

"                              AUTOCOMMANDS                               {{{1
" ============================================================================

augroup high
  autocmd! WinEnter,BufWinEnter,FileType *
  \ for lighter in g:high.every_lighter
  \ | call high#core#Highlight(lighter)
  \ | endfor
augroup END
