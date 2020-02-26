\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{bbawslides}[2015/08/24 bbawslides]
\typeout{bbawslides : BBAW v0.01 Bryan Jurish and Kay-Michael Würzner}
\typeout{ }

%%==============================================================================
%% Base Class
\LoadClass[a4,portrait]{seminar}

%%==============================================================================
%% Packages
\RequirePackage{pstcol} % To use the standard `color' package with Seminar
\RequirePackage{semcolor}
\RequirePackage[utf8]{inputenc}
\RequirePackage{epsfig}
\RequirePackage{tikz}
\RequirePackage{color}
\RequirePackage{graphics}
\RequirePackage{amssymb}  %%-- for alternate bullets (?)
\RequirePackage{amsmath}  %%-- for \overset{}{}
\RequirePackage{tipa} %%-- phonetic symbols, also used for historical graphemes
\RequirePackage[normalem]{ulem}
\RequirePackage{colortbl}          %%-- color table, \arrayrulecolor etc.

\RequirePackage{numprint}
\npthousandsep{,}\npthousandthpartsep{}\npdecimalsign{.}

%\IfFileExists{pst-grad}{\RequirePackage{pst-grad}}{\RequirePackage{gradient}} %%-- for color gradients

%%-- sans serif
\RequirePackage[lighttt]{lmodern}
\renewcommand{\familydefault}{\sfdefault}

\input{seminar.bug}
\input{seminar.bg2}
%\input{seminar-bg2-lepennec.fix}

\RequirePackage[a4paper]{hyperref}
\rotateheaderstrue	%%-- otherwise seminar does strange things
\RequirePackage{url}

\hypersetup{colorlinks=false,urlbordercolor={0 1 1}}
%\hypersetup{colorlinks=false,urlbordercolor={0 0 1}}
%\hypersetup{colorlinks=true,urlcolor=blue}

\RequirePackage{fancybox}

% Increase slide height (\slidewidth in portrait mode) but reduce text height
\addtolength{\slidewidth}{2.5cm}
\extraslideheight{1cm}

\RequirePackage{verbatim}

%%-- moo: disable automatic page-breaking (?)
%\extraslideheight{10in}


%%-- slide size adjustment: a4 defaults
%\paperwidth 210mm
%\paperheight 297mm
%\slidewidth 222mm
%\slideheight 152mm
%%

%%======================================================================
%% Configuration macros

%% \footerText : command to insert footer text
%\newcommand{\footerText}{{\tiny 2015-06-24 / FSMNLP / Universität Düsseldorf}}%
\newcommand{\footerText}{}


%%======================================================================
%% colors

%%-- bbaw red
\definecolor{bbawred}{cmyk}{0, 0.939, 0.758, 0.224}
\definecolor{bbawredouter}{rgb}{0.5, 0.03, 0.12}

%%-- moocow's predefined colors
\RequirePackage{mooColors}

%%--------------------------------------------------------------
%% colors: text highlighting

\definecolor{hlredc}{named}{bbawred}
\definecolor{hlbluec}{rgb}{0 0 0.97}
\definecolor{hlpurplec}{rgb}{0.32 0.00 0.97}
\definecolor{hlgreenc}{rgb}{0 .4 0}
\definecolor{hlgrayc}{gray}{0.5}

%%======================================================================
%% macros: text highlighting

\newcommand{\hlred}[1]{\textcolor{hlredc}{#1}}
\newcommand{\hlredbf}[1]{\textcolor{hlredc}{\textbf{#1}}}
%%
\newcommand{\hlouter}[1]{\textcolor{bbawredouter}{#1}}
\newcommand{\hlouterbf}[1]{\textcolor{bbawredouter}{\textbf{#1}}}
%%
\newcommand{\hlblue}[1]{\textcolor{hlbluec}{#1}}
\newcommand{\hlbluebf}[1]{\textcolor{hlbluec}{\textbf{#1}}}
%%
\newcommand{\hlpurple}[1]{\textcolor{hlpurplec}{#1}}
\newcommand{\hlpurplebf}[1]{\textcolor{hlpurplec}{\textbf{#1}}}
%%
\newcommand{\hlgreen}[1]{\textcolor{hlgreenc}{#1}}
\newcommand{\hlgreenbf}[1]{\textcolor{hlgreenc}{\textbf{#1}}}
%%
\newcommand{\hlz}[1]{\textcolor{black}{#1}}
\newcommand{\hlg}[1]{\textcolor{hlgrayc}{#1}}
%%
\newcommand{\hlbf}[1]{{\bfseries #1}}
\newcommand{\hlsl}[1]{{\slshape #1}}
\newcommand{\hlbfsl}[1]{{\bfseries\slshape #1}}
\newcommand{\hlslbf}[1]{\hlbfsl{#1}}

\newcommand{\hlh}[1]{\hlred{#1}}
%\newcommand{\hlhead}[1]{{\large\hlredbf{#1}}}
\newcommand{\hlhead}[1]{{\hlredbf{#1}}}

\newlength{\hlheadpreskip}\setlength{\hlheadpreskip}{0pt}
\newlength{\hlheadpostskip}\setlength{\hlheadpostskip}{-6mm}
\newcommand{\hlheadline}[1]{%
  \vpar[\hlheadpreskip]%
  \hlhead{#1}\\[\hlheadpostskip]%
}

\newcommand{\hltalktitle}[1]{{\Large\textcolor{bbawred}{\textbf{#1}}}}
\newcommand{\hlparttitle}[1]{{\Large\textcolor{bbawred}{\textbf{#1}}}}

\newcommand{\hlex}[1]{\hlg{\hlsl{\hlred{(#1)}}}}
\newcommand{\fillex}[1]{\hfill\hlex{#1}}
\newcommand{\hlcitex}[1]{\hfill{\hlsl{\hlg{\textmd{#1}}}}}
\newcommand{\hlcitesm}[1]{\hlcitex{\small (#1)}}
\newcommand{\hlcitefn}[1]{\hlcitex{\footnotesize (#1)}}
\newcommand{\hlcitesc}[1]{\hlcitex{\scriptsize (#1)}}
\newcommand{\hlcite}[1]{\hlcitesm{#1}}

\definecolor{urlColor}{named}{hlbluec}
\newcommand{\hlurl}[1]{\textcolor{urlColor}{\url{#1}}}
\newcommand{\urlref}[1]{\href{#1}{\hlurl{#1}}}

%%-- highlighting aliases
\newcommand{\hla}[1]{\hlred{#1}}
\newcommand{\hlo}[1]{\hlouter{#1}}
\newcommand{\hlb}[1]{\hlblue{#1}}
\newcommand{\hlc}[1]{\hlpurple{#1}}
\newcommand{\hld}[1]{\hlgreen{#1}}
%%
\newcommand{\hlabf}[1]{\hla{\hlbf{#1}}}
\newcommand{\hlobf}[1]{\hlo{\hlbf{#1}}}
\newcommand{\hlbbf}[1]{\hlb{\hlbf{#1}}}
\newcommand{\hlcbf}[1]{\hlc{\hlbf{#1}}}
\newcommand{\hldbf}[1]{\hld{\hlbf{#1}}}
%%
\newcommand{\hlasl}[1]{\hla{\hlsl{#1}}}
\newcommand{\hlosl}[1]{\hlo{\hlsl{#1}}}
\newcommand{\hlbsl}[1]{\hlb{\hlsl{#1}}}
\newcommand{\hlcsl}[1]{\hlc{\hlsl{#1}}}
\newcommand{\hldsl}[1]{\hld{\hlsl{#1}}}
%%
\newcommand{\hlabfsl}[1]{\hla{\hlbfsl{#1}}}
\newcommand{\hlobfsl}[1]{\hlo{\hlbfsl{#1}}}
\newcommand{\hlbbfsl}[1]{\hlb{\hlbfsl{#1}}}
\newcommand{\hlcbfsl}[1]{\hlc{\hlbfsl{#1}}}
\newcommand{\hldbfsl}[1]{\hld{\hlbfsl{#1}}}

%%-- newline aliases
\newlength{\vparsep}\setlength{\vparsep}{0pt}
\newcommand{\vpar}[1][\vparsep]{\par\vspace*{-\parsep}\vspace*{#1}}


%%======================================================================
%% macros: slide utilities

% Header and footer inside the frame
\newslideframe{HeaderBox}{%
  \boxput(0,1.16){\psframebox*[fillcolor=bbawred]{\makebox(408,50)[lc]{}}}{#1}%
}
%%
\newslideframe{HeaderText}{%
  \boxput(0,1.16){%
    \makebox(408,50)[lc]{\hspace*{2em}\textcolor{white}{\Large\textbf{\Title}}}
  }{#1}%
}
%%
\newslideframe{FooterRuleGrad}{%
  \psframe[%
    linestyle=none,%
    fillstyle=gradient,
    gradangle=90,
    gradbegin=gray85p,
    gradend=white,
    gradmidpoint=1.0,
    gradlines=256
  ]%
  (-1.1,-0.70)(12.33,-0.75)%
  {#1}
}
\newgray{footerRuleColor}{.75}
\newslideframe{FooterRuleSolid}{%
%  \boxput(0,-0.96){\textcolor{gray75p}{\rule{\slidewidth}{0.5pt}}}{#1}%
%  \boxput(0,-1.2){\textcolor{gray75p}{\rule{2in}{0.5pt}}}{#1}%
  \psline[linecolor=footerRuleColor,linewidth=0.5pt]{}(-1.1,-0.65)(12.21,-0.65){#1}
}
%%
\definecolor{footerTextColor}{gray}{0.6}
\newslideframe{FooterLeft}{%
  \rput[bl](-1.0,-1.1){\textcolor{footerTextColor}{\footerText}}{#1}%
}
%%
\newslideframe{FooterRight}{%
  \boxput(0.95,-1.16){
    \epsfig{file=logos/BBAWlogo.ps,height=1.2cm}}{#1}%
}
%%
\newslideframe{WaterMark}{%
%  \boxput(0.89,1.15){\tikz\node[opacity=0.05] {\epsfig{file=logos/BBAWSiegel.eps,height=5cm}};}{#1}%
  \boxput(0.97,1.03){\tikz\node[opacity=0.1] {\epsfig{file=logos/BBAWSiegel.eps,height=5cm}};}{#1}%
}

%%======================================================================
%% macros: slide frame styles

\newcommand{\slideStyleFrame}{
  \slideframe{none}
  \slideframe*{HeaderText}
  \slideframe*{WaterMark}
  \slideframe*{HeaderBox}
  % \slideframe*{FooterRuleGrad}
  \slideframe*{FooterRuleSolid}
  \slideframe*{FooterLeft}
  \slideframe*{FooterRight}
}

\newcommand{\slideStylePlain}{
  \slideframe{none}
  %\slideframe*{HeaderText}
  \slideframe*{WaterMark}
  %\slideframe*{HeaderBox}
  % \slideframe*{FooterRuleGrad}
  \slideframe*{FooterRuleSolid}
  \slideframe*{FooterLeft}
  \slideframe*{FooterRight}
}

\slidepagestyle{empty}


%%======================================================================
%% bbaw slide environment: \begin{bbawslide}[stretch]{title} ... \end{bbawslide}
\newenvironment{bbawslide}[2][1.18]{%
  \slideStyleFrame%
  \centerslidestrue%
  \renewcommand{\slidestretch}{#1}%
  \renewcommand{\Title}{#2}%
  \begin{slide}%
}{%
  \end{slide}%
}

%%======================================================================
%% bbaw title slide: \begin{bbawtitle}[title]...\end{bbawtitle}
\newenvironment{bbawtitle}[1][]{%
  \slideStylePlain%
  \centerslidesfalse%
  \begin{slide}%
  \begin{center}%
  \ifthenelse{\equal{#1}{}}{}{\vspace*{22mm}\hltalktitle{#1}\par}%
}{%
  \end{center}%
  \end{slide}%
}

%%======================================================================
%% bbaw part-switch slide: \begin{bbawpart}{title}...\end{bbawpart}
\newenvironment{bbawpart}[1][]{%
  \slideStylePlain%
  \centerslidestrue%
  \begin{slide}%
  \begin{center}%
  \ifthenelse{\equal{#1}{}}{}{\hlparttitle{#1}}%
}{%
  \end{center}%
  \end{slide}%
}


%%======================================================================
%% macros: bullets

%%-- bullets: MnSymbol (wonks up latex math symbols (e.g. "|", "\{", "\}"))
%\RequirePackage{MnSymbol}
%\renewcommand{\labelitemi}{\textcolor{bbawred}{\raisebox{.02em}{$\filledmedsquare$}}}
%\renewcommand{\labelitemii}{\textcolor{bbawred}{\raisebox{.05em}{$\bullet$}}}
%\renewcommand{\labelitemiii}{\textcolor{bbawred}{\raisebox{.05em}{$\filledtriangleright$}}}
%\renewcommand{\labelitemiv}{\textcolor{bbawred}{$\circ$}}
%%
%%-- bullets: ifsym (debian package texlive-fonts-extra)
\RequirePackage[geometry]{ifsym}
\renewcommand{\labelitemi}{\textcolor{bbawred}{\raisebox{-1pt}{{\small\FilledSmallSquare}}}}
\renewcommand{\labelitemii}{\textcolor{bbawred}{{\scriptsize\FilledSmallTriangleRight}}}
\renewcommand{\labelitemiii}{\textcolor{bbawred}{$\bullet$}}
\renewcommand{\labelitemiv}{\textcolor{bbawred}{$\circ$}}

%%======================================================================
%% itemize variant

\newlength{\mitemsep}
\newlength{\mitemparskip}
\newlength{\mitemparsep}
\newlength{\mitempreskip}
\newlength{\mitempostskip}
\setlength{\mitemsep}{.5\itemsep}
\setlength{\mitemparskip}{0pt}
\setlength{\mitemparsep}{0pt}
\setlength{\mitempreskip}{-2\mitemsep}
\setlength{\mitempostskip}{\mitemsep}

\newenvironment{mitemize}{%
  \vspace*{\mitempreskip}%
  \begin{itemize}%
    \setlength{\itemsep}{\mitemsep}%
    \setlength{\parskip}{\mitemparskip}%
    \setlength{\parsep}{\mitemparsep}%
}{%
  \end{itemize}%
  \vspace*{\mitempostskip}%
}


%%======================================================================
\endinput

%
% modelines
%

%%% Local Variables:
%%% mode: LaTeX
%%% coding: utf-8
%%% tab-width: 4
%%% indent-tabs-mode: nil
%%% End:

% vim: set ts=4 sw=4 expandtab :
