    #include "tokens.h"

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

comentario \/\/.*\n
comentariomultilinea "/*".*"*/"
espacio [[:space:]]
cadenainvalida [a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+
identificadorinvalido [a-zA-Z][a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+
constanteinvalida [0-9][a-zA-Z0-9[:punct:]]{-}[(),+-/*%;/]+

%%

\+                          { return SUMA; }
"-"                         { return RESTA; }
\*                          { return MULTIPLICACION; }
"%"                         { return MODULO; }
"<<"                        { return ASIGNACION; }
"programa"                  { return PROGRAMA; }
"fin-programa"              { return FINPROGRAMA; }
"entero"                    { return ENTERO; }
"leer"                      { return LEER; }
"escribir"                  { return ESCRIBIR; }
[a-zA-Z][a-zA-Z0-9]*        { return IDENTIFICADOR; }
";"                         { return FINDELINEA; }
","                         { return SEPARADOR; }
[()]                        { return PARENTESIS; }
[0-9]+                      { return CONSTANTE; }

{comentario} //NECESITO IGNORAR: COMENTARIOS POR LINEA
{comentariomultilinea} //COMENTARIOS MULTILINEA
{espacio}+ //SALTOS DE LINEA, ESPACIOS Y TABULADORES
{constanteinvalida}         { printf("Error léxico: constante inválida \t lexema: %s \n", yytext); }
{identificadorinvalido}     { printf("Error léxico: identificador inválido \t lexema: %s \n", yytext); }
{cadenainvalida}            { printf("Error léxico: cadena inválida \t lexema: %s \n", yytext); }


%%