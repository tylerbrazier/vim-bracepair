vim-bracepair
=============
Lightweight auto-completion plugin for parens and braces.

Typing an opening brace (`(`, `[`, or `{`) will automatically close it:

    | -> (|)

Typing a closing brace while next to one will just "step over" it:

    (|) -> ()|

Typing a space between braces will expand them:

    [|] -> [ | ]

Backspace to collapse:

    [ | ] -> [|]

Backspace also deletes closing braces:

    [|] -> |

Enter expands braces like:

    ...{|} -> ...{
                |
              }

If you have a custom insert mode mapping for `<CR>`, e.g. to select a
completion option, you can do something like this to keep it working correctly:

    imap <expr> <cr> pumvisible() ? "\<c-y>" :
          \ exists('g:loaded_bracepair') ? "<Plug>bracepairExpandCR" :
          \ "\<cr>"
