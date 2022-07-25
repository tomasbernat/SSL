%code top{
    #include <stdio.h>
    #include "scanner.h"
    #include "semantic.h"
    #include "symbol.h"
}

%code provides {
    void yyerror (const char *);
    extern int lexerrors;           //Contador de errores lexicos
    extern int errSemantic;
}


// DEFINICIONES BISON
%defines "parser.h"                 //Header gnerado por parser.y
%output "parser.c"                  //Fuente generado por parser.y
%start inicioprograma               //No terminal inicial
%define parse.error verbose         //Sirve para que los errores salgan con mayor info
%define api.value.type {char * }     //REGISTRO SEMANTICO



%token ASIGNACION PROGRAMA FINPROGRAMA ENTERO LEER ESCRIBIR IDENTIFICADOR CONSTANTE

%right  '+' '-'              // OPERADOR CON MENOR PRECEDENCIA
%right  '/' '*' '%'
%precedence NEG             // OPERADOR CON MAYOR PRECEDENCIA

// REGLAS GRAMATICALES (LA BNF)
%%
                                                                                        //Si uno de los tres es != 0 entonces encontro un error, por lo tanto devuelve 1.
inicioprograma          : encabezadoPrograma listaSentencias finPrograma                { if ( yynerrs | lexerrors | errSemantic ) YYABORT; else YYACCEPT; }

encabezadoPrograma      : PROGRAMA IDENTIFICADOR                                        { comenzarPrograma($2); }

finPrograma             : FINPROGRAMA                                                   { finalizarPrograma(); }

listaSentencias         : listaSentencias sentencia
                        | sentencia
                        ;
sentencia               : ENTERO IDENTIFICADOR ';'                                      { if(declaracion($2,4)) YYERROR;}	
                        | LEER '(' identificadores ')' ';'                              // 
                        | ESCRIBIR '(' expresiones ')' ';'                              //
                        | IDENTIFICADOR ASIGNACION expresion ';'                        { asignacion( $3, $1 ); }
                        | error ';'         //Esto indica que puede haber una sentencia que sea un error
                        ; 

identificadores         : identificadores ',' identificador                             { lectura($3); }
                        | identificador                                                 { lectura($1); }


identificador           : IDENTIFICADOR                                                 { if( validarIdentificador($1) ) YYERROR; }
                        ;

expresiones             : expresiones ',' expresion                                     {escritura($3);}
                        | expresion                                                     {escritura($1);}
                        ;
expresion               : expresion '+' expresion                                       { $$ = generarInfijo( $1, '+', $3 ); } // Precedencia y asociatividad de + y - indicada arriba
                        | expresion '-' expresion                                       { $$ = generarInfijo( $1, '-', $3 ); }
                        | expresion '/' expresion                                       { $$ = generarInfijo( $1, '/', $3 ); }
                        | expresion '*' expresion                                       { $$ = generarInfijo( $1, '*', $3 ); } // Precedencia y asociatividad de %, * y / indicada arriba
                        | expresion '%' expresion                                       { $$ = generarInfijo( $1, '%', $3 ); }
                        | '-' expresion %prec NEG                                       { $$ = generarPrefijo( $2 ); } //%prec NEG indica que la precedencia de esta produccion es la indicada en las definiciones
                        | '(' expresion ')'                                             { $$ = $2; }
                        | identificador
                        | CONSTANTE
                        ;
%%

// EPILOGO
void yyerror (const char* mensajeError) {
    printf("error en la linea %d: %s \n", yylineno, mensajeError);
}