function! aladdin#sources#inactive_window#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_AddSource(source)
  let source.hlgroup = 'Comment'
  call aladdin#main#_Customize(source, a:settings)
  let source._autoHighlight = 0
  let source._pattern = '.*'

  augroup aladdin_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call aladdin#main#_ManualHighlight(g:aladdin.loaded_sources['.source._index.'], 0)'
    exe 'autocmd WinLeave * call aladdin#main#_ManualHighlight(g:aladdin.loaded_sources['.source._index.'], 1)'
  augroup END "}}}
endfunction
