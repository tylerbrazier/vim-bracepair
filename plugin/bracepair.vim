" bracepair.vim - Lightweight auto-completion plugin for parens and braces
" Maintainer: Tyler Brazier <tyler@tylerbrazier.com>

if exists('g:loaded_bracepair') || &compatible
  finish
endif
let g:loaded_bracepair = 1

" get a char to the right or left of the cursor (1=right, 2=left)
function! s:char(x)
  return getline('.')[col('.')-a:x]
endfunction

" returns true if the cursor is between two matching braces, false otherwise
function! s:between()
  return  (s:char(2) == '(' && s:char(1) == ')') ||
        \ (s:char(2) == '{' && s:char(1) == '}') ||
        \ (s:char(2) == '[' && s:char(1) == ']')
endfunction

" close opening braces unless cursor is in front of a word
inoremap <expr> ( <sid>char(1) =~ '\w' ? '(' : "()\<left>"
inoremap <expr> { <sid>char(1) =~ '\w' ? '{' : "{}\<left>"
inoremap <expr> [ <sid>char(1) =~ '\w' ? '[' : "[]\<left>"

" step over closing braces
inoremap <expr> ) <sid>char(1) =~ ')' ? "\<right>" : ')'
inoremap <expr> } <sid>char(1) =~ '}' ? "\<right>" : '}'
inoremap <expr> ] <sid>char(1) =~ ']' ? "\<right>" : ']'

" space between braces expands them
inoremap <expr> <space> <sid>between() ? "\<space><space><left>" : '<space>'

" backspace between braces deletes them both
inoremap <expr> <bs> <sid>between() ? "\<right><bs><bs>" : '<bs>'

" enter between braces opens below
inoremap <expr> <cr> <sid>between() ? "\<cr><esc>O" : '<cr>'
