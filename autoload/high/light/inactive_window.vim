" Make the current window more visible, dim inactive windows
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#inactive_window#define(settings)
  let lighter = high#light#Clone()
  call high#light#AddLighter('inactive_window', lighter)

  let lighter.hlgroup = 'Comment'

  call high#light#Customize(lighter, a:settings)
  let lighter.autoHighlight = 0
  let lighter.pattern = '.*'

  augroup high_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call high#light#ManualHighlight(g:high.lighters['.lighter.match_id_index.'], 0)'
    exe 'autocmd WinLeave * call high#light#ManualHighlight(g:high.lighters['.lighter.match_id_index.'], 1)'
  augroup END "}}}
endfunction
