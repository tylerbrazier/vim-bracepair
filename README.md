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
