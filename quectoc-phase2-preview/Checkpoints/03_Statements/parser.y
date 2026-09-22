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
    statements
;
statements:
    statement
  | statements statement
;
statement:
    KW_LET IDENTIFIER ASSIGN expression SEMICOLON
  | KW_PRINT LPAREN expression RPAREN SEMICOLON
;
expression:
    atom
  | expression PLUS atom
  | expression MINUS atom
;
atom:
    INT_LITERAL
  | IDENTIFIER
  | LPAREN expression RPAREN
;
%%
