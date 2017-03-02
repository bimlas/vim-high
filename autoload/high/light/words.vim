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
  \ 'autoHighlight': 0,
  \ 'pattern_to_eval': 'printf("\\<%s\\>", escape(expand("<cword>"), "/\\"))',
  \ '_hlgroups_index': 0,
  \ }
endfunction

function! high#light#words#Init(lighter)
  call high#core#AddLighter(a:lighter)
  " Saving it to use in other functions.

  " Don't need to clone the list of already highlighted words, store it
  " outside of clone.
  let s:words = []

  exe 'nnoremap <silent> '.a:lighter._map_add.' :call high#light#words#AddWord()<CR>'
  exe 'nnoremap <silent> '.a:lighter._map_clear.' :call high#light#words#ClearWords()<CR>'
endfunction

function! high#light#words#AddWord() "{{{
  let settings = high#group#GetSettings('words')
  let clone = high#core#Clone(settings)
  call high#core#AddLighter(clone)

  " Set up the highlight group and switch to the next one.
  let clone.hlgroup = settings._hlgroups[settings._hlgroups_index]
  let settings._hlgroups_index += 1
  if settings._hlgroups_index >= len(settings._hlgroups)
    let settings._hlgroups_index = 0
  endif

  call high#core#ManualHighlight(settings, 1)
endfunction "}}}

function! high#light#words#ClearWords() "{{{
  call high#core#ManualHighlight(high#group#GetSettings('words'), 0)
endfunction "}}}
