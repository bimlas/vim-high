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
\ 'registered_groups': {},
\ 'group_members': {},
\ 'defaults': {
\   'enabled': 1,
\   'whitelist': [],
\   'blacklist': [],
\   'hlgroup': 'ErrorMsg',
\   'priority': -1,
\   'pattern': '',
\   'pattern_to_eval': '',
\   '__group_name': '',
\   '__rules': {},
\   '__init_function': '',
\   '__auto_highlight': 1,
\   '__match_id_index': -1,
\ }
\ }

"                              COMMANDLINE                                {{{1
" ============================================================================

command! -nargs=1 -complete=customlist,high#commandline#Completion
\ HighDisable call high#commandline#Toggle(<f-args>, 0)
command! -nargs=1 -complete=customlist,high#commandline#Completion
\ HighEnable call high#commandline#Toggle(<f-args>, 1)
command! -nargs=1 -complete=customlist,high#commandline#Completion
\ HighToggle call high#commandline#Toggle(<f-args>)

"                              INIT LIGHTERS                              {{{1
" ============================================================================

if exists('g:high_lighters')
  if has_key(g:high_lighters, '_')
    call extend(g:high.defaults, remove(g:high_lighters, '_'))
  endif
  for group in keys(g:high_lighters)
    call high#group#Register(group)
  endfor
endif

"                              AUTOCOMMANDS                               {{{1
" ============================================================================

augroup high
  autocmd! WinEnter,BufWinEnter,FileType *
  \ for group in values(g:high.registered_groups)
  \ | call high#core#Highlight(group)
  \ | endfor
augroup END
