" Highlight deep indentation, highlight deeply indented code
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://github.com/dodie/vim-disapprove-deep-indentation

function! high#light#deep_indent#Define()
  return {
  \ 'hlgroup': 'CursorLine',
  \ '_min_levels': 5,
  \ '__update_function': function('s:Update'),
  \ }
endfunction

function! s:Update(options) "{{{
  if exists('w:high_deep_indent_prev_sw') && (w:high_deep_indent_prev_sw == &shiftwidth)
    let w:high_deep_indent_prev_sw = &shiftwidth
    return 0
  endif
  let w:high_deep_indent_prev_sw = &shiftwidth

  let a:options.pattern = '\v^\s{'.&shiftwidth*a:options._min_levels.',}|^\t{'.a:options._min_levels.',}'
  return 1
endfunction "}}}
