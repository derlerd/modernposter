## modernposter - A modern LaTeX poster theme (2018/01/04 v1.02.1)

This class extends the a0poster class in that it adds support to easily create posters without the need for taking care of the layout at all. It allows to use \maketitle to generate a fancy header containing the title information and also provides macros to position various different types of text boxes in a two-column layout. The color scheme and some parts of the Makefile are inspired by the [metropolis beamer theme](https://github.com/matze/mtheme). 

The modernposter package can be found on [CTAN](https://ctan.org/pkg/modernposter) and is included in [TeXLive](https://ctan.org/pkg/texlive) and in [MiKTeX](https://ctan.org/pkg/miktex).

Below you can find a preview of the demo:

![Preview](https://i.imgur.com/XUr9a5U.jpg)

## Usage

Below you can find a toy example, demonstrating how to use modernposter.

```latex
\documentclass{modernposter}

\title{This is a Modernposter Demo}
\author{Firstname Lastname}
\email{firstname.lastname@domain.com} 

\begin{document}
  \maketitle  

  \begin{postercolumn}
    \posterbox{Introduction}{ 
      $\dots$
    }
  \end{postercolumn} 
  \begin{postercolumn}
    \doubleposterbox[0.6]
      {Problem Statement}{
        $\dots$
      }
      {\highlight{Results}}{ 
        $\dots$
      }
  \end{postercolumn}
\end{document}
```

## Authors
The code is maintained by David Derler. He can be contacted via [modernposter@derler.info](mailto:modernposter@derler.info). A list of contributors can be found [here](https://github.com/derlerd/modernposter/graphs/contributors).

## License
The code is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/).
