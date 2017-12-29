\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modernposter}[Modern poster template. Inspired by metropolis beamer template.]

\LoadClass[portrait]{a0poster}

%------------------------------------------------------------------------------
% Color definitions
%------------------------------------------------------------------------------
\RequirePackage{xcolor}

\definecolor{c1}{HTML}{CB4B16}
\definecolor{c2}{HTML}{586E75}
\definecolor{c3}{HTML}{6C71C4}
\definecolor{c4}{HTML}{D33682}
\definecolor{c5}{HTML}{268BD2}
\definecolor{c6}{HTML}{B58900}
\definecolor{c7}{HTML}{859900}
\definecolor{c8}{HTML}{DC322F}
\definecolor{c9}{HTML}{002B36}

\definecolor{mDarkTeal}{HTML}{23373b}
\definecolor{mDarkBrown}{HTML}{604c38}

\newcommand{\orange}[1]{\textcolor{orange}{#1}}
\newcommand{\gray}[1]{\textcolor{c2}{#1}}
\newcommand{\purple}[1]{\textcolor{c3}{#1}}
\newcommand{\pink}[1]{\textcolor{c4}{#1}}
\newcommand{\blue}[1]{\textcolor{c5}{#1}}
\newcommand{\yellow}[1]{\textcolor{c6}{#1}}
\newcommand{\green}[1]{\textcolor{c7}{#1}}
\newcommand{\red}[1]{\textcolor{c8}{#1}}
\newcommand{\black}[1]{\textcolor{c9}{#1}}

\newcommand\orangeuline[1]{\colorlet{temp}{.}\color{orange}\underline{\color{temp}#1}\color{temp}}

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
\setlength{\itemindent}{10in}
\setlist[itemize]{leftmargin=1in}
\setlist[enumerate]{leftmargin=1in}
\renewcommand{\labelitemi}{$\bullet$~~}
\renewcommand{\labelitemii}{\faicon{angle-right}~~}

%------------------------------------------------------------------------------
% Poster commands
%------------------------------------------------------------------------------
\newcommand{\myPoster}[5]{
  \begin{tikzpicture}[remember picture, overlay, every node/.style={inner sep=0,outer sep=0}]
  \node[text height = \paperheight, text width = \paperwidth, fill=black!10, anchor=north west] at (current page.north west) {};
  \node[text height = 15em, text width=\paperwidth - 15em, fill=mDarkTeal, anchor=north west] (header) at (current page.north west) {};
  \node[text width=\paperwidth, text height=0.15em, fill=orange, yshift=-15em] (sep) at (current page.north) {};
  \node[anchor=west, xshift=1em] (logo) at (header.east) {\includegraphics[width=13em]{logo.png}};
  
  \node[anchor=east, yshift=3.4em, xshift=-2.5em] (title) at (header.east) {\veryHuge \color{white} \bf #1};
  \node[anchor=east, yshift=-0.8em, xshift=-2.5em] (authors) at (header.east) {\veryHuge\smaller\smaller \color{white} \bf #2};
  \node[anchor=east, yshift=-4.3em, xshift=-2.5em] (email) at (header.east) {\veryHuge\smaller\smaller \color{white} \bf #3};
  \node[text width=\paperwidth, xshift=4em, below=4.4em of sep] {
  \begin{minipage}{0.44\linewidth}
    #4
  \end{minipage}
  \hspace{0.02\linewidth}
  \begin{minipage}{0.44\linewidth}
    #5
  \end{minipage}  
  };
}

\newcommand{\myColorbox}[2]{
  \begin{tikzpicture}
    \node[text width=0.5\paperwidth - 5em, minimum height=0.3\paperheight - 5em, rounded corners, line width=1mm, draw=mDarkTeal, fill=black!2] (content) {};
    \node[anchor=north west, yshift=-6.2em, xshift=1em] at (content.north west) {\Large\parbox{0.5\paperwidth - 5em}{#2}};
    \node[text width=0.5\paperwidth - 5em, fill=mDarkTeal, text depth=1.4em, text height=4em, rounded corners, align=center, anchor=north west] (heading) at (content.north west) {\Huge{\color{white} ~~\bf #1}};
  \end{tikzpicture}\\[1.5em]
}
\newcommand{\myColorboxA}[2]{
  \begin{tikzpicture}
    \node[text width=0.5\paperwidth - 5em, rounded corners, line width=1mm, draw=mDarkTeal, fill=black!2] (content) {
    ~~~~\begin{minipage}[t][20em][t]{0.9\textwidth}\vspace{6.5em}{\Large #2}\vspace{1em}\end{minipage}};
    \node[text width=0.5\paperwidth - 5em, fill=mDarkTeal, text depth=1.4em, text height=4em, rounded corners, align=center] (heading) {\Huge{\color{white} ~~\bf #1}};
  \end{tikzpicture}\\[1.5em]
}
\newcommand{\myColorboxB}[2]{
  \begin{tikzpicture}
    \node[text width=0.5\paperwidth - 5em, rounded corners, line width=1mm, draw=mDarkTeal, fill=black!2] (content) {
    ~~~~\begin{minipage}[t][14.6em][t]{0.9\textwidth}\vspace{6.5em}{\Large #2}\vspace{1em}\end{minipage}};
    \node[text width=0.5\paperwidth - 5em, fill=mDarkTeal, text depth=1.4em, text height=4em, rounded corners, align=center] (heading) {\Huge{\color{white} ~~\bf #1}};
  \end{tikzpicture}\\[1.5em]
}