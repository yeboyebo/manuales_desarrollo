# Configurar la impresion de etiquetas de agencias de transporte

## 1. Informar impresoras en configuración local.

En Area Facturación -> Principal -> Empresa

Cada agencia de transporte tiene una pestaña propia, En la cual hay que informar el nombre de la impresora y los diferentes campos como la aplicación que se usa para imprimir en caso de que sea necesario(PDF, printer.exe, etc)...

Para DHL el caso especial es que hay que conectar la impresora al puerto LPT1. Esto se hace mediante el siguiente comando en cmd.exe

```
net use LPT1: printerName /persistent:yes;
```
Donde printerName es el nombre de la impresora precedido del nombre del equipo donde nos encontramos. Ejemplo: //Javiermendez1/DHL

