%% jpt custom class based on article
%% v 1.2 added libertine support with other minor optimizations
%% v 1.3 added newpx/eulerpx with other minor optimizations
%% v 1.4 refined calligraphic in math script, moved emf definition to chemistry package, added Faraday's constant
%% v 1.5 bug fixes from claude
%% v 1.6 now a true subclass: \LoadClass{article} instead of a copy of article.cls

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{jpt}
              [2026/08/24 v1.6
 Modified LaTeX article class]

% ==========================================================================================
% ==========================================================================================
% ==========================================================================================

% jpt global options/modules

% -- tagging --

\newif\if@tagging\DeclareOption{tagging}{\@taggingtrue} 

% -- fonts --
\newif\if@cm\DeclareOption{cm}{\@cmtrue} 
\newif\if@cmgr\DeclareOption{cmgr}{\@cmgrtrue} 
\newif\if@lm\DeclareOption{lm}{\@lmtrue} 
\newif\if@mlm\DeclareOption{mlm}{\@mlmtrue} 
\newif\if@tmx\DeclareOption{tmx}{\@tmxtrue} 
\newif\if@npx\DeclareOption{npx}{\@npxtrue}
\newif\if@epx\DeclareOption{epx}{\@epxtrue}
\newif\if@minion\DeclareOption{minion}{\@miniontrue}
\newif\if@mtpsymb\DeclareOption{mtpsymb}{\@mtpsymbtrue}
\newif\if@charter\DeclareOption{charter}{\@chartertrue}
\newif\if@nc\DeclareOption{nc}{\@nctrue}
\newif\if@ebg\DeclareOption{ebg}{\@ebgtrue}
\newif\if@bvx\DeclareOption{bvx}{\@bvxtrue}
\newif\if@lib\DeclareOption{lib}{\@libtrue}
\newif\if@tgs\DeclareOption{tgs}{\@tgstrue}
\newif\if@bxoff\DeclareOption{bxoff}{\@bxofftrue}

% -- tables and captions
\newif\if@tables\DeclareOption{tables}{\@tablestrue}
\newif\if@captions\DeclareOption{captions}{\@captionstrue}

% -- geometries
\newif\if@fullpage\DeclareOption{fullpage}{\@fullpagetrue}
\newif\if@wide\DeclareOption{wide}{\@widetrue}
\newif\if@narrow\DeclareOption{narrow}{\@narrowtrue}

% -- ars theme
\newif\if@ars\DeclareOption{ars}{\@arstrue}

% -- block paragraphs
\newif\if@blockpar\DeclareOption{blockpar}{\@blockpartrue}

% -- extra linespacing
\newif\if@onehalf\DeclareOption{onehalf}{\@onehalftrue}
\newif\if@double\DeclareOption{double}{\@doubletrue}
\newif\if@nolinespacing\DeclareOption{nolinespacing}{\@nolinespacingtrue}

% -- footnotes, arabic or roman
\newif\if@footnotes\DeclareOption{footnotes}{\@footnotestrue\@footnotesromanfalse\@footsymbfalse}
\newif\if@footsymb\DeclareOption{footsymb}{\@footnotesfalse\@footnotesromanfalse\@footsymbtrue}
\newif\if@footnotesroman\DeclareOption{footnotesroman}{\@footnotesromantrue\@footnotesfalse\@footsymbfalse}

% -- other packages
\newif\if@misc\DeclareOption{misc}{\@misctrue}
\newif\if@chem\DeclareOption{chem}{\@chemtrue}
\newif\if@lists\DeclareOption{lists}{\@liststrue}
\newif\if@tightlists\DeclareOption{tightlists}{\@tightliststrue}
\newif\if@looselists\DeclareOption{looselists}{\@looseliststrue}
\newif\if@secdots\DeclareOption{secdots}{\@secdotstrue}

% ==========================================================================================
% ==========================================================================================
% ==========================================================================================


