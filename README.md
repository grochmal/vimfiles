README for `vimfiles`


## Introduction

The `vimfiles` are a collection of files as I use the Vim editor.  The main
`vimrc` file and a few extras, including plugins included as `git` submodules.
The default way one would install this Vim collection would be:

    git clone https://github.com/grochmal/vimfiles ~/.vim

Then, to load the plugins from submodules:

    cd ~/.vim
    git submodule update

And it is done, you can ignore the rest of the section.

Using SSH is also a viable option, assuming you have github.com as a host in
your SSH config file:

    git clone https://github.com/grochmal/vimfiles ~/.vim

And another mirror is available on gitlab.com.  You can condense the submodules
into the same command as well.  I normally use the following when installing on
a new machine.

    git clone -o vimfiles --recurse-submodules \
        ssh://gitlab.com/grochmal/vimfiles ~/.vim

But this will overwrite your own Vim configuration if you have one already,
hence feel free to just copy bits and pieces that may interest you.


## Copying

Copyright (C) 2021 Michal Grochmal

This file is part of `vimfiles`.

`vimfiles` is distributed under the same licence as Vim itself, where: Vim is
Charityware.  You can use and copy it as much as you like, but you are
encouraged to make a donation to help orphans in Uganda.  See :help uganda
inside Vim for details.

Summary of the license: There are no restrictions on using or distributing an
unmodified copy of Vim.  Parts of Vim may also be distributed, but the license
text must always be included.  For modified versions a few restrictions apply.
The license is GPL compatible, you may compile Vim with GPL libraries and
distribute it.

`vimfiles` is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

The LICENSE file contains a copy of the VIM LICENSE.


## Features

Extensive status bar and highlighting of white space in files.  In order for a
more vertical (easier to read) code the following is shown

- each end of line is marked with a pipe symbol ( | ),
- all tabs are marked as "@>>",
- trailing space is explicitly shown as percentage signs ( % ).

This can be temporarily disabled with `:call Clear()` and re-enabled with
`:call Marks()`.  You are free to add a `:command` to execute either.
Once text passes 80 columns (including the closing newline) an error highlight
will appear.  The highlight group is `LongText`, you can disable the error
highlight with `:hi clear LongText`.  To re-enable you must reinitialize the
highlight to:

    hi LongText term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red

Tab completion is added as an extension to Vim's `<c-n>` and `<c-p>`
completions.  By typing `<tab>` Vim will now autocomplete based on all other
words within the files.  The extension ensures that completion does not happen
when the cursor is not at the end of a word, where a tab character would be
more appropriate.

Map leaders are defined to `-` and `,` (local), most useful in code files for
scripting languages.  Some useful maps are:

- `-sv` re-source the `vimrc`
- `-ev` split and edit the `vimrc`
- `-sp` right splits the current buffer with the alternative buffer
- `-wt` highlights trailing spaces further
- `-wc` removes all matches highlights, including long lines
- `-wl` re-enables long line highlights
- `-nh` removes search highlight
- `-q` toggles the quickfix window
- `-f` toggles fold summary (`zo` and `zc` to close open folds)
- `-l` starts `netrw`'s `Lexplore` window

The status line is composed of, on the left: the filename, the buffer number, a
modified flag ("+" if modified), a read only flag ("RO" if read only), the file
format and the file type as understood by Vim.  On the right we have: the
column number (possibly with a virtual column counter), the current line, the
total number of lines, the byte number in file (in hex), the value under the
cursor (in hex), and a percentage through the file.

Top highlight is used for buffer tabs.  In most terminals and in gVim the tabs
should be navigable with the mouse (albeit `gt` and `gT` are much faster).

Reasonable tab and soft-tab behaviour for python, shell, c/c++, JS, XML/HTML,
SQL and java files is added.  Also, for most the mapping `,c` is used to
comment out the current line.

Several other mapping are present but are less relevant.  Reading the `vimrc`
itself may provide you with some ideas for your own.

