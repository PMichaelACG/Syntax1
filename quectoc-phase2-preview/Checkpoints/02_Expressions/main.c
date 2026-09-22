#include <stdio.h>
#include "parser.tab.h"

extern FILE *yyin;
extern int yylineno;
extern int lexical_error;
int yylex_destroy(void);

void yyerror(const char *message)
{
    /* The scanner has already explained a lexical failure. */
    if (!lexical_error)
        fprintf(stderr, "Syntax error at line %d: %s\n", yylineno, message);
}

int main(int argc, char **argv)
{
    if (argc > 2) {
        fprintf(stderr, "Usage: %s [source.qc]\n", argv[0]);
        return 2;
    }
    yyin = stdin;
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 2;
        }
    }
    /* The parser requests tokens from the scanner as needed. */
    int status = yyparse();
    if (yyin != stdin)
        fclose(yyin);
    yylex_destroy();
    if (status != 0 || lexical_error)
        return 1;
    puts("Syntax accepted.");
    return 0;
}
