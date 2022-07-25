#include <stdio.h>
#include "scanner.h"
#include "tokens.h"

int main(){
    int token = yylex();

    do
    {
        switch (token) 
        {
            case SUMA:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case RESTA:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case MULTIPLICACION:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case MODULO:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case ASIGNACION:
                printf("Token: Asignación \n");
                break;
            case PROGRAMA:
                printf("Token: Programa \n");
                break;
            case FINPROGRAMA:
                printf("Token: Fin-programa \n");
                break;
            case ENTERO:
                printf("Token: entero \n");
                break;
            case LEER:
                printf("Token: leer \n");
                break;
            case ESCRIBIR:
                printf("Token: escribir \n");
                break;
            case IDENTIFICADOR:
                printf("Token: identificador \t Lexema: %s \n", yytext);
                break;
            case FINDELINEA:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case SEPARADOR:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case PARENTESIS:
                printf("Token: '%c' \n", yytext[0]);
                break;
            case CONSTANTE:
                printf("Token: constante \t Lexema: %s \n", yytext);
                break;
            
        }

        token = yylex();
    } while (token != FDT);

    printf("Token: Fin de archivo \n"); //entra si o si cuando termina el archivo

    return 0;
}