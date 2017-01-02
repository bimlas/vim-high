function! aladdin#sources#inactive_window#define()
  let obj = aladdin#sources#PROTOTYPE#clone()
  let obj.hlgroup = 'Comment'
  let obj.enabled = 0

  augroup aladdin_inactive_window
    autocmd!
    exe 'autocmd WinEnter * let w:aladdin_inactive_window_enabled = 0 | call g:aladdin_loaded_sources['.obj._index.'].Update()'
    exe 'autocmd WinLeave * let w:aladdin_inactive_window_enabled = 1 | call g:aladdin_loaded_sources['.obj._index.'].Update()'
  augroup END

  function! obj.Update()
    let self.pattern = w:aladdin_inactive_window_enabled ? '.*' : ''
    call clearmatches()
    call self.Highlight()
  endfunction

  return [obj]
endfunction
