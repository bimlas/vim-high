" Command line interface for vim-high, a Vim custom highlighter plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#commandline#listLighters(argLead, cmdLine, cursorPos) "{{{
  let list = high#utils#ListOfLighters()
  return filter(list.autoloaded+list.user_defined, 'v:val =~ "^'.a:argLead.'"')
endfunction "}}}

function! high#commandline#toggle(group_name, ...) "{{{
  for group in (a:group_name == '*' ? high#utils#ListOfLighters() : [a:group_name])
    if !high#group#IsRegistered(group)
      let settings = high#group#Register(group)
      if a:0
        let settings.enabled = a:1
      endif
    else
      let settings = high#group#GetSettings(group)
      let settings.enabled = a:0 ? a:1 : !settings.enabled
    endif
    windo call high#core#Highlight(settings)
  endfor
endfunction "}}}
