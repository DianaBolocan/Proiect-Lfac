
%{
#include <stdio.h>
#include "y.tab.h"
%}
%%

"int"|"float"|"char"|"string" {return TIP;}
"#defineste" {return DEFINESTE;}
"print" {return PRINT;}
"concat" {return CONCAT;}
"copiaza" {return COPI;}
"lungime" {return LUNG;}
"compara" {return COMP;}
"cauta" {return CAUTA;}
"->" {return DE;}
"<=" {return LEQ;}
">=" {return GEQ;}
"!=" {return NEQ;}
"==" {return EQ;}
"&&" {return AND;}
"||" {return OR;}
"daca" {return DACA;}
"atunci" {return AT;}
"cheama" {return CHEAMA;}
"altfel" {return ALTFEL;}
"cat" {return CAT;}
"timp" {return TIMP;}
"pentru" {return PENTRU;}
"fiecare" {return FIECARE;}
"unde" {return UNDE;}
"si" {return SI;}
"structura" {return STRUCT;}
"functie_princ()" {return MAIN;}
_[a-zA-Z][a-zA-Z0-9]* {return FUNCTIE;}
"start_program" {return BGIN_P;}
"sfarsit_program" {return END_P;}
"::start_functie" {return BGIN_F;}
"::sfarsit_functie" {return END_F;}
"::start_bloc" {return BGIN_B;}
"::sfarsit_bloc" {return END_B;}
@[a-zA-Z][a-zA-Z0-9]* {return ID;}
![ a-zA-Z][ a-zA-Z0-9]* {return STRING;}
":=" {return ASSIGN;}
[0-9]|[1-9][0-9]+ {return NR;}
[ \t] ;
\n {yylineno++;}
. {return yytext[0];}

 

