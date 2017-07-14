%{
#include <ctype.h>
#include <stdio.h>
void yyerror(char *);
int yylex(void);
int reg;
%}
%token DIGIT
%token REGISTER
%left '+' '-'
%left '*'
%nonassoc NEG
%%

lines: line '\n'
| lines line '\n'
;
line :  expr {
              reg = $1;
              printf("%d\n", $1);
	      
        }
;
expr :   expr '+' expr           {$$ = $1 + $3;}
|        expr '-' expr           {$$ = $1 - $3;}
|        '-' expr %prec NEG      {$$ = -$2;}
|        expr '*' expr           {$$ = $1 * $3;}
|        '(' expr ')'            {$$ = $2;}
|        term
;
term :   term DIGIT              { $$ = $1 * 10 + $2;}
|        REGISTER                {$$ = reg;}
|        DIGIT
;

%%
yylex()
{
        int c ;
        c = getchar() ;
        if (isdigit(c)) {
                yylval = c - '0' ;
                return DIGIT ;
        }
        else if(isalpha(c)){

                return REGISTER;
        }
        return c ;
}
void yyerror(char *s){
        fprintf(stderr, "%s\n", s);
}
int main(int argc, char const* argv[]){
	printf("testing"); 
	yyparse();
	
}


