// CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA
// 
// GRUPO 12
// Christian Prudencio -  Legajo 1649474
// Bernat Lavalle Tomas - Legajo 1731348
// 
// CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA CARATULA

#include <stdio.h>
#include "parser.h"

int main(void) {
    extern int lexerrors;	// errores lexicos     (flex)
	extern int yynerrs; 	// errores sintacticos (bison)
    extern int errSemantic; // errores semanticos (semantic)

    switch( yyparse() ) {
        case 0:
            printf("Compilacion termino con exito\n");
            break;
        case 1:
            printf("Errores de compilacion \n");
            break;
        case 2:
            printf("Memoria insuficiente :( \n");
            break;
    }

    printf("Errores hallados: \n");
    printf("Lexicos: %d \nSintacticos: %d \nSemanticos: %d", yynerrs, lexerrors, errSemantic);
    return 0;
}