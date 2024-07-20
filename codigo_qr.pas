PROGRAM codigo_qr;
USES crt;

TYPE
    tabla_codigo_qr = array [1..21,1..21]of string;

VAR
   tab_cod_qr: tabla_codigo_qr;



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
menu_principal;
END.
