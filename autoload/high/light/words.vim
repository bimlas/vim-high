" Highlight matching words, highlight word under the cursor
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#light#words#Defaults()
  return {
  \ '_hlgroups': ['Pmenu', 'PmenuSel', 'PmenuSbar'],
  \ '_map_add': '<Leader>k',
  \ '_map_clear': '<Leader>K',
  \ }
endfunction

function! high#light#words#Rules(options)
  return {
  \ '__auto_highlight': 0,
  \ '_hlgroups_index': 0,
  \ }
endfunction

function! high#light#words#Init(lighter)
  exe 'nnoremap <silent> '.a:lighter._map_add.' :call high#light#words#AddWord(expand("<cword>"))<CR>'
  exe 'nnoremap <silent> '.a:lighter._map_clear.' :call high#light#words#ClearWords()<CR>'
endfunction

function! high#light#words#AddWord(cword) "{{{
  " TODO: return if group not enabled
  let words = high#group#GetSettings('words')
  let clone = high#core#Clone(words)
  call high#core#AddLighter(clone)

  let clone.pattern = '\<'.a:cword.'\>'

  " Set up the highlight group and switch to the next one.
  let clone.hlgroup = words._hlgroups[words._hlgroups_index]
  let words._hlgroups_index += 1
  if words._hlgroups_index >= len(words._hlgroups)
    let words._hlgroups_index = 0
  endif

  call high#core#ManualHighlight(words, 1)
endfunction "}}}

function! high#light#words#ClearWords() "{{{
  " TODO: return if group not enabled
  call high#core#ManualHighlight(high#group#GetSettings('words'), 0)
endfunction "}}}
