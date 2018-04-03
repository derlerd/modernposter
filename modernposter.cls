% modernposter.cls
%
% This file is part of the modernposter LaTeX template
%
% Version 1.03.1 2018/04/03
%
% Copyright 2018 David Derler and other contributors. A list of contributors 
% can be found at https://github.com/derlerd/modernposter/graphs/contributors
%
% This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 
% International license (cf. https://creativecommons.org/licenses/by-sa/4.0/)  
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modernposter}[2018/04/03 v1.03.1 A modern LaTeX poster template. Color scheme inspired by metropolis beamer theme.]

\LoadClass[portrait]{a0poster}

%------------------------------------------------------------------------------
% Color definitions
%------------------------------------------------------------------------------
\RequirePackage{xcolor}

\definecolor{mDarkTeal}{HTML}{23373b}
\definecolor{mDarkBrown}{HTML}{604c38}

%------------------------------------------------------------------------------
% Options
%------------------------------------------------------------------------------
\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}


\pgfkeys{/modernposter/.cd,
  hlcolor/.store in=\modernposter@hlcolor,
  logo/.store in=\modernposter@logo,
  hlcolor=FF8000}

\ProcessPgfOptions{/modernposter}

\pgfkeys{/modernposter/.cd,
  logo/.code={\def\@logotrue{}},
  helvet/.code={\def\@helvettrue{}},
}

\ProcessPgfOptions{/modernposter}

\definecolor{hlcol}{HTML}{\modernposter@hlcolor}

