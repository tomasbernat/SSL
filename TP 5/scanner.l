    #include <stdio.h>
    #include "parser.h"
    int lexerrors = 0;

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option yylineno

comentario \/\/.*\n
comentariomultilinea "/*".*"*/"
espacio [[:space:]]
cadenainvalida [a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+
identificadorinvalido [a-zA-Z][a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+
constanteinvalida [0-9][a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+

%%

\+                                    return '+';
"-"                                   return '-';
\*                                    return '*';
"%"                                   return '%';
"/"                                   return '/';
"<<"                                  return ASIGNACION; 
"programa"                            return PROGRAMA; 
"fin-programa"                        return FINPROGRAMA; 
"entero"                              return ENTERO; 
"leer"                                return LEER; 
"escribir"                            return ESCRIBIR; 
[a-zA-Z][a-zA-Z0-9]*                { yylval = strdup(yytext); return IDENTIFICADOR; }
[0-9]+                              { yylval = strdup(yytext); return CONSTANTE; }
";"                                   return ';';
","                                   return ',';
"("                                   return '(';
")"                                   return ')';


{comentario}                            //NECESITO IGNORAR: COMENTARIOS POR LINEA
{comentariomultilinea}                  //COMENTARIOS MULTILINEA
{espacio}+                              //SALTOS DE LINEA, ESPACIOS Y TABULADORES
{constanteinvalida}                     { lexerrors++; printf("error en la linea %d: constante invalida \t lexema: %s \n", yylineno, yytext); }
{identificadorinvalido}                 { lexerrors++; printf("error en la linea %d: identificador invalido \t lexema: %s \n", yylineno, yytext); }
{cadenainvalida}                        { lexerrors++; printf("error en la linea %d: cadena invalida \t lexema: %s \n", yylineno, yytext); }

%%