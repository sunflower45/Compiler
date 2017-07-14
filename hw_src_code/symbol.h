#define NSYMS 20
struct symtab {
	char *name;
	int  value;
}symtab[NSYMS];

struct symtab *symlook();

struct symtab *symlook(char *s) {
	struct symtab *sp;
	for(sp = symtab; sp<&symtab[NSYMS]; sp++) {
		if(sp->name && !strcmp(sp->name, s))
			return sp;
		if(!sp->name) {
			sp->name = strdup(s);
			return sp;
		}
	}
	yyerror("Too many symbols");
	exit(1);
}
