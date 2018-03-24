# vim-bracepair
Lightweight auto-completion plugin for parens and braces.

Typing an opening `(`, `[`, or `{` will automatically close it:

    | -> (|)

Typing a closing brace while next to one will step over it:

    (|) -> ()|

Typing a space between braces will expand them:

    [|] -> [ | ]

Backspace also deletes closing braces:

    [|] -> |

Enter opens up braces like:

    {|} -> {
             |
           }
