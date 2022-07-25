%code top{
    #include <stdio.h>
    #include "scanner.h"
}

%code provides {
    void yyerror (const char *);
    extern int lexerrors;           //Contador de errores
}


// DEFINICIONES BISON
%defines "parser.h"                 //Header gnerado por parser.y
%output "parser.c"                  //Fuente generado por parser.y
%start inicioprograma               //No terminal inicial
%define parse.error verbose         //Sirve para que los errores salgan con mayor info
%define api.value.type {char *}     //REGISTRO SEMANTICO


%token ASIGNACION PROGRAMA FINPROGRAMA ENTERO LEER ESCRIBIR IDENTIFICADOR CONSTANTE

%right  '+' '-'              // OPERADOR CON MENOR PRECEDENCIA
%right  '/' '*' '%'
%precedence NEG             // OPERADOR CON MAYOR PRECEDENCIA

// REGLAS GRAMATICALES (LA BNF)
%%
                                                                    //Si uno de los dos es != 0 entonces encontro un error, por lo tanto devuelve 1.
inicioprograma          : PROGRAMA identificadorPrograma listaSentencias FINPROGRAMA { if ( yynerrs | lexerrors ) YYABORT; else YYACCEPT; }
identificadorPrograma   : IDENTIFICADOR { printf("nombre del programa: %s\n", yylval); }
listaSentencias         : listaSentencias sentencia
                        | sentencia
                        ;
sentencia               : ENTERO IDENTIFICADOR ';' {printf("entero %s\n", yylval);}
                        | LEER '(' identificadores ')' ';' {printf("leer\n");}
                        | ESCRIBIR '(' expresiones ')' ';' {printf("escribir\n");}
                        | IDENTIFICADOR ASIGNACION expresion ';' {printf("asignacion\n");}
                        | error ';'         //Esto indica que puede haber una sentencia que sea un error
                        ; 
identificadores         : identificadores ',' IDENTIFICADOR
                        | IDENTIFICADOR
                        ;
expresiones             : expresiones ',' expresion
                        | expresion
                        ;
expresion               : expresion '+' expresion {printf("suma\n");} // Precedencia y asociatividad de + y - indicada arriba
                        | expresion '-' expresion {printf("resta\n");}
                        | expresion '/' expresion {printf("división\n");}
                        | expresion '*' expresion {printf("multiplicación\n");} // Precedencia y asociatividad de %, * y / indicada arriba
                        | expresion '%' expresion {printf("modulo\n");}
                        | '-' expresion %prec NEG {printf("inversion\n");} //%prec NEG indica que la precedencia de esta produccion es la indicada en las definiciones
                        | '(' expresion ')' {printf("parentesis\n");}
                        | IDENTIFICADOR
                        | CONSTANTE
                        ;
%%

// EPILOGO
void yyerror (const char *s) {
    printf("\berror en la linea %d: %s \n", yylineno, s);
}