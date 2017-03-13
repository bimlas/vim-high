" Highlight the levels of indentation with different colors
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://github.com/nathanaelkane/vim-indent-guides

function! high#light#indent#Define()
  return {
  \ 'priority': -2,
  \ '_levels': 15,
  \ '_start_level': 0,
  \ '_size': 0,
  \ '_hlgroupA': 'Pmenu',
  \ '_hlgroupB': 'PmenuSel',
  \ '__init_function': function('s:Init'),
  \ '__update_function': function('s:Update'),
  \ }
endfunction

function! s:Init(options) "{{{
  for nr in range(a:options._start_level, a:options._levels-1)
    call high#group#AddMember(high#utils#Clone(a:options))
  endfor
endfunction "}}}

function! s:Update(options) "{{{
  if exists('w:high_indent_prev_sw') && (w:high_indent_prev_sw == &shiftwidth)
    let w:high_indent_prev_sw = &shiftwidth
    return 0
  endif
  let w:high_indent_prev_sw = &shiftwidth

  let lighters = high#group#GetMembers('indent')
  for nr in range(a:options._start_level, a:options._levels-1)
    call s:UpdateLighter(lighters[nr], nr)
  endfor
  return 1
endfunction "}}}

function! s:UpdateLighter(lighter, nr) "{{{
  let a:lighter.pattern =
  \ '\v^( {'.&sw.'}|\t){'.a:nr.'}\zs( {'.(a:lighter._size > 0 ? a:lighter._size : &sw).'}|\t)'
  let a:lighter.hlgroup =
  \ a:lighter[a:nr%2 ? '_hlgroupB' : '_hlgroupA']
  return a:lighter
endfunction "}}}
