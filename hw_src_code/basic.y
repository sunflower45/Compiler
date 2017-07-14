%{
#include <ctype.h>
#include <stdio.h>
//#include "symbol.h"
#include <string.h>
extern FILE* yyin;
int  vbltables[26];
void yyerror(const char *s) { printf("ERROR: %s\n", s); }
%}

%union {
	char* str_val;
	double double_val;
	int int_val;
	//struct symtab *symp;
}

%token <str_val>	STRING LIST RUN QUIT LN
%token <int_val>	NUMBER
%token <int_val>	VARIABLE
%token <str_val>	REM PRINT INPUT LET GOTO IF THEN
%token <str_val>	CR TAS TPLUS TMINUS TMUL TDIV TGT TLT TGE TLE TUE TEQ
%type  <int_val>	expr term fact comp cond assign line_num
%left TPLUS TMINUS
%left TMUL TDIV
%start codeline

%%
cmd		:	LIST
		|	RUN
		|	QUIT
		|	LN
		;
codeline	:	line 		CR		
		|	codeline line	CR
		|	CR	
		;

line		:	line_num  stmt 	
		;

line_num	:	NUMBER
		;

stmt		:	REM STRING 		
		|	PRINT STRING 		{ printf("%s\n", $2); }		 
		|	PRINT VARIABLE		{ printf("%d\n", vbltables[$2]); } 
		|	INPUT VARIABLE		{ 
						  printf("input var : ");
						 // scanf("%c", &$2); 
						}
		|	LET assign		{  }
		|	GOTO NUMBER		{  }
		|	IF cond			{  }
		|	THEN NUMBER		{  }
		;

assign		:	VARIABLE TAS NUMBER	{ vbltables[$1] = $3; $$ = vbltables[$1]; }
		|	VARIABLE TAS  expr	{ vbltables[$1] = $3; $$ = vbltables[$1]; }
		;

cond		:	comp  TGT  comp		{  }
		|	comp  TLT  comp		{  }
		|	comp  TGE  comp		{  }
		|	comp  TLE  comp		{  }
		|	comp  TUE  comp		{  }
		|	comp  TEQ  comp		{  }
		;
comp		: 	VARIABLE		{ $$ = vbltables[$1]; }
		|	NUMBER			{ $$ = $1; }
		;

expr		:	expr TPLUS  term	{ $$ = $1+$3; }
		|	expr TMINUS term	{ $$ = $1-$3; }
		|	term			{ $$ = $1; }
		;

term		:	term TMUL fact		{ $$ = $1*$3; }
		|	term TDIV fact		{ $$ = $1/$3; }
		|	fact			{ $$ = $1; }
		;

fact		:	NUMBER			{ $$ = $1; }
		|	VARIABLE		{ $$ = vbltables[$1]; }
		|	'('expr')'		{ $$ = $2; }
		;

%%

int main(int argc, char** argv) {
	if(argc==2)
	{
		yyin = fopen(argv[1], "r");
		if(!yyin)
		{
			fprintf(stderr, "cannot read file %s\n", argv[1]);
			return 1;
		}
	}
	yyparse();
}

