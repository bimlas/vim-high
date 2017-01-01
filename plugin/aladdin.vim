let s:whitelist = ['asciidoc', 'markdown']

" Return with the filetype or '_' if it's not set.
function! GetFiletype()
  return &filetype ? &filetype : '_'
endfunction

" Do the purpose of the plugin.
function! Highlight()
  if exists('s:whitelist["{GetFiletype()}"]')
    call matchadd('ErrorMsg', 'TODO', 1000)
  endif
endfunction

augroup aladdin
  autocmd! BufWinEnter * call Highlight()
augroup END
