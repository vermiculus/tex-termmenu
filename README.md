termmenu - Terminal-driven menus in TeX
=======================================

When writing programs, it's often required to present the user with a
list of options/actions.  The user is then expected to select one of
these options for the program to process.

`termmenu` provides this mechanism for TeX.  Using `termmenu` requires
only `expl3` support, thus the `l3kernel` and `l3packages` are both
required.

----------------------------------------------------------------------

`termmenu.dtx` may be distributed and/or modified under the conditions
of the LaTeX Project Public License (LPPL), either version 1.3c of
this license or (at your option) any later version.  The latest
version of this license is in the file

    http://www.latex-project.org/lppl.txt

The released version is available from CTAN.

----------------------------------------------------------------------

The development version can be found at

    http://www.github.com/vermiculus/tex-termmenu

for those people who are interested.

Installation
------------

To install `termmenu`, simply run

    tex termmenu.ins

`termmenu.tex` will be produced.  Since it can be run by anything that
can run `expl3`, I recommend placing it in `tex/generic/termmenu`.

To produce the documentation, run `pdflatex` or
[`arara`](https://github.com/cereda/arara) on the file as normal.

Usage
-----

Full documentation is available in `termmenu.pdf`, but using
`termmenu` is very simple if you're familiar with `expl3` programming:

    \termmenu_new:N \g_demo_termmenu

will create a menu and
   
    \termmenu_add:Nnnn \g_demo_termmenu { option }
      { Description text }
      { \msg_term:n { Actions } }

will add a menu item.  The user is prompted with

    \termmenu_get_choice:NN \g_demo_termmenu \l_tmpa_tl

and an action is taken with

    \termmenu_exec:NV \g_demo_termmenu \l_tmpa_tl

The menu itself looks something like this:

    *************************************************
    * Menu
    *************************************************

    The following commands are available:

        > option
            Description text

    \choice=option
    *************************************************
    * Actions
    *************************************************
