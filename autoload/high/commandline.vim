" Command line interface for vim-high, a Vim custom highlighter plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#commandline#listLighters(argLead, cmdLine, cursorPos) "{{{
  let list = high#utils#ListOfLighters()
  return filter(list.autoloaded+list.user_defined, 'v:val =~ "^'.a:argLead.'"')
endfunction "}}}

function! high#commandline#toggle(lighter, ...) "{{{
  if !high#group#IsRegistered(a:lighter)
    call high#group#Register(a:lighter)
  endif
  if !high#group#IsInitialized(a:lighter)
    call high#group#Init(a:lighter)
  endif
  for l in g:high.lighter_groups[a:lighter]
    let l.enabled = a:0 ? a:1 : !l.enabled
    windo call high#core#Highlight(l)
  endfor
endfunction "}}}
