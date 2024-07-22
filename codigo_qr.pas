PROGRAM codigo_qr;
USES crt, SysUtils;

CONST
     pos_final_x = 4;

TYPE
    tabla_codigo_qr = array[1..21,1..21]of string;
    cadena_binaria = array[1..4]of string;
VAR
   tab_cod_qr: tabla_codigo_qr;
   cad_bin: cadena_binaria;

PROCEDURE inicializa_tabla_qr;
VAR
 f,j: integer;
 BEGIN
 FOR f:= 1 TO 21 DO
  BEGIN
   FOR j:= 1 TO 21 DO
    BEGIN
     tab_cod_qr[f,j]:= '0';
    END;
  END;
 END;

PROCEDURE rellena_tabla_qr;
VAR
 f,j: integer;
 BEGIN
  FOR f:= 1 TO 21 DO
   BEGIN
    FOR j:= 1 TO 21 DO
     BEGIN
     IF ((f = 1) OR ( f = 8)) AND ((j <= 8) OR ((j >= 14) AND (j <= 21))) THEN
       tab_cod_qr[f,j]:= ' '
     ELSE IF ((f >= 2) AND (f <= 7)) AND ( ((j = 1) OR (j = 8)) OR ((j = 14) OR (j = 21)) ) THEN
       tab_cod_qr[f,j]:= ' '
     ELSE IF ((f = 7) AND ((j >= 9) AND (j <= 13))) THEN
       tab_cod_qr[f,j]:= ' '
     ELSE IF ((f >= 9) AND (f <= 13)) AND (j = 7) THEN
       tab_cod_qr[f,j]:= ' '
     ELSE IF ((f = 14) OR (f = 21)) AND ((j <= 8)) THEN
       tab_cod_qr[f,j]:= ' '
     ELSE IF ((f >= 15) AND (f <= 20)) AND ((j = 1) OR (j = 8)) THEN
       tab_cod_qr[f,j]:= ' ';
    END;
   END
 END;

PROCEDURE muestra_tabla;
VAR
 f,j: integer;
 BEGIN
 FOR f:= 1 to 21 do
  begin
   for j:= 1 to 21 do
    begin
     write(tab_cod_qr[f,j]:1);
    end;
    writeln();
  end;
 readkey();
 END;

