#include <stdio.h>
#include <ctype.h>
#include "scanner.h"

int main(){
    char buffer[128];
    int token;
    int i = 0;

    while( (token = GET_TOKEN(buffer)) != FDT){
        
        if(token == CADENA)
        {
            printf("Cadena: ");
            while(buffer[i] != '\0')
            {
                printf("%c", buffer[i]);
                buffer[i] = '\0';
                i++;
            }

            printf("\n");
        }
        else if(token == SEPARADOR)
        {
            printf("Separador: ");
            while(buffer[i] != '\0')
            {
                printf("%c", buffer[i]);
                buffer[i] = '\0';
                i++;
            }

            printf("\n");
        }

        i = 0;
    }
    printf("Fin de texto.\n");

    return 0;
}
