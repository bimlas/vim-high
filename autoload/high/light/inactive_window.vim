function! high#light#inactive_window#define(settings)
  let lighter = high#main#_Clone()
  call high#main#_AddLighter(lighter)

  let lighter.hlgroup = 'Comment'

  call high#main#_Customize(lighter, a:settings)
  let lighter._autoHighlight = 0
  let lighter._pattern = '.*'

  augroup high_inactive_window "{{{
    autocmd!
    exe 'autocmd WinEnter * call high#main#_ManualHighlight(g:high.lighters['.lighter._index.'], 0)'
    exe 'autocmd WinLeave * call high#main#_ManualHighlight(g:high.lighters['.lighter._index.'], 1)'
  augroup END "}}}
endfunction
