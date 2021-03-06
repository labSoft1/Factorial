# potencia en esambaldor
 printf_num macro reg           ;nombre del macro "macro" y parametros
  mov ah,02h
  mov dl,reg
  add dl,30h                    ;hace el reajuste para mostrar en pantalla
  int 21h
 endm                           ;fin del macro
 printf_txt macro reg           ;nombre del macro "macro" y parametros
  lea dx,reg
  mov ah,9                     ;imprime textos en pantalla
  int 21h      
 endm                           ;fin del macro
 scanf macro reg reg2           ;nombre del macro "macro" y parametros
  mov reg,01h
  int 21h                       ;invoca al sistema de interrupciones
  sub al,30h                    ; realizo su ajuste
  mov reg2,al                   ; lo guardo en la parte alta del registro CX
 endm                           ;fin del macro
 .model small                   ;apunta al segmento ds dd del sistema
 .data                          ;define seccion data  
    portada  DB  01h,09h,'Arquitectura de computadores ',09h,01h   ;texto titulo
    input_dialog  DB  0dh,0ah,'ingresa un numeero en este formato 00 base seguido de 00 expo,..: $' ,0dh         ;texto de inputdata
 .code                          ;define la seccion de codigo         
   main proc 
     mov ax ,@data              ;mueve al registro como tipo data
     mov ds ,ax                 ;mueve el valor de  @data =0720h 
     printf_txt portada         ;llama a la macro y pasa como parametro el texto
     scanf ah ch                ;lee elprimer digito 
     scanf ah cl                ;lee el segundo digito
     mov ax,cx                  ;lo muevo al registro AX para hacer el ajuste 
     aad                        ;convierte los regsitros ah al en bcd desempaquetaado
     mov dh,al                  ;recuperamos el valor convertido y lo movemos a ch
     
     scanf ah ch                ;lee elprimer digito 
     scanf ah cl                ;lee el segundo digito
     mov ax,cx                  ;lo muevo al registro AX para hacer el ajuste 
     aad                        ;convierte los regsitros ah al en bcd desempaquetaado
     mov ch,al                  
     mov ah,00h
     mov al,dh
     mov dl,01h
    
fib:                            ;inicia el ciclo loop fact
    mul dh                      ; el valor de cx la paamos a bx para completar las operaciones de cambios para generar la secuencia
    inc dl                      ;incrementa el contador
    cmp ch,dl                   ;compara es el condiocional que rompe el ciclo
    je print                    ;si ch es igual a bl salta a print
    loop  fib                   ;loop que vuelve a fact     
print:                          ;etiqueta print
   mov dl,64h                   ;pasamos el valor de 100 en hexadecimal
   div dl                       ;divide al para dl en ah guarda el residuo y en al el resultado
   mov bh,ah                    ;pasa el residuo a bh
   mov cl,al                    ;mueve el resultadp de la divicion a cl
   mov ch,00h                   ;mueve el valor de 0 hexa,.. a low de cx
   mov ah,00h                   ;la misma operacion para el registro ax
   printf_num cl                ;imoprimer el resultado de la divicion
   mov bl,bh                    ;pasamos el valor de bx alto al bajo
   mov bh,00h                   ;limpiamos el registro para poder hacer el ajuste 
   mov ax,bx                    ;se mueve el valor del residua a ax
   aam                          ;convierte al en binario a ah y al
   mov bx,ax                    ;mueve el valor al registro bx para poder imprimirlo
   printf_num bh                ;imprime el segundo digiot
   printf_num bl                ;imprimer el tercer digito
.exit                           ;sale y toma el control el sistema      
   MAIN ENDP                    ;termina el programa

