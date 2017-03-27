" Highlight invisible space, non-breaking space
"
" Author:  Bimba Laszlo <https://github.com/bimlas>
" Source:  https://github.com/bimlas/vim-high
" License: MIT license
"
" Inspired by:
" https://www.reddit.com/r/vim/comments/5ltoq2/display_nonspace_and_nontab_whitespace_in_file/

function! high#light#invisible_space#Define()
  return {
  \ 'pattern': '\%u00A0\|\%u1680\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u200B\|\%u202F\|\%u205F\|\%u3000\|\%uFEFF',
  \ }
endfunction
