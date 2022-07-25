#include <stdio.h>
#include <string.h>
#include "semantic.h"
#include "symbol.h"
#define POSMAX 127

char* simbolos[128];            //En este array se guardaran los nombres de los simbolos utilizados
int posSiguienteLibre=0;


                        //Simbolo a agregar
void agregarSimbolo(char* simbolo){
    if ( posSiguienteLibre > POSMAX ) {
        printf("No hay lugar en la tabla de simbolos");
    }
    else {
        simbolos[posSiguienteLibre] = simbolo;
        posSiguienteLibre++;
    }
}

                    //Simbolo a buscar
int buscarSimbolo(char* simbolo){
    int i = 0; //contador

                //No es necesario que cuente mas alla de la prox posicion libre.
    while ( i < posSiguienteLibre ) {
        if ( !strcmp(simbolos[i], simbolo) ){ // strcmp retorna 0 si son iguales, por eso hay que usar !. Si comparamos directamente
            return 1;                         // simbolos[i] == simbolo no sirve.
        }
        i++;
    }

    return 0;
}