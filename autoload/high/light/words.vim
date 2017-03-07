" Highlight matching words, highlight word under the cursor
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" An example setup to get nicer colors:
"
"   let g:high_lighters = {'words': {'_hlgroups': []}}
"   for color in ['8ccbea', 'a4e57e', 'ffdb72', 'ff7272', 'ffb3ff', '9999ff']
"     exe 'autocmd vimrc ColorScheme,VimEnter * highlight! HighWords'.color.' guibg=#'.color.' guifg=#000000'
"     let g:high_lighters.words._hlgroups += ['HighWords'.color]
"   endfor

let s:hlgroups_index = 0

function! high#light#words#Define()
  return {
  \ '_hlgroups': ['Pmenu', 'PmenuSel', 'PmenuSbar'],
  \ '_map_add': '<Leader>k',
  \ '_map_clear': '<Leader>K',
  \ '__auto_highlight': 0,
  \ '__init_function': function('s:Init'),
  \ }
endfunction

function! s:Init(options)
  exe 'nnoremap <silent> '.a:options._map_add.' :call high#light#words#AddWord(expand("<cword>"))<CR>'
  exe 'nnoremap <silent> '.a:options._map_clear.' :call high#light#words#ClearWords()<CR>'
endfunction

function! high#light#words#AddWord(cword) "{{{
  " TODO: return if group not enabled
  let words = high#group#GetSettings('words')
  let clone = high#core#Clone(words)
  call high#core#AddLighter(clone)

  let clone.pattern = '\<'.a:cword.'\>'

  " Set up the highlight group and switch to the next one.
  let clone.hlgroup = words._hlgroups[s:hlgroups_index]
  let s:hlgroups_index += 1
  if s:hlgroups_index >= len(words._hlgroups)
    let s:hlgroups_index = 0
  endif

  call high#core#ManualHighlight(words, 1)
endfunction "}}}

function! high#light#words#ClearWords() "{{{
  " TODO: return if group not enabled
  call high#core#ManualHighlight(high#group#GetSettings('words'), 0)
endfunction "}}}