\newcommand{\highlight}[1]{\textcolor{hlcol}{#1}}

%------------------------------------------------------------------------------
% Lengths and sizes
%------------------------------------------------------------------------------
\RequirePackage{relsize}

\newlength{\colheight}
\newlength{\colwidth}
\newlength{\coltextwidth}
\newlength{\colsep}
\newlength{\boxheight}
\newlength{\boxlinewidth}

%------------------------------------------------------------------------------
% Tikz stuff
%------------------------------------------------------------------------------
\RequirePackage{tikz}
\usetikzlibrary{positioning, backgrounds, shapes.misc}

%------------------------------------------------------------------------------
% Style
%------------------------------------------------------------------------------
\RequirePackage{enumitem}
\RequirePackage{fontawesome}
\RequirePackage{sfmath}
\setlength{\itemindent}{10in}
\setlist[itemize]{leftmargin=1in}
\setlist[enumerate]{leftmargin=1in}

\let\oldparboxrestore\@arrayparboxrestore
\renewcommand{\@arrayparboxrestore}{
  \oldparboxrestore
  \parskip0.4em
  }

\let\faiconold\faicon
\renewcommand{\faicon}[1]{{\rmfamily \faiconold{#1}}}

\renewcommand{\labelitemi}{$\bullet$~~}
\renewcommand{\labelitemii}{\faicon{angle-right}~~}

\ifdefined\@helvettrue
  \RequirePackage{helvet}
  \renewcommand\familydefault{\sfdefault}
\else
  \RequirePackage[light,sfdefault]{FiraSans}	
\fi


%------------------------------------------------------------------------------
% Begin/End Document commands
%------------------------------------------------------------------------------
\RequirePackage{etoolbox}
\AfterEndPreamble{
  \setlength{\colheight}{111.6em}
  \setlength{\colwidth}{\dimexpr0.4525\linewidth\relax}
  \setlength{\coltextwidth}{\dimexpr\colwidth-2em\relax}
  \setlength{\colsep}{\dimexpr0.01\linewidth\relax}
  \setlength{\boxheight}{\dimexpr0.33\colheight\relax}
  \setlength{\boxlinewidth}{1mm}
  \begin{tikzpicture}[remember picture, 
                      overlay, 
                      every node/.style={inner sep=0,outer sep=0}]
}

\AtBeginDocument{
  \ifdefined\@helvettrue\else
    \def\bfseries@sf{m}
    \SetSymbolFont{operators}{normal}{\math@encoding}{\math@sfdefault}{l}{n}
    \SetSymbolFont{operators}{bold}{\math@encoding}{\math@sfdefault}{m}{n}
    \DeclareSymbolFont{SFMath}{\math@encoding}{\math@sfdefault}{l}{sl}
    \SetSymbolFont{SFMath}{normal}{\math@encoding}{\math@sfdefault}{l}{sl}
    \SetSymbolFont{SFMath}{bold}{\math@encoding}{\math@sfdefault}{m}{\mathnormal@bold@shape}
  \fi
}

\AtEndDocument{
  \end{tikzpicture}
}

%------------------------------------------------------------------------------
% Title commands
%------------------------------------------------------------------------------
\RequirePackage[hidelinks]{hyperref}

\def\@email{}
\newcommand{\email}[1]{\def\@email{#1}}

\renewcommand{\maketitle}{
    \node[text height=\paperheight, 
          text width=\paperwidth, 
          fill=black!10, 
          anchor=north west] at (current page.north west) 
      {};
    \node[text height=15em, 
          text width=\paperwidth-15em, 
          fill=mDarkTeal, 
          anchor=north west] (header) at (current page.north west) 
      {};
    \node[text width=\paperwidth, 
          text height=0.15em, 
          fill=hlcol, 
          yshift=-15em] (sep) at (current page.north) 
      {};
    \ifdefined\@logotrue
    \node[anchor=center, 
          xshift=7.5em] (logo) at (header.east) 
      {\includegraphics[width=13em, height=13em, keepaspectratio]{\modernposter@logo}};
    \fi
    \node[anchor=east, 
          yshift=3.4em, 
          xshift=-2.5em] (title) at (header.east) 
      {\veryHuge \color{white} \bf \@title};
    \node[anchor=east, 
          yshift=-0.8em, 
          xshift=-2.5em] (authors) at (header.east) 
      {\veryHuge\smaller\smaller \color{white} \bf \@author};
    \node[anchor=east, 
          yshift=-4.3em, 
          xshift=-2.5em] (email) at (header.east) 
      {\veryHuge\smaller\smaller \color{white} \bf\tt \href{mailto:\@email}{\@email}};
}

%------------------------------------------------------------------------------
% Poster commands
%------------------------------------------------------------------------------
\RequirePackage{environ}

\newcounter{numcols}
\NewEnviron{postercolumn}{
  \ifnum\value{numcols}=0
    \node[text width=\colwidth, 
          xshift=4em, 
          below=3em of sep.west, 
          anchor=north west] (col1) 
      {~\\[\colsep]\BODY};
  \else
    \node[text width=\colwidth, 
          xshift=\colsep, 
          anchor=north west] at (col1.north east) 
      {~\\[\colsep]\BODY};
  \fi
  \stepcounter{numcols}
}

\newcommand{\posterbox}[3][\boxheight]{
  \begin{tikzpicture}
    \node[text width=\colwidth, 
          minimum height=#1, 
          rounded corners, 
          line width=\boxlinewidth, 
          draw=mDarkTeal, 
          fill=black!2] (content) 
      {};
    \node[anchor=north west, 
          yshift=-6.2em, 
          xshift=1em] at (content.north west) 
      {\Large\parbox{\coltextwidth}{#3~}};
    \node[text width=\colwidth, 
          fill=mDarkTeal, 
          text depth=1.4em, 
          text height=4em, 
          rounded corners, 
          align=center, 
          anchor=north west] (heading) at (content.north west) 
      {\Huge{\color{white} ~~\bf #2}};
  \end{tikzpicture}\\[\colsep]
}

\newcommand{\doubleposterbox}[5][0.6]{
  \posterbox[#1\boxheight]{#2}{#3}
  \posterbox[\boxheight-#1\boxheight-\colsep-1.33\boxlinewidth]{#4}{#5}
}
