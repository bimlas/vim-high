function! high#light#inactive_window#define(settings)
  let source = high#main#_Clone()
  call high#main#_AddSource(source)

  let source.hlgroup = 'Comment'

  call high#main#_Customize(source, a:settings)
  let source._autoHighlight = 0
  let source._pattern = '.*'

  augroup high_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call high#main#_ManualHighlight(g:high.lighters['.source._index.'], 0)'
    exe 'autocmd WinLeave * call high#main#_ManualHighlight(g:high.lighters['.source._index.'], 1)'
  augroup END "}}}
endfunction
