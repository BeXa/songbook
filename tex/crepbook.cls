% CREPBOOK DOCUMENT CLASS -- version 0.2.2
% for LaTeX2e
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{crepbook}[2012/02/19 v0.5.0 LaTeX document class for Crep
  Books]

\makeatletter\def\input@path{{tex/}}

\newif{\iftabs}
\newif{\iflilypond}
\newif{\ifnodiagram}
\newif{\ifimportantdiagramonly}
\newif{\ifpictures}
\newif{\ifnorepeatchords}

\tabsfalse
\lilypondfalse
\nodiagramtrue
\picturesfalse
\importantdiagramonlyfalse
\norepeatchordstrue

% Options
\DeclareOption{tabs}{\tabstrue}
\DeclareOption{notabs}{\tabsfalse}
\DeclareOption{lilypond}{\lilypondtrue}
\DeclareOption{nolilypond}{\lilypondfalse}
\DeclareOption{nodiagram}{\nodiagramtrue}
\DeclareOption{diagram}{\nodiagramfalse}
\DeclareOption{importantdiagramonly}{\importantdiagramonlytrue\nodiagramfalse}
\DeclareOption{pictures}{\picturestrue}
\DeclareOption{nopictures}{\picturesfalse}
\DeclareOption{norepeatchords}{\norepeatchordstrue}
\DeclareOption{repeatchords}{\norepeatchordsfalse}

\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}

% Default options : pass to the songs package
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{songs}}
\ProcessOptions

% Base class
\LoadClass[a4paper]{article}

% Main packages
\RequirePackage{graphicx,xcolor}
\RequirePackage{songs}
\RequirePackage{fancybox}
\definecolor{tango-green-3}{HTML}{4e9a06}
\definecolor{tango-blue-3}{HTML}{204a87}
\RequirePackage[bookmarks,
  bookmarksopen,
  colorlinks=true,
  linkcolor=tango-green-3,
  urlcolor=tango-blue-3]{hyperref}
\RequirePackage{tikz}
\RequirePackage{licence}
\RequirePackage{xstring}

\iflyric%
  \tabsfalse%
  \lilypondfalse%
  \nodiagramtrue%
  \picturesfalse%
  \renewcommand{\colbotglue}{0pt plus .5\textheight minus 0pt}%
\fi

% Start
\def\andname{and}
\def\lastandname{\unskip, and}

\newcounter{@inst}
\newcounter{@auth}
\newcounter{auco}

\def\clearheadinfo{
  \gdef\@author{No Author Given}%
  \gdef\@title{No Title Given}%
  \gdef\@subtitle{}
  \gdef\@version{}
  \gdef\@web{}
  \gdef\@mail{}
  \gdef\@email{}
  \gdef\@picture{}
  \gdef\@picturecopyright{}
}

\def\subtitle#1{\gdef\@subtitle{#1}}
\def\version#1{\gdef\@version{#1}}
\def\web#1{\gdef\@web{#1}}
\def\mail#1{\gdef\@mail{#1}}
\def\email#1{\gdef\@email{#1}}
\def\licence#1{\gdef\@licence{#1}}
\def\picture#1{\gdef\@picture{#1}}
\def\picturecopyright#1{\gdef\@picturecopyright{#1}}
\def\footer#1{\gdef\@footer{#1}}
\def\lang#1{\gdef\@lang{#1}}
\clearheadinfo

\newcommand{\l@belVersion}{
  \IfStrEq{\@lang}{english}{\bf version:}{}
  \IfStrEq{\@lang}{french}{\bf version :}{}
}
\newcommand{\l@belDate}{
  \IfStrEq{\@lang}{english}{\bf date:}{}
  \IfStrEq{\@lang}{french}{\bf date :}{}
}
\newcommand{\l@belAuthor}{
  \IfStrEq{\@lang}{english}{\bf authors:}{}
  \IfStrEq{\@lang}{french}{\bf auteurs :}{}
}
\newcommand{\l@belWeb}{
  \IfStrEq{\@lang}{english}{\bf web:}{}
  \IfStrEq{\@lang}{french}{\bf web :}{}
}
\newcommand{\l@belMail}{
  \IfStrEq{\@lang}{english}{\bf mail:}{}
  \IfStrEq{\@lang}{french}{\bf mail :}{}
}

\renewcommand\maketitle{
  \@maketitle

  \thispagestyle{empty}

  \clearheadinfo}
