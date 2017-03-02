" Make the current window more visible, dim inactive windows
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#inactive_window#Defaults()
  return {
  \ 'hlgroup': 'Comment',
  \ }
endfunction

function! high#light#inactive_window#Rules(options)
  return {
  \ 'autoHighlight': 0,
  \ 'pattern': '.*',
  \ }
endfunction

function! high#light#inactive_window#Init(lighter)
  call high#core#AddLighter(a:lighter)

  augroup high_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call high#core#ManualHighlight(g:high.lighter_groups["'.a:lighter.group.'"]['.a:lighter.match_id_index.'], 0)'
    exe 'autocmd WinLeave * call high#core#ManualHighlight(g:high.lighter_groups["'.a:lighter.group.'"]['.a:lighter.match_id_index.'], 1)'
  augroup END "}}}
endfunction
