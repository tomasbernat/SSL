#include <stdio.h>
#include <string.h>
#include "semantic.h"
#include "symbol.h"
#include "parser.h"

int errSemantic = 0;
char mensajeError[128];
char nuevaVariableTemporal[64];
int proxTemporal = 1;


int declaracion(char* identificador, int cantBytes){
    if ( buscarSimbolo(identificador) ) 
    {
        sprintf(mensajeError, "identificador %s ya declarado", identificador);
		errSemantic++;
        yyerror(mensajeError);
        return 1;
    }

    agregarSimbolo(identificador);
    printf("reserve %s, %d\n", identificador, cantBytes);
    return 0;
}

int validarIdentificador(char* identificador){
    if( !buscarSimbolo(identificador) ){
        sprintf(mensajeError, "identificador no declarado: %s", identificador);
        errSemantic++;
        yyerror(mensajeError);
        return 1;
    }
    
    return 0;
}

void comenzarPrograma( char* nombrePrograma ){
	printf("Load rtlib, %s, \n", nombrePrograma );
}

void lectura(char* identificador){
	printf("Read %s, Integer\n", identificador);
}

void asignacion(char* expresion, char* identificador){
    printf("Store %s, %s \n", expresion, identificador);
}

void escritura(char* identificador){
	printf("Write %s, Integer\n", identificador);
}

char* generarInfijo( char* input1 , char operador, char* input2 ){
    char* temporalNuevo = generarNuevoTemporal();
    declaracion(temporalNuevo, 4);

    switch(operador){
		case '+':
			printf("ADD %s,%s,%s\n", input1, input2, temporalNuevo);
			break;
		case '*':
			printf("MUL %s,%s,%s\n", input1, input2, temporalNuevo);
			break;
		case '-':
			printf("SUB %s,%s,%s\n", input1, input2, temporalNuevo);
			break;
		case '/':
			printf("DIV %s,%s,%s\n", input1, input2, temporalNuevo);
			break;
        case '%':
            printf("MOD %s,%s,%s\n", input1, input2, temporalNuevo);
			break;
	}
	return temporalNuevo;
}

char* generarPrefijo(char* input){
    char* temporalNuevo = generarNuevoTemporal();
    declaracion(temporalNuevo, 4);
    printf("INV %s,,%s\n", input, temporalNuevo);

    return temporalNuevo;
}

char* generarNuevoTemporal(void){
    sprintf(nuevaVariableTemporal, "Temp@%d", proxTemporal);
    proxTemporal++;

    return strdup(nuevaVariableTemporal);
    // Para retornar un puntero a char utilizamos strdup, que retorna un puntero a char con el mismo valor que la
    // variable nuevaVariableTemporal
}

void finalizarPrograma(void){
	printf("Exit,\n");
}