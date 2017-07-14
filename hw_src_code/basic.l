%{
#include "basic.tab.h"
#include <math.h>
//#include "symbol.h"
extern YYSTYPE  yylval;
%}

%%
"LIST"			return LIST;
"RUN"			return RUN;
"QUIT"			return QUIT;
"LINE-NUM"		return LN;
[0-9]+			{ yylval.int_val = atoi(yytext); return NUMBER; } 
\".*\"			{ yylval.str_val = yytext; return STRING; }
[ \t]			;
"\n"			return CR;
"REM "			return REM;
"PRINT "		return PRINT;
"INPUT "		return INPUT;
"LET " 			return LET;
"GOTO "			return GOTO;
"IF "			return IF;
"THEN "			return THEN;
[A-Z]{1}		{ yylval.int_val = atoi(yytext); return VARIABLE; }
"="			return TAS;
"+"			return TPLUS;
"-"			return TMINUS;
"*"			return TMUL;
"/"			return TDIV;
"<"			return TGT;
">"			return TLT;
"<="			return TGE;
">="			return TLE;
"<>"			return TUE;
"=="			return TEQ;
.			return yytext[0];
%%

