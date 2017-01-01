let s:defaults = {
\ 'whitelist': [],
\ 'blacklist': [],
\ 'pattern': '',
\ 'hlgroup': 'ErrorMsg',
\ 'priority': 1000,
\ }

let s:patterns = {}

let s:patterns.todo = copy(s:defaults)
let s:patterns.todo.whitelist = ['asciidoc', 'markdown']
let s:patterns.todo.pattern = 'TODO'
let s:patterns.todo.hlgroup = 'ErrorMsg'

" Return with the filetype or '_' if it's not set.
function! GetFiletype()
  return len(&filetype) ? &filetype : '_'
endfunction

function! PatternEnabledForFiletype(pattern, ftype)
  return ((len(a:pattern.whitelist) > 0) && (index(a:pattern.whitelist, a:ftype) >= 0))
  \ || ((len(a:pattern.blacklist) > 0) && (index(a:pattern.blacklist, a:ftype) < 0))
endfunction

" Do the purpose of the plugin.
function! Highlight()
  for pattern in values(s:patterns)
    if PatternEnabledForFiletype(pattern, GetFiletype())
      call matchadd(pattern.hlgroup, pattern.pattern, pattern.priority)
    else
      call clearmatches()
    endif
  endfor
endfunction

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * call Highlight()
augroup END