%
\def\@maketitle{\newpage
 \markboth{}{}%
 \def\lastand{\ifnum\value{@inst}=2\relax
                 \unskip{} \andname\
              \else
                 \unskip \lastandname\
              \fi}%
 \def\and{\stepcounter{@auth}\relax
          \ifnum\value{@auth}=\value{@inst}%
             \lastand
          \else
             \unskip,
          \fi}%
 \begin{center}%
   {\rule{\textwidth}{1mm}}

   {\Huge \bfseries\boldmath\@title \par}
       
   \if!\@subtitle!\else {\begin{flushright}\large \bfseries\boldmath
       \@subtitle \par \end{flushright}}
   \fi
   
   {\rule{\textwidth}{1mm}}

 \end{center}%

 \vspace{1.5cm}

 \begin{flushleft}
   \begin{tabular}{l l}
     \if!\@version!\else{\l@belVersion} & \@version \\ \fi
     \if!\@date!\else{\l@belDate} &   \@date \\ \fi
     \if!\@author!\else{\l@belAuthor} & \@author \\ \fi
     \if!\@web!\else{\l@belWeb} &  \url{\@web} \\ \fi
     \if!\@mail!\else{\l@belMail} &  \url{\@mail} \\ \fi
   \end{tabular}
 \end{flushleft}

 \vspace{1.5cm}

 \begin{center}
   \includegraphics[keepaspectratio=true, width=14cm, height=14cm]{\@picture}
   \begin{flushright}
   {\flushright \small \@picturecopyright}
   \end{flushright}
 \end{center}

 \@footer

 \thispagestyle{empty}
 \newpage
 \@licence
 \newpage
}

\makeatletter

