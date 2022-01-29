#include <stdio.h>
#include <ctype.h>
#include "scanner.h"

int GET_TOKEN(char buffer[]){
    char c;
    int j = 0;

    while((c = getchar()) != EOF){
        if(isspace(c)){
            if(j != 0){
                return CADENA;          //no pongo ungetc porque si es un espacio no me importa leerlo mas tarde
            }
        }
        else if (c == ','){
            if(j != 0){
                ungetc(c, stdin);       //Si ya viene scanneando una cadena, entra aca y devuelve cadena.
                return CADENA;
            }

            buffer[0] = c;              //Si no viene scanneando una cadena entonces pone a c (que es una coma) en el buffer y retorna SEPARADOR
            buffer[1] = '\0';
            return SEPARADOR;
        }
        else{
            buffer[j] = c;              //Si es un caracter entonces lo agrega al buffer
            j++;
        }
    }

    if (j != 0) return CADENA;
    return FDT;
}
