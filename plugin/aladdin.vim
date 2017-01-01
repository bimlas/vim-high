let s:aladdin_patterns = [aladdin#sources#todo#define()]

augroup aladdin
  autocmd! WinEnter,BufWinEnter,FileType * for pattern in s:aladdin_patterns | call pattern.Highlight() | endfor
augroup END
