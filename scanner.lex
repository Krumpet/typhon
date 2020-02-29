%{
#include <stdio.h>
#include <string.h>
#include "Node.hpp"
#include "hw3_output.hpp"
#include "parser.tab.hpp"
#include <cstdlib>

// Function declarations here

void error_undefined(){
    printf("line %d: lexical error\n", yylineno);
    std::exit(0);
}

%}

%option yylineno
%option noyywrap

/* Regex */

small_letter                    [a-z]
letter                          [a-zA-Z]
digit                           [0-9]
sign                            (\+)|(\-)
space                           [\n\t\r ]|(\r\n)
new_line                        (\r\n)|(\r)|(\n)

hexa_digit                      [A-Fa-f0-9]
back_slash                      \\
illegal_string                  \"([^\"\r\n])*[\r\n]?

number                          0|[1-9][0-9]*



/* Token definitions */

VOID            void
INT             int
BYTE            byte
B               b
BOOL            bool
ENUM            enum
AND             and
OR              or
NOT             not
TRUE            true
FALSE           false
RETURN          return
IF              if
ELSE            else
WHILE           while
BREAK           break
CONTINUE        continue
SC              ;
COMMA           \,
LPAREN          \(
RPAREN          \)
LBRACE          \{
RBRACE          \}
ASSIGN          =
RELOP           (<)|(>)|(<=)|(>=)
EQOP            (==)|(!=)
MULOP           \*
DIVOP           \/
PLUSOP          \+
MINUSOP         \-
COMMENT         \/\/[^\r\n]*[ \r|\n|\r\n]
ID              {letter}({letter}|{digit})*
NUM             0|[1-9][0-9]*
STRING          \"([^\n\r\"\\]|\\[rnt"\\])+\"


%%


{VOID}                      return VOID;
{INT}                       return INT;
{BYTE}                      return BYTE;
{B}                         return B;
{BOOL}                      return BOOL;
{ENUM}                      return ENUM;
{AND}                       return AND;
{OR}                        return OR;
{NOT}                       return NOT;
{TRUE}                      { yylval = new Nodes::True(yylineno); return TRUE; }
{FALSE}                     { yylval = new Nodes::False(yylineno); return FALSE; }
{RETURN}                    return RETURN;
{IF}                        return IF;
{ELSE}                      return ELSE;
{WHILE}                     return WHILE;
{BREAK}                     return BREAK;
{CONTINUE}                  return CONTINUE;
{SC}                        return SC;
{COMMA}                     return COMMA;
{LPAREN}                    return LPAREN;
{RPAREN}                    return RPAREN;
{LBRACE}                    return LBRACE;
{RBRACE}                    return RBRACE;
{ASSIGN}                    return ASSIGN;
{RELOP}                     { yylval = new Nodes::Symbol(yytext, yylineno); return RELOP; }
{EQOP}                      { yylval = new Nodes::Symbol(yytext, yylineno); return EQOP; }
{MULOP}                     return MULOP;
{DIVOP}                     return DIVOP;
{PLUSOP}                    return PLUSOP;
{MINUSOP}                   return MINUSOP;
{COMMENT}                   ;
{ID}                        { yylval = new Nodes::Identifier(yytext, yylineno); return ID; }
{NUM}                       { yylval = new Nodes::Num(stoi(yytext), yylineno); return NUM; }
{STRING}                    { yylval = new Nodes::String(yytext, yylineno); return STRING; }
{space}                     ;
.                           { output::errorLex(yylineno); std::exit(999); }


%%
