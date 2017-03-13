" Make the current window more visible, dim inactive windows
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://github.com/blueyed/vim-diminactive

function! high#light#inactive_window#Define()
  return {
  \ 'hlgroup': 'Comment',
  \ 'pattern': '.*',
  \ '__init_function': function('s:Init'),
  \ '__auto_highlight': 0,
  \ }
endfunction

function! s:Init(options) "{{{
  call high#group#AddMember(a:options)

  augroup high_inactive_window
    autocmd!
    autocmd WinEnter * call high#LightGroup(high#group#GetSettings('inactive_window'), 0)
    autocmd WinLeave * call high#LightGroup(high#group#GetSettings('inactive_window'), 1)
  augroup END
endfunction "}}}