\newlength{\coverheight}
\setlength{\coverheight}{2cm}
\newlength{\coverspace}
\setlength{\coverspace}{0.1cm}
\newcommand{\songcover}{}
\newcommand{\songalbum}{}
\newsongkey{cov}{\let\songcover\@empty}{\def\songcover{#1}}
\newsongkey{album}{\let\songalbum\@empty}{\def\songalbum{#1}}
\newcommand\cover{%
  \ifpictures%
    \ifx\songcover\@empty\else%
      \mbox{%
        \includegraphics[width=\coverheight]{\songcover}%
        \hspace{\coverspace}%
      }%
    \fi%
  \fi%
}

\newlength{\capoheight}
\setlength{\capoheight}{1.5cm}
\renewcommand\capo[1]{%
  \ifchorded%
    \iftranscapos%
    \transpose{#1}%
    \else%
      \ifpictures
        \mbox{%
          \includegraphics[height=\capoheight]{capodastre}%
          \put(-22,8){\Large #1}
        }%
      \else
        \musicnote{capo: #1}%
      \fi
    \hspace{\coverspace}%
    \fi%
  \fi%
}%

\let\gtab@Original\gtab
\newcommand{\gtab@Hidden}[2]{}%
\ifnodiagram%
\renewcommand{\gtab}{\@ifstar
  \gtab@Hidden%
  \gtab@Hidden%
}
\else%
\ifimportantdiagramonly%
\renewcommand{\gtab}{\@ifstar
  \gtab@Original%
  \gtab@Hidden%
}
\else%
\renewcommand{\gtab}{\@ifstar
  \gtab@Original%
  \gtab@Original%
}
\fi%
\fi%

\newcommand{\lilypond}[1]{%
  \iflilypond%
  \IfFileExists{./lilypond/#1.pdf}{\includegraphics{./lilypond/#1}}{}%
  \fi%
}

\newcommand{\image}[2][]{%
  \ifpictures%
  \begin{flushright}%
    \includegraphics[#1]{#2}%
  \end{flushright}%
  \fi%
}

% Configuration of the songs package
\titleprefixword{}
\renewcommand{\stitlefont}{\LARGE\bf}
\renewcommand{\printchord}[1]{\small{\it#1}}
\renewcommand{\chorusfont}{\it}
\renewcommand{\showauthors}{%
  \hbox{\normalsize\songauthors}%
}
\renewcommand{\idxtitlefont}{\sffamily\bfseries}
\renewcommand{\idxauthfont}{\sffamily\bfseries}
\renewcommand{\idxheadfont}{\sffamily\it\LARGE}
\renewcommand{\idxrefsfont}{\bfseries}

%
% Customization of the page appearance
%
\RequirePackage[
  a4paper % paper size
  ,includeheadfoot % include header and footer into text size
  ,hmarginratio=1:1 % ratio between inner and outer margin (default)
  ,outer=1.8cm % outer margin (right)
  ,vmarginratio=1:1 % ratio between top and bottom margin
  ,bmargin=1.3cm % bottom margin
% ,bindingoffset=1.7cm % space reserved to bound pages together
  ]{geometry}

% Paragraph indentation space
\setlength{\parindent}{0.3cm}

%
% songs class options
%
% Horizontal space reserved to verse number
\setlength{\versenumwidth}{1em}
% Modifier to the space between consecutive lines of lyrics
\baselineadj=-2pt plus 1pt minus 1pt
% Space between verses and chorus
\versesep=6pt plus 2pt minus 2pt
%lyrics font
\renewcommand{\lyricfont}{\normalfont\normalsize}


% color used to shade song numbers.
\definecolor{SongbookShade}{HTML}{d1e4ae}

%
\iftabs%
%% Code from tabs.sty
% Counters
\newcounter{tab-string}
\newcounter{tab-tempo}
\newcounter{tab-line}
% Length
\newlength{\tablen}
% Variables
\def\chordtuning{E,A,D,G,B,e}
\def\xunit{0.35}
\def\yunit{0.2}
% The tab environmant
% \begin{tab}
\newenvironment{tab}
{
  \normalsize
  \setcounter{tab-line}{0}
  \setcounter{tab-tempo}{0}

  \setlength{\tablen}{\xunit cm}

  % A single note
  % \single <string> <fret>
  \newcommand{\single}[2]{
    % draw tuning if we are at the beginining of a new tab line
    \ifnum\value{tab-tempo}=0
     \setcounter{tab-string}{6}
     \foreach \tuning in \chordtuning
     {
       \node at (-1,\value{tab-line}+\value{tab-string}) {\tuning};
       \addtocounter{tab-string}{-1}
     }
    \fi

    % draw the 6 strings
    \foreach \string in {1,...,6}
    {
      \draw[xshift=-0.5cm] (\value{tab-tempo},\value{tab-line}+\string) -- +(1,0);
    }
    \draw node[single] at (\value{tab-tempo},\value{tab-line}+##1) {##2};
    \addtocounter{tab-tempo}{1}
    \addtolength{\tablen}{\xunit cm}
    \ifnum\hsize<\tablen
      \addtocounter{tab-line}{8}
      \setlength{\tablen}{\xunit cm}
      \setcounter{tab-tempo}{0}
      \end{tikzpicture}
      \begin{tikzpicture}[
        single/.style={},
        cm={\xunit,0,0,-\yunit,(0,0)}
      ]
    \fi
  }
  % A mesure bar
  % \bar
  \renewcommand{\bar}{
    \draw[xshift=-0.5cm] (\value{tab-tempo},\value{tab-line}+1) --+(0,5);
  }
  
  \hspace{-\parindent}
  \begin{tikzpicture}[
    single/.style={},
    cm={\xunit,0,0,-\yunit,(0,0)}
  ]

  % draw the first bar
  \draw[xshift=-0.5cm] (0,1) --+(0,5);
}
{
  \end{tikzpicture}
}
\else%
\newenvironment{tab}{%
  \newcommand{\single}[2]{}%
  \renewcommand{\bar}{}%
}{}%
\fi%
%% End of tabs.sty file

\newcommand{\Intro}{
  \IfStrEq{\@lang}{english}{intro}{}
  \IfStrEq{\@lang}{french}{intro}{}
}
\newcommand{\Outro}{
  \IfStrEq{\@lang}{english}{outro}{}
  \IfStrEq{\@lang}{french}{outro}{}
}
\newcommand{\Bridge}{
  \IfStrEq{\@lang}{english}{bridge}{}
  \IfStrEq{\@lang}{french}{pont}{}
}
\newcommand{\Chorus}{
  \IfStrEq{\@lang}{english}{chorus}{}
  \IfStrEq{\@lang}{french}{refrain}{}
}
\newcommand{\Verse}{
  \IfStrEq{\@lang}{english}{verse}{}
  \IfStrEq{\@lang}{french}{couplet}{}
}
\newcommand{\Solo}{
  \IfStrEq{\@lang}{english}{solo}{}
  \IfStrEq{\@lang}{french}{solo}{}
}
\newcommand{\Pattern}{
  \IfStrEq{\@lang}{english}{pattern}{}
  \IfStrEq{\@lang}{french}{motif}{}
}
\newcommand{\Rythm}{
  \IfStrEq{\@lang}{english}{rythm}{}
  \IfStrEq{\@lang}{french}{rythme}{}
}

\let\musicnoteORIG\musicnote
\renewcommand{\musicnote}[2][]{%
  \vspace{.1cm}
  \IfStrEq{}{#1}{\musicnoteORIG{#2}}{
    \IfStrEq{\@lang}{#1}{\musicnoteORIG{#2}}{}
  }
}

\let\textnoteORIG\textnote
\renewcommand{\textnote}[2][]{%
  \vspace{.1cm}
  \IfStrEq{}{#1}{\textnoteORIG{#2}}{
    \IfStrEq{\@lang}{#1}{\textnoteORIG{#2}}{}
  }
}

\newenvironment{bridge}{%
  \musicnote{\Bridge}%
  \vspace{-.3cm}%
  \begin{verse*}%
}{%
  \end{verse*}
}

%% \SB@chordsoff with a greater for the line spacing
\newcommand{\CB@chordshidden}{%
  \def\SB@bracket##1]{\ignorespaces}%
  \let\SB@rechord\relax%
  \let\SB@ch\SB@ch@off%
  \ifSB@measurespec%
    \ifmeasures\SB@measureson\else\SB@measuresoff\fi%
  \else%
    \SB@measuresoff%
  \fi%
  \ifSB@preamble\let\colbotglue{\z@\@plus.5\textheight}\fi%
  \SB@setbaselineskip%
}

\newenvironment{repeatedchords}{%
  \ifnorepeatchords%
    \CB@chordshidden%
  \fi
}{}%

\makeatother
