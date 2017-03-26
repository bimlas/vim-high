" Command line interface for vim-high, a Vim custom highlighter plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#commandline#Completion(arg_lead, cmd_line, cursor_pos) "{{{
  return filter(high#utils#ListOfGroupNames(), 'v:val =~ "^'.a:arg_lead.'"')
endfunction "}}}

function! high#commandline#Toggle(enabled, ...) "{{{
  for group_name in (a:0 ? a:000 : high#utils#ListOfGroupNames())
    if !high#group#IsRegistered(group_name)
      let settings = high#group#Register(group_name)
    else
      let settings = high#group#GetSettings(group_name)
    endif
    let settings.enabled = (a:enabled >= 0 ? a:enabled : !settings.enabled)
    let original_win = winnr()
    windo call high#Light(settings)
    exe original_win.'wincmd w'
  endfor
endfunction "}}}
