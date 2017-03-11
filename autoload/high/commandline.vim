" Command line interface for vim-high, a Vim custom highlighter plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#commandline#Completion(arg_lead, cmd_line, cursor_pos) "{{{
  return filter(high#commandline#ListOfGroupNames(), 'v:val =~ "^'.a:arg_lead.'"')
endfunction "}}}

function! high#commandline#ListOfGroupNames() "{{{
  let autoloaded = map(split(globpath(&runtimepath, 'autoload/high/light/*'), '\n'), 'fnamemodify(v:val, ":p:t:r")')
  if exists('g:high_lighters')
    let user_defined = keys(g:high_lighters)
    call filter(user_defined, 'index(autoloaded, v:val) < 0')
  else
    let user_defined = []
  endif
  return sort(autoloaded + user_defined)
endfunction "}}}

function! high#commandline#Toggle(enabled, ...) "{{{
  for group_name in (a:0 ? a:000 : high#commandline#ListOfGroupNames())
    if !high#group#IsRegistered(group_name)
      let settings = high#group#Register(group_name)
      let settings.enabled = 1
    else
      let settings = high#group#GetSettings(group_name)
      let settings.enabled = (a:enabled >= 0 ? a:enabled : !settings.enabled)
    endif
    windo call high#core#Highlight(settings)
  endfor
endfunction "}}}