FUNCTION crear_legajo(): string;
VAR
 i: integer;
 digito,aux_1,aux_2,numero_entero_string: string;
 BEGIN
 writeln('>>> Ingrese numero de lejago <solamente cuatro digitos>: ');
 digito:= readkey;
 i:= 0;
 WHILE digito <> #13 DO
  BEGIN
  IF digito <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
   IF (whereX <= pos_final_x) THEN
   write(digito);
   i:= i + 1;
   cad_bin[i]:= digito;
   END
  ELSE
   BEGIN
   gotoxy(whereX - 1,whereY);
   write(' ',#8);
   cad_bin[i]:= ' ';
   IF (i >= 1) AND (i <= 4) THEN
    i:= i - 1
   ELSE
     i:= 0;
   END;
  digito:= readkey;
  END;
 numero_entero_string:= ' ';
 FOR i:= 1 TO 4 DO
  BEGIN
   IF numero_entero_string = ' ' THEN
    numero_entero_string:= cad_bin[i]
   ELSE
    BEGIN
    aux_1:= cad_bin[i];
    aux_2:= concat(numero_entero_string,aux_1);
    numero_entero_string:= aux_2;
    END;
  END;
  crear_legajo:= numero_entero_string;
 END;

FUNCTION cadena_a_binario(digito: string): string;
VAR
 f,potencia,numero_entero,exponente,resta: integer;
 cadena_digitos,aux,aux_2: string;
 BEGIN
 numero_entero:= StrToInt(digito);
 exponente:= 4;
 aux:= '0011';
 FOR f:= 1 TO 4 DO
  BEGIN
   exponente:= exponente - 1;
   potencia:= power(2,exponente);
   IF potencia <= numero_entero THEN
    BEGIN
      resta:= numero_entero - potencia;
      numero_entero:= resta;
      aux_2:= '1';
      cadena_digitos:= concat(aux,aux_2);
      aux:= cadena_digitos;
    END
   ELSE
    BEGIN
    aux_2:= '0';
    cadena_digitos:= concat(aux,aux_2);
    aux:= cadena_digitos;
    END;
  END;
  cadena_a_binario:= aux;
 END;

FUNCTION  asigna_digitos(cadena_reservada: string; contador_columna: integer): string;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO Length(cadena_reservada) DO
  BEGIN
   IF f = contador_columna THEN
    IF cadena_reservada[f] = '0' THEN
     asigna_digitos:= ' '
    ELSE
     asigna_digitos:= '|';

  END;
 END;

PROCEDURE cargar_digitos_en_la_tabla(cadena_completa: string; fila,fila_final: integer);
VAR
 cadena_reservada: string;
 f,j,final_columna,contador_columna,pos_fila: integer;
 BEGIN;
 cadena_reservada:= cadena_completa;
 final_columna:= 21;
 pos_fila:= 0;
 for f:= fila to fila_final do
  BEGIN
  If (pos_fila = 0) THEN
   BEGIN
   contador_columna:= pos_fila;
   FOR j:= final_columna DOWNTO  20 DO
    BEGIN
     contador_columna:= contador_columna + 1;
     tab_cod_qr[f,j]:= asigna_digitos(cadena_reservada,contador_columna);
     END;
     pos_fila:= pos_fila +  2;
    END
   ELSE
   IF (contador_columna >= 2) AND (contador_columna <= 8) THEN
   begin
   contador_columna:= pos_fila;
   FOR j:= final_columna DOWNTO  20 DO
    BEGIN
     begin
     contador_columna:= contador_columna + 1;
     tab_cod_qr[f,j]:= asigna_digitos(cadena_reservada,contador_columna);
     END;
     END;
     pos_fila:= pos_fila +  2;
      END;
   END;

  END;



PROCEDURE convertir_legajo_a_binario(legajo: string);
VAR
 digito,cadena_completa: string;
 D,D1,D2,D3,D4,f,long_legajo,fila_final: integer;
 BEGIN
 long_legajo:= Length(legajo);
 D:= 0;
 D1:= 21;
 D2:= 18;
 D4:= 14;
 FOR f:= 1 TO long_legajo DO
  BEGIN
  D:= D + 1;
  CASE D OF
       1:BEGIN
         D1:= D1 - 3;
         fila_final:= 21;
         writeln();
         WRITELN('este es la columna:',D1);
         digito:= legajo[f];
         cadena_completa:=cadena_a_binario(digito);
         WRITELN(cadena_completa);
         writeln(cadena_completa);
         cargar_digitos_en_la_tabla(cadena_completa,D1,fila_final);

         END;

       2:BEGIN
          D2:= D2 - 4;
          fila_final:= 17;
          digito:= legajo[f];
          cadena_completa:=cadena_a_binario(digito);
          cargar_digitos_en_la_tabla(cadena_completa,D2,fila_final);

         END;

       3:BEGIN
          D3:= D3 - 4;
          fila_final:= 13;
          digito:= legajo[f];
          cadena_completa:=cadena_a_binario(digito);
          cargar_digitos_en_la_tabla(cadena_completa,D3,fila_final);

         END;

       4:BEGIN
         digito:= legajo[f];
         cadena_completa:=cadena_a_binario(digito);
         END;



  END;
 END;
   muestra_tabla;
 END;

















PROCEDURE generar_codigo_qr;
VAR
 legajo: string;
 BEGIN
 legajo:= crear_legajo;
 convertir_legajo_a_binario(legajo);
 END;

PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 clrscr;
 writeln('1. Generar codigo QR');
 writeln('2. Salir');
 writeln();
 write('Seleccione opcion: ');
 readln(op);
 CASE op OF
      1:BEGIN
        clrscr;
        generar_codigo_qr;
        END;
 END;
 UNTIL (op = 2);
 END;

BEGIN
inicializa_tabla_qr;
rellena_tabla_qr;
muestra_tabla;
menu_principal;
END.