% jpt claims its own options above; everything else -- 10pt/11pt/12pt, twoside,
% titlepage, twocolumn, leqno, fleqn, openbib, paper sizes -- goes to article.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% ==========================================================================================
% ==========================================================================================
% ==========================================================================================

% jpt overrides of article.cls -- everything else article now supplies directly.
% Each block is article's own definition with the marked jpt change applied.
%
% TO OVERRIDE SOMETHING ELSE FROM article.cls, add it in this block:
%   1. find the definition in article.cls   (kpsewhich article.cls)
%   2. paste it here, below \LoadClass
%   3. \newcommand -> \renewcommand, \newenvironment -> \renewenvironment;
%      keep any star (\newcommand* -> \renewcommand*); \def stays \def
%   4. make the edit and annotate it the usual way: % jpt was <old value>
% Counters and lengths cannot be re-declared -- use \setcounter / \setlength
% instead of \newcounter / \newlength. If the definition sits inside
% \if@titlepage or \if@twocolumn in article.cls, reproduce that conditional too
% (see \maketitle and abstract below). Forgetting step 3 is safe: LaTeX stops
% with "Command ... already defined" rather than silently doing the wrong thing.
% No \makeatletter needed in here -- @ is already a letter inside a class file.

\if@titlepage               % jpt titlepage settings                          
  \renewcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE\@title \par}%            % jpt could add \bfseries
    \vskip 3em%                      % jpt was 3em
    {\normalsize                     % jpt this was \large by default
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\normalsize \@date \par}%       % jpt this was \large by default
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }
\else
  \renewcommand\maketitle{\par
    \begingroup
      \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
      \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
      \long\def\@makefntext##1{\parindent 1em\noindent
              \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      \if@twocolumn
        \ifnum \col@number=\@ne
          \@maketitle
        \else
          \twocolumn[\@maketitle]%
        \fi
      \else
      \newpage
        \global\@topnum\z@   % Prevents figures from going at top of page.
        \@maketitle
      \fi
      \thispagestyle{plain}\@thanks
    \endgroup
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
  }
\def\@maketitle{%            % jpt maketitle
  %\newpage
  %\null
  %\vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE\@title \par}%    % jpt \bfseries
    \vskip 0.95em%           % jpt was 1.5em
    {\normalsize             % jpt this was \large by default
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 0.65em%           % jpt was 1em
    {\normalsize \@date}%    % jpt this was \large by default
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\setcounter{secnumdepth}{4} % jpt 3 is default

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.25ex \@plus -1ex \@minus -.2ex}% % jpt was -3.5
                                   {1.5ex \@plus.2ex}%                  % jpt was 2.3
                                   {\normalfont\normalsize\bfseries}}   % jpt was \Large
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}  % jpt was \large

\renewcommand\labelitemii {\labelitemfont \bfseries $\circ$}

\if@titlepage
  \renewenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \renewenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        %\small % jpt make abstract font normalsize
        \begin{center}%
          {\bfseries \abstractname\vspace{-0.35em}\vspace{\z@}}% % was -0.5
        \end{center}%
        \quote % jpt was quotation, which uses first line indent
      \fi}
      {\if@twocolumn\else\endquote\fi}
\fi

\setcounter{tocdepth}{4} % jpt 3 is default


% ==========================================================================================
% ==========================================================================================
% ==========================================================================================

