if exists('g:loaded_bracepair')
  finish
endif
let g:loaded_bracepair = 1

inoremap <expr> ( <SID>Complete('(')
inoremap <expr> ) <SID>Complete(')')
inoremap <expr> { <SID>Complete('{')
inoremap <expr> } <SID>Complete('}')
inoremap <expr> [ <SID>Complete('[')
inoremap <expr> ] <SID>Complete(']')
inoremap <expr> <space> <SID>Complete("\<space>")
inoremap <expr> <bs> <SID>Complete("\<bs>")
inoremap <expr> <Plug>bracepairExpandCR <SID>Complete("\<cr>")
if !hasmapto('<Plug>bracepairExpandCR', 'i')
  imap <buffer> <expr> <cr> "<Plug>bracepairExpandCR"
endif

function! s:Complete(c)
  let line = getline('.')
  let col = col('.')
  let l = line[col-2]  " char left of cursor
  let r = line[col-1]  " char right of cursor
  let ll = line[col-3] " two chars left
  let rr = line[col]   " two chars right

  " close matching braces (unless in front of a nonwhitespace char)
  if a:c == '(' && (r == ')' || r == '}' || r == ']' || r !~ '\S')
    return "()\<left>"

  elseif a:c == '{' && (r == ')' || r == '}' || r == ']' || r !~ '\S')
    return "{}\<left>"

  elseif a:c == '[' && (r == ')' || r == '}' || r == ']' || r !~ '\S')
    return "[]\<left>"

  " step over closing braces when typed
  elseif (a:c == ')' || a:c == '}' || a:c == ']') && r == a:c
    return "\<right>"

  " space expands braces like (|) -> ( | )
  elseif a:c == "\<space>" && (
        \ (l == '(' && r == ')') ||
        \ (l == '{' && r == '}') ||
        \ (l == '[' && r == ']'))
    return "\<space>\<space>\<left>"

  " backspace deletes braces like [|] -> |
  " or deletes expanded spaces like [ | ] -> [|]
  elseif a:c == "\<bs>" && (
        \ (l == '(' && r == ')') ||
        \ (l == '{' && r == '}') ||
        \ (l == '[' && r == ']') ||
        \ (l == "\<space>" && r == "\<space>" && (
        \   (ll == '(' && rr == ')') ||
        \   (ll == '{' && rr == '}') ||
        \   (ll == '[' && rr == ']'))))
    return "\<right>\<bs>\<bs>"

  " enter expands braces like
  " ...{|} -> ...{
  "             |
  "           }
  elseif a:c == "\<cr>" && (
        \ (l == '(' && r == ')') ||
        \ (l == '{' && r == '}') ||
        \ (l == '[' && r == ']'))
    return "\<cr>\<esc>O"

  " otherwise just return the typed char
  else
    return a:c

  endif
endfunction
