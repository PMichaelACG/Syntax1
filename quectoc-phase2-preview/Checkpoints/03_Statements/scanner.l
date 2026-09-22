%option noyywrap noinput nounput yylineno never-interactive nodefault
%{
#include <stdio.h>
#include "parser.tab.h"
/* A lexical error must prevent an overall success message. */
int lexical_error = 0;
%}
%%
"let"                   { return KW_LET; }
"int"                   { return KW_INT; }
"print"                 { return KW_PRINT; }
[A-Za-z_][A-Za-z0-9_]*   { return IDENTIFIER; }
[0-9]+                  { return INT_LITERAL; }
"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
";"                     { return SEMICOLON; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"//"[^\n]*              { /* Skip a line comment, even at EOF. */ }
[ \t\r\n]+              { /* Keep scanning across newlines. */ }
<<EOF>>                 { return 0; }
. {
    fprintf(stderr, "Lexical error at line %d: unexpected '%s'.\n",
            yylineno, yytext);
    lexical_error = 1;
    return LEX_ERROR;
}
%%
