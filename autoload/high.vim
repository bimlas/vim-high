" Main functions, interface of the plugin
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license

function! high#Light(group_settings) "{{{
  if a:group_settings.__auto_highlight
    call high#LightGroup(a:group_settings, 1)
  endif
endfunction "}}}

function! high#LightGroup(group_settings, enabled) "{{{
  call high#match#InitIDs()
  if a:enabled && high#group#IsEnabled(a:group_settings)
    if !high#group#IsInitialized(a:group_settings.__group_name)
      call high#group#Init(a:group_settings.__group_name)
    endif
    let have_to_update = high#group#HaveToUpdate(a:group_settings)
    for lighter in high#group#GetMembers(a:group_settings.__group_name)
      if have_to_update
        call high#match#Clear(lighter)
      endif
      call high#match#Add(lighter)
    endfor
  else
    for lighter in high#group#GetMembers(a:group_settings.__group_name)
      call high#match#Clear(lighter)
    endfor
  endif
endfunction "}}}

function! high#UpdateGroups() "{{{
  for group_settings in values(g:high.registered_groups)
    if empty(group_settings.__update_function)
      continue
    endif
    call high#Light(group_settings)
  endfor
endfunction "}}}
