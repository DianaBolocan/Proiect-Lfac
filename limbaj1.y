%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token PRINT DEFINESTE CONCAT COPI LUNG CAUTA COMP DE LEQ GEQ EQ NEQ AND OR DACA AT ALTFEL STRUCT CHEAMA UNDE SI PENTRU FIECARE CAT TIMP ID TIP BGIN_P END_P ASSIGN NR BGIN_F END_F BGIN_B END_B FUNCTIE MAIN STRING
%start progr
%left  '+'  '-'
%left  '*'  '/'
%right ASSIGN
%%
progr: BGIN_P defines subfunctions princ END_P {printf("program corect sintactic\n");}
     ;

defines : define
	| defines ',' define
        ;

define : DEFINESTE ID NR
       | DEFINESTE ID STRING
       ;

subfunctions : subfunction
	     | subfunctions subfunction
	     ;

subfunction : TIP FUNCTIE '(' params ')' BGIN_F END_F
	    | TIP FUNCTIE '(' params ')' BGIN_F stmt_list END_F
	    | TIP FUNCTIE '(' ')' BGIN_F END_F
	    | TIP FUNCTIE '(' ')' BGIN_F stmt_list END_F
	    ;

princ : MAIN BGIN_F stmt_list END_F
     ;

stmt_list : stmt
	  | stmt_list stmt
     	  ;

stmt : ID ASSIGN exp '.'
     | ID DE ID ASSIGN exp '.'
     | void_strexps '.'
     | decl '.'
     | CHEAMA FUNCTIE '(' call_list ')' '.'
     | CHEAMA FUNCTIE '(' ')' '.'
     | DACA bexp AT block '.'
     | DACA bexp AT block ALTFEL block '.'
     | CAT TIMP bexp block '.'
     | PENTRU FIECARE ID ASSIGN exp UNDE bexp SI exp block '.'
     | PENTRU FIECARE ID UNDE bexp SI exp block '.'
     | PRINT '(' exp ')' '.'
     ;

exp : NR
    | ret_strexps
    | ID
    | ID DE ID
    | exp '+' exp	{$$ = $1 + $3 ;}
    | exp '-' exp	{$$ = $1 - $3 ;}
    | exp '*' exp	{$$ = $1 * $3 ;}
    | exp '/' exp	{$$ = $1 / $3 ;}
    | exp '+' '+'	{$$ = $1 + 1 ;}
    | '(' exp ')'
    ;

strexp : STRING
       | ID DE ID
       | ID
       ;

void_strexps : COPI '(' strexp ',' strexp ')'
             | CONCAT '(' strexp ',' strexp ')'
             ;

ret_strexps : CAUTA '(' strexp ',' strexp ')'	{/*cauta si returneaza pozitia de unde se gaseste strexp 2 in strexp 1 sau returneaza -1 in cazul in care nu se gaseste*/}
            | COMP '(' strexp ',' strexp ')'
            | LUNG '(' strexp ')'
            ;


bexp : exp '<' exp
     | exp LEQ exp
     | exp '>' exp
     | exp GEQ exp
     | exp EQ exp
     | exp NEQ exp
     | '(' '!' bexp ')'
     | '(' bexp AND bexp ')'
     | '(' bexp OR bexp ')'
     | '(' bexp ')'
     ;

decl : TIP ID			{ $2 = 0 ;}
     | TIP ID '[' NR ']' 
     | STRUCT ID block id_list
     ;

params : param
       | params ',' param 
       ;
            
param : TIP ID
      ;
      
block : BGIN_B stmt_list END_B
      | BGIN_B END_B
      ;
        
call_list : call_unit
	  | call_list ',' call_unit
	  ;

call_unit : exp
	  | FUNCTIE '(' call_list ')'
	  ;

id_list : id_unit
	| id_list ',' id_unit
	;

id_unit : ID
	;


%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
} 

