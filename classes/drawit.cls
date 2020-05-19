% Modified by Eric "LP" Carlsson
% Modified by Johan "Horv" Andersson
% Original by Adam Sandberg Ericsson
% https://github.com/dtekcth/dtek-tex/blob/master/dtek.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{drawit}[2020/05/18 Intresseföreningen DrawIT]

\newif\ifincludeaddress
\includeaddresstrue
\DeclareOption{noincludeaddress}{\includeaddressfalse}

\newif\ifincludeauthors
\includeauthorstrue
\DeclareOption{noincludeauthors}{\includeaddressfalse}

\newif\ifpagination
\paginationtrue
\DeclareOption{nopagination}{\paginationfalse}

\ProcessOptions\relax

\LoadClass[11pt, a4paper]{article}

\RequirePackage[quiet]{fontspec}
\RequirePackage{parskip}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[swedish]{babel}
\RequirePackage{lastpage}
\RequirePackage[unicode]{hyperref}
\RequirePackage[includeheadfoot, top=2.0cm, bottom=4cm]{geometry}
\RequirePackage{xparse}
\RequirePackage{etoolbox}

\RequirePackage{pdfpages}

\definecolor{linkblue}{HTML}{0000ee}

\AtBeginDocument{
  \hypersetup{
    pdftitle = {\@title},
    pdfauthor = {\@author},
    colorlinks=true,
    citecolor=black,
    filecolor=black,
    linkcolor=black
  }
}

\DeclareDocumentCommand \paragraphref {m}{%
    §\ref{#1}%
}

\DeclareDocumentCommand \MYhref { O{linkblue} m m }{%
  \href{#2}{\color{#1}{#3}}%
}

\DeclareDocumentCommand \created {m} {%
  \DeclareDocumentCommand \@created {}{#1}
}

\DeclareDocumentCommand \approved {m} {%
  \DeclareDocumentCommand \@approved {}{#1}
}

\DeclareDocumentCommand \revisioned {m} {%
  \DeclareDocumentCommand \@revisioned {}{#1}
}

\DeclareDocumentCommand \editorial {m} {%
  \DeclareDocumentCommand \@editorial {}{#1}
}

\DeclareDocumentCommand \maketitle {} {%
  
      \begin{center}
        \vspace*{0.5cm}

                
        {\bf\Huge \@title\par}
  
        \vspace{0.2cm}
        \ifdef{\@subtitle}{{\LARGE \@subtitle\par}}{}

        \vspace{0.2cm}
        
        \textbf{Intresseföreningen DrawIT} \\
        \large
        \textbf{Teknologsektionen Informationsteknik} \\
        \Large
        \textbf{Chalmers Tekniska Högskola}

        \vspace{2cm}
        \centerline{ \includegraphics[width=0.5\textwidth]{images/drawit.png}}
        \vspace{2cm}
        
        \Large
        
        \ifdef{\@created}{{Föreningens bildande: \@created \\}}{}
        \ifdef{\@approved}{{Beviljad av sektionsstyrelsen: \@approved \\}}{}
        \ifdef{\@editorial}{{Redaktionell revidering: \@editorial\\}}{}
        \ifdef{\@revisioned}{{Reviderad: \@revisioned}}{}
        
        
    \end{center}
}

% Set up headers

\DeclareDocumentCommand \makehf {}{%
  \pagestyle{fancy}
  \fancyhf{}
  
  \newcommand{\headleft}{%
    \raisebox{-3mm}{\includegraphics[width=14mm]{images/drawit.png}}\hspace{1mm}
    \parbox[b]{12cm}{%
      \textbf{Intresseföreningen DrawIT}\\
      Teknologsektionen Informationsteknik\\
      \@title
    }
  }

  \newcommand{\headright}{%
    \ifpagination
      Sida \thepage\ av \pageref{LastPage}\\
    \fi
    \ifdef{\@revisioned}{{\@revisioned}}{}
  }
  
  % Calculate header height
  \settototalheight\headheight{\headleft}
  \addtolength\headheight{1.0pt}
  
  \lhead{\headleft}

    \rhead{\headright}

  
  \renewcommand{\headrule}{
    \nointerlineskip
    \hskip 16mm\hrulefill
  }

  \renewcommand{\footrulewidth}{\headrulewidth}

  \ifincludeaddress
  
    \lfoot{%
      \flushleft Intresseföreningen DrawIT\\
      Hörsalsvägen 9\\
      412 58 Göteborg
    }
    
    \rfoot{%
      \begin{flushright}
        \href{mailto:drawit@chalmers.it}{drawit@chalmers.it}\\
        \href{https://drawit.chalmers.it}{https://drawit.chalmers.it}
      \end{flushright}
    }
  \fi
}

\DeclareDocumentCommand \makeheadfoot {}{\makehf}

\DeclareDocumentCommand \makesign {m} {%
  \parbox{0.47\textwidth}{%
    \vspace{2cm}
    \rule{0.47\textwidth}{0.5pt}\\
    #1
  }
}

\endinput
