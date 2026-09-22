%require "3.6"
%{
int yylex(void);
void yyerror(const char *message);
%}
%define parse.error detailed
%define parse.lac full
%token KW_LET "let" KW_INT "int" KW_PRINT "print"
%token IDENTIFIER "identifier" INT_LITERAL "integer"
%token ASSIGN "=" PLUS "+" MINUS "-" SEMICOLON ";"
%token LPAREN "(" RPAREN ")" LEX_ERROR "invalid character"
%start program
%%
program:
    KW_LET IDENTIFIER ASSIGN INT_LITERAL SEMICOLON
;
%%
