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
  \ '__auto_highlight': 0,
  \ 'pattern': '.*',
  \ }
endfunction

function! high#light#inactive_window#Init(lighter)
  call high#core#AddLighter(a:lighter)

  augroup high_inactive_window "{{{
    autocmd!
    autocmd WinEnter * call high#core#ManualHighlight(high#group#GetSettings('inactive_window'), 0)
    autocmd WinLeave * call high#core#ManualHighlight(high#group#GetSettings('inactive_window'), 1)
  augroup END "}}}
endfunction
