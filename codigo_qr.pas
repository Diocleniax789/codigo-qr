PROGRAM codigo_qr;
USES crt;

TYPE
    tabla_codigo_qr = array [1..21,1..21]of string;

VAR
   tab_cod_qr: tabla_codigo_qr;

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
 delay(90000);

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
{ CASE op OF
      1:BEGIN
        clrscr;
        generar_codigo_qr;
        END;
 END;               }
 UNTIL (op = 2);
 END;

BEGIN
inicializa_tabla_qr;
rellena_tabla_qr;
muestra_tabla;
menu_principal;
END.