% packages
\RequirePackage{comment}
\if@tgs\RequirePackage{unicode-math}\fi
\RequirePackage[version=4]{mhchem}
\frenchspacing
\newenvironment{qnumerate}{\begin{enumerate}\renewcommand\labelenumi{\textbf{Q\theenumi.}}}{\end{enumerate}}
\def\eg{\textit{e.g.}}
\def\ie{\textit{i.e.}}
\def\eof{\end{document}}
\newcommand{\on}[1]{\,\operatorname{#1}}
\newcommand{\ffbox}[1]{\fbox{\fbox{\parbox{.95\textwidth}{\centering #1}}}}

% ==========================================================================================
% ==========================================================================================
% ==========================================================================================

% Redefine \bfseries to use non-extended bold (b, not bx)

\if@bxoff
  \if@cm\AtBeginDocument{\def\bfseries{\fontseries{b}\selectfont}}\else
  \if@lm\AtBeginDocument{\def\bfseries{\fontseries{b}\selectfont}}\else
  \if@mlm\AtBeginDocument{\def\bfseries{\fontseries{b}\selectfont}}\else
    \ClassWarning{jpt}{Option 'bxoff' only applies to cm, lm, or mlm fonts and will be ignored}
  \fi\fi\fi
\fi

% lists

\if@lists
	\RequirePackage[shortlabels]{enumitem}\setlist{noitemsep}
\else
  \if@tightlists
  	\RequirePackage[shortlabels]{enumitem}\setlist{noitemsep,nolistsep}
  \else
    \if@looselists
      \RequirePackage[shortlabels]{enumitem}
    \else
    \fi
  \fi
\fi

% modules

\if@tagging
\RequirePackage{tagpdf}
\tagpdfsetup{activate-all}
\tagpdfsetup{math/alt/use}
\fi

\if@cm
  \RequirePackage{microtype}
  \RequirePackage{setspace}
  \RequirePackage{biolinum}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage{textgreek}
  \RequirePackage{mathrsfs}
\else
\fi

\if@cmgr
  \RequirePackage[grade=D]{cmgraded}
  \RequirePackage{microtype}
  %% The Computer Modern Graded fonts carry no ogonek glyphs (U+0104/0105/0118/
  %% 0119), so microtype cannot resolve a slot for \k A, \k a, \k E, \k e in the
  %% TU character-inheritance list of microtype.cfg and warns about each one.
  %% Re-declare that list for the cmgraded families alone, minus the ogoneks: a
  %% family-specific list takes precedence over the encoding-wide one, and the
  %% rest is verbatim from microtype.cfg, so protrusion is otherwise unchanged.
  %% Family names follow the grade: a/b/c/d/e/f/g = G0/G10/G19/G32/G44/G57/G72,
  %% so grade=D above means G32 here -- keep the two in step.
  \DeclareCharacterInheritance
     { encoding = TU,
       family   = {ComputerModernGradedG32Serif,
                   ComputerModernGradedG32Sans,
                   ComputerModernGradedG32Typewriter} }
     { A = {\`A,\'A,\^A,\~A,\"A,\r A,\u A},
       a = {\`a,\'a,\^a,\~a,\"a,\r a,\u a},
       C = {\'C,\c C,\v C},
       c = {\'c,\c c,\v c},
       D = {\v D,\DH},
       d = {\v d,\dj},
       E = {\`E,\'E,\^E,\"E,\v E},
       e = {\`e,\'e,\^e,\"e,\v e},
       G = {\u G},
       g = {\u g},
       I = {\`I,\'I,\^I,\"I,\.I},
       i = {\`i,\'i,\^i,\"i,\i},
       L = {\L,\'L,\v L},
       l = {\l,\'l,\v l},
       N = {\'N,\~N,\v N},
       n = {\'n,\~n,\v n},
       O = {\O,\`O,\'O,\^O,\~O,\"O,\H O},
       o = {\o,\`o,\'o,\^o,\~o,\"o,\H o},
       R = {\'R,\v R},
       r = {\'r,\v r},
       S = {\'S,\c S,\v S},
       s = {\'s,\c s,\v s},
       T = {\c T,\v T},
       t = {\c t,\v t},
       U = {\`U,\'U,\^U,\"U,\H U,\r U},
       u = {\`u,\'u,\^u,\"u,\H u,\r u},
       Y = {\'Y,\"Y},
       y = {\'y,\"y},
       Z = {\'Z,\.Z,\v Z},
       z = {\'z,\.z,\v z},
       - = "AD
     }
  \RequirePackage{setspace}
  \RequirePackage{biolinum}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage{upgreek}
\else
\fi

\if@lm
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage{lmodern}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage{textgreek}
  \RequirePackage{mathrsfs}
  \else
\fi

\if@mlm
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype} 
  \RequirePackage{mlmodern}   
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage{upgreek}
    \def\textalpha{$\upalpha$}
    \def\textbeta{$\upbeta$}
    \def\textgamma{$\upgamma$}
    \def\textdelta{$\updelta$}
    \def\textepsilon{$\upepsilon$}
    \def\textzeta{$\upzeta$}
    \def\texteta{$\upeta$}
    \def\texttheta{$\uptheta$}
    \def\textiota{$\upiota$}
    \def\textkappa{$\upkappa$}
    \def\textlambda{$\uplambda$}
    \def\textmu{$\upmu$}
    \def\textnu{$\upnu$}
    \def\textxi{$\upxi$}
    \def\textpi{$\uppi$}
    \def\textrho{$\uprho$}
    \def\textsigma{$\upsigma$}
    \def\texttau{$\uptau$}
    \def\textupsilon{$\upupsilon$}
    \def\textphi{$\upphi$}
    \def\textpsi{$\uppsi$}
    \def\textchi{$\upchi$}
    \def\textomega{$\upomega$}
  \RequirePackage[scr=boondox,scrscaled=1.1]{mathalpha}
\else
\fi

\if@tmx
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage[defaultsups,trueslanted]{newtxtext}   
  \RequirePackage[smallerops]{newtxmath} 
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[artemisia]{textgreek}
  \RequirePackage[scr=boondox,scrscaled=1.0]{mathalpha}
\else %
\fi

\if@npx
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage[defaultsups]{newpxtext}
  \RequirePackage[smallerops]{newpxmath}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.2}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[euler]{textgreek}
  \RequirePackage[scr=euler,cal=euler,scrscaled=1.0,calscaled=1.0]{mathalpha}
  \RequirePackage{anyfontsize}
\else
\fi

\if@epx
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage[defaultsups]{newpxtext}
  \RequirePackage{eulerpx}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.2}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[euler]{textgreek}
  \RequirePackage[scr=txupr,cal=txupr,scrscaled=1.0,calscaled=1.0]{mathalpha}
  \RequirePackage{anyfontsize}
\else
\fi

\if@minion
  \RequirePackage{microtype}
  \RequirePackage[minionint,lf]{MinionPro}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \RequirePackage[scr=cm,scrscaled=0.99]{mathalpha}%
  \RequirePackage{textgreek}
  \if@onehalf
    \onehalfspacing
  \fi
  \if@double
    \doublespacing
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \fi
\fi

\if@charter
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage{XCharter}
  \RequirePackage[xcharter]{newtxmath}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[artemisia]{textgreek}
  \RequirePackage[scr=txupr,cal=txupr,scrscaled=0.925,calscaled=0.925]{mathalpha}
  \else
\fi

\if@nc
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype}
  \RequirePackage{fouriernc}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[artemisia]{textgreek}
  \RequirePackage[scr=txupr,cal=txupr,scrscaled=1.0,calscaled=1.0]{mathalpha}
  \else
\fi

\if@ebg
  \RequirePackage[T1]{fontenc}
  \RequirePackage{microtype} 
  \RequirePackage[lf]{ebgaramond}
  \RequirePackage[ebgaramond]{newtxmath}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[euler]{textgreek}
  \RequirePackage[scr=euler,cal=euler,scrscaled=1.0,calscaled=1.0]{mathalpha}
  \else
\fi

\if@bvx
  \RequirePackage[T1]{fontenc} 
  \RequirePackage{microtype}
  \RequirePackage{Baskervaldx}
  \RequirePackage[baskervaldx]{newtxmath}
  \RequirePackage{biolinum}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[artemisia]{textgreek}
  \RequirePackage[scr=boondox,scrscaled=1.05]{mathalpha}
  \else
\fi

\if@lib
  \RequirePackage[T1]{fontenc} 
  \RequirePackage{microtype}
  \RequirePackage{libertine}
  \RequirePackage[libertine]{newtxmath}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \RequirePackage[euler]{textgreek}
  \RequirePackage[scr=euler,cal=euler,scrscaled=1.0,calscaled=1.0]{mathalpha}
  \RequirePackage{anyfontsize}
  \else
\fi

\if@tgs
  \RequirePackage{microtype}
  \RequirePackage{setspace}
  \setstretch{1.1}
  \if@onehalf
    \onehalfspacing
  \else
  \fi
  \if@double
    \doublespacing
  \else
  \fi
  \if@nolinespacing
    \setstretch{1.0}
  \else
  \fi
  \setmainfont{TeX Gyre Schola}
  \setsansfont{TeX Gyre Heros}
  \setmonofont{TeX Gyre Cursor}
  \setmathfont{texgyreschola-math.otf}
\else
\fi

\if@mtpsymb
  \DeclareFontFamily{U}{mtt}{}
    \DeclareFontShape{U}{mtt}{m}{up}{<->mt2exa}{}
  \DeclareSymbolFont{splgreek}{U}{mtt}{m}{up}
    \SetSymbolFont{splgreek}{normal}{U}{mtt}{m}{up}
      \DeclareMathSymbol{\splsum}{\mathop}{splgreek}{"50}
      \let\sum\splsum
      \DeclareMathSymbol{\intop}{\mathop}{splgreek}{"52}
\else
\fi

\if@ars
  \renewcommand{\sfdefault}{iwona}
  \RequirePackage{soul}
  \RequirePackage{textcase}
  \DeclareRobustCommand{\spacedallcaps}[1]{\textls[220]{\MakeTextUppercase{\sffamily #1}}}
  \DeclareRobustCommand{\spacedlowsmallcaps}[1]{\textls[80]{\MakeTextLowercase{\scshape\sffamily #1}}}
  \renewcommand{\abstractname}{\spacedallcaps{Abstract}}
  \RequirePackage[explicit]{titlesec}
    \titleformat{\section}{\sffamily\bfseries}{\thesection}{1.5em}{\spacedallcaps{#1}}
    \titleformat{\subsection}{\sffamily\bfseries}{\thesubsection}{1.5em}{\spacedallcaps{#1}}
    \titleformat{\subsubsection}{\sffamily\bfseries}{\thesubsubsection}{1.5em}{\spacedallcaps{#1}}  
  \def\@maketitle{%            
    \begin{center}%
    \let \footnote \thanks
      {\LARGE\spacedallcaps{\@title} \par}
        \vskip 1.5em%
      {\normalsize             
        \lineskip .5em%
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}%
      \vskip 1em%
      {\normalsize \@date}%    
    \end{center}%
    \par
    \vskip 1.5em}
  \setcounter{secnumdepth}{0}
\else
\fi

\if@fullpage
  \RequirePackage[top=1in, bottom=1in, left=1in, right=1in]{geometry}
\else\if@wide
  \RequirePackage[top=1in, bottom=1in, left=1.8in, right=1.8in]{geometry}
\else\if@narrow
  \RequirePackage[top=0.5in, bottom=0.5in, left=0.5in, right=0.5in, includefoot]{geometry}
\fi\fi\fi

\if@footnotes
  \newcommand\blfootnote[1]{%
    \begingroup
    \renewcommand\thefootnote{}\footnote{#1}%
    \addtocounter{footnote}{-1}%
    \endgroup
  }
  \if@blockpar
    \RequirePackage[bottom,hang]{footmisc}
    \setlength\footnotemargin{0.75em}
  \else
    \RequirePackage[bottom]{footmisc}
  \fi
  \interfootnotelinepenalty=10000
  \setlength{\skip\footins}{0.5cm}
\else
\fi


\if@footsymb
  \if@blockpar
    \RequirePackage[bottom,hang,symbol]{footmisc}
    \setlength\footnotemargin{0.75em}
  \else
    \RequirePackage[bottom,symbol]{footmisc}
  \fi
  \interfootnotelinepenalty=10000
  \setlength{\skip\footins}{0.5cm}
\else
\fi

\if@footnotesroman
  \if@blockpar
    \RequirePackage[bottom,hang]{footmisc}
    \setlength\footnotemargin{0.75em}
  \else
    \RequirePackage[bottom]{footmisc}
  \fi
  \interfootnotelinepenalty=10000
  \setlength{\skip\footins}{0.5cm}
  \renewcommand{\thefootnote}{\textit{\roman{footnote}}}
\else
\fi

\if@blockpar
  \RequirePackage{parskip}
\else
\fi

\if@tables
  \RequirePackage{booktabs}
  \setlength\heavyrulewidth{0.20ex}
  \setlength\cmidrulewidth{0.15ex}
  \setlength\lightrulewidth{0.1ex}
  \if@cm
    \setlength\heavyrulewidth{0.15ex}
    \setlength\cmidrulewidth{0.125ex}
    \setlength\lightrulewidth{0.1ex}
  \else
  \fi
  \if@lm
    \setlength\heavyrulewidth{0.15ex}
    \setlength\cmidrulewidth{0.125ex}
    \setlength\lightrulewidth{0.1ex}
  \else 
  \fi 
  \if@ebg
    \setlength\heavyrulewidth{0.17ex}
    \setlength\cmidrulewidth{0.135ex}
    \setlength\lightrulewidth{0.1ex}
  \else 
  \fi 
\else
\fi

\if@captions
  \RequirePackage[font=normalsize,labelfont={bf}]{caption}
  \captionsetup[table]{aboveskip=0.25em}
  \captionsetup[figure]{skip=0.75em}
\else
\fi

\if@misc
  \RequirePackage{graphicx}
  \RequirePackage{recycle}
  \RequirePackage{float}
  \RequirePackage[dvipsnames]{xcolor}
  \RequirePackage{siunitx}
    \providecommand{\bra}[1]{\langle{#1}}
    \providecommand{\ket}[1]{{#1}\rangle}
  %\RequirePackage{url}
  \RequirePackage[all]{nowidow}
  \RequirePackage{nicefrac}
    \def\half{\nicefrac{1}{2}}
    \def\quarter{\nicefrac{1}{4}}
    \def\threequarter{\nicefrac{3}{4}}
    \def\third{\nicefrac{1}{3}}
    \def\twothird{\nicefrac{2}{3}}
    \def\eighth{\nicefrac{1}{8}}
    \def\threeeighth{\nicefrac{3}{8}}
\else
\fi

\if@chem
  \newcommand{\degc}{$^{\circ}$C}
  \newcommand{\myu}[1]{\text{\space#1}}
  \newcommand{\tild}{$\sim$}
  \newcommand{\cmi}{cm$^{-1}$}
  \newcommand{\cmc}{cm$^{3}$}
  \newcommand{\MM}{\mathcal{M}}
  %% emf and Faraday's constant. Every font module loads mathalpha (or mathrsfs)
  %% to give \mathscr a script face matching its text font, so the default here
  %% stays \mathscr and follows the module. cmgr is the exception: it loads
  %% neither, and wants the STIX calligraphic capitals specifically, so declare
  %% them outright. BOONDOX-calo is the Type 1 STIX oblique calligraphic --
  %% note that mathalpha's scr=boondox is BOONDOX-scr, a different face.
  \if@cmgr
    %% Declared as math symbols rather than an alphabet: \emf and \Faraday take
    %% no argument, and the two of them share a single math family.
    \DeclareSymbolFont{stixcal}{U}{BOONDOX-calo}{m}{n}
    \SetSymbolFont{stixcal}{bold}{U}{BOONDOX-calo}{b}{n}
    \DeclareMathSymbol{\emf}{\mathalpha}{stixcal}{`E}
    \DeclareMathSymbol{\Faraday}{\mathalpha}{stixcal}{`F}
    %% BOONDOX-calo is a U-encoded font, so its E/F would reach the tagged PDF
    %% and the MathML as plain Latin E/F. Tell luamml the real Unicode --
    %% U+2130 SCRIPT CAPITAL E and U+2131 SCRIPT CAPITAL F -- so text extraction
    %% and MathML both come out right under pdfstandard=ua-2. Inert when luamml
    %% is not loaded; the family number is only fixed once the preamble ends.
    \AddToHook{begindocument}{%
      \ifdefined\directlua
        \directlua{%
          local ok, conv = pcall(require, 'luamml-convert')
          if ok then
            conv.register_family(\number\symstixcal, {[0x45] = 0x2130, [0x46] = 0x2131})
          end
        }%
      \fi
    }
  \else
    \newcommand{\emf}{\mathscr{E}}
    \newcommand{\Faraday}{\mathscr{F}}
  \fi
  \newcommand{\delg}{\Delta G}
  \newcommand{\dgnot}{\Delta G^{\circ}}
  \newcommand{\dgfnot}{\Delta G_{\text{f}}^{\circ}}
  \newcommand{\dgrxn}{\Delta G_{\text{rxn}}}
  \newcommand{\dgnotrxn}{\Delta G_{\text{rxn}}^{\circ}}
  \newcommand{\delh}{\Delta H}
  \newcommand{\dhrxn}{\Delta H_{\text{rxn}}}
  \newcommand{\dhnotrxn}{\Delta H_{\text{rxn}}^{\circ}}
  \newcommand{\dhnot}{\Delta H^{\circ}}
  \newcommand{\dhf}{\Delta H_{\text{f}}}
  \newcommand{\dhfnot}{\Delta H_{\text{f}}^{\circ}}
  \newcommand{\dhfus}{\Delta H_{\text{fus}}}
  \newcommand{\dhvap}{\Delta H_{\text{vap}}}
  \newcommand{\dsnotrxn}{\Delta S_{\text{rxn}}^{\circ}}
  \newcommand{\dsnot}{\Delta S^{\circ}}
  \newcommand{\dels}{\Delta S}
  \newcommand{\essnot}{S^{\circ}}
  \newcommand{\electron}{e^-}
  \newcommand{\Ecell}{\emf_{\text{cell}}} 
  \newcommand{\Enotcell}{\emf^{\circ}_{\text{cell}}}
  \newcommand{\Enot}{\emf^{\circ}}
  \newcommand{\Ka}{K_{\text{a}}}
  \newcommand{\Kb}{K_{\text{b}}}
  \newcommand{\Kw}{K_{\text{w}}}
  \newcommand{\Ksp}{K_{\text{sp}}}
  \newcommand{\Qsp}{Q_{\text{sp}}}
  \newcommand{\Keq}{K_{\text{eq}}}
  \newcommand{\Kp}{K_p}
  \newcommand{\Kc}{K_{\text{c}}}
  \newcommand{\pKa}{\text{p}K_{\text{a}}}
  \newcommand{\pKb}{\text{p}K_{\text{b}}}
  \newcommand{\dipole}{+\hspace*{-3mm}\longrightarrow}
  \newcommand{\cd}{\cdot}
  \newcommand{\ub}[2]{\underbrace{\text{#1}}_{\text{#2}}} % usage: \ub{top}{bottom}
  \newcommand{\us}[2]{\underset{\text{#2}}{\text{#1}}}    % usage: \us{top}{bottom}
  \newcommand{\da}[4]{\left(\frac{#1\myu{#2}}{#3\myu{#4}}\right)}
\else
\fi

\if@secdots
  \if@ars\else
    \RequirePackage{titlesec}
    \titleformat{\section}{\bfseries}{\thesection.}{1ex}{}
    \titleformat{\subsection}{\bfseries}{\thesubsection.}{1ex}{}
    \titleformat{\subsubsection}{\bfseries}{\thesubsubsection.}{1ex}{}
  \fi
\fi

% ==========================================================================================
% ==========================================================================================
% ==========================================================================================

\endinput

%%
%% End of file `jpt.cls'.
