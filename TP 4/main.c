#include <stdio.h>
#include "parser.h"

int main(void)
{
	extern int lexerrors;	// errores lexicos     (flex)
	extern int yynerrs; 	// errores sintacticos (bison)

	switch (yyparse())
	{
	case 0:
		printf("Compilación termino exitosamente");
		break;
	case 1:
		printf("Errores de compilación.");
		break;
	case 2:
		printf("No hay memoria suficiente");
		break;
	}
	printf("\nErrores sintácticos:  %d - Errores lexicos:  %d\n", yynerrs, lexerrors);
	return 0;
}