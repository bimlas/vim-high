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
    let settings = high#group#Register(a:lighter)
    if a:0
      let settings.enabled = a:1
    endif
  else
    let settings = high#group#GetSettings(a:lighter)
    let settings.enabled = a:0 ? a:1 : !settings.enabled
  endif
  windo call high#core#Highlight(settings)
endfunction "}}}
