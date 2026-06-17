# Proceso de impresión de los pdf de albaranes

## Generar pdf's de albaranes
Desde apartado ordenes de carga en la app web al generar se los albaranes se crean los informes Pdf's.
Son jasper y despues de generarse se guardan en la carpeta /tmp del servidor.

## Demonio quimeraps
Este demonio sirve una vez que se han creado fisicamente los pdf's que se comprueban que exisaten y se envia en la impresora.
La impresora esta configurada en el fichero 'quimera_ps.db' que se encuentra en la carpeta /opt/quimeraPS

## Varios comandos para revisión / diagnostico del demonio
 
###  Estado del demonio
systemctl status quimeraps
journalctl -u quimeraps -n 50

### Ver si CUPS reconoce la impresora
lpstat -p

### Logs para ver que pasa cuando llega un PDF
sudo journalctl -u quimeraps -n 100 --no-pager

### Ver impresoras disponibles en CUPS
lpstat -p

### Ver si hay trabajos pendientes o fallidos
lpstat -W completed

### Ver todos los trabajos en cola
lpstat -o

### Ver trabajos en cola para impresora en concreto
lpq -P HP_LaserJet_Pro_MFP_M521dw_F31463_

###  Cancelar todos los trabajos de esa impresora
sudo cancel -a HP_LaserJet_Pro_MFP_M521dw_F31463_@NPIF31463.local

### O cancelar todos los trabajos de todas las impresoras
sudo cancel -a

### Ver configuración actual
cupsctl

### Reiniciar CUPS
sudo systemctl restart cups


