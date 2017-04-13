#!/bin/bash

clear

echo "RESOLUCIÓN DE NOMBRES EN MÁQUINAS LINUX\n*****************************************"
echo "Este script modificará el fichero /etc/nsswitch.conf para que puedas resolver nombres de dominio desde Linux sin historias."
echo "Además limpiará el fichero /etc/hosts de todos los hostnames añadidos a mano, para evitar futuros problemas."
echo "De ahora en adelante, accede a las máquinas (Escritorio remoto, SSH, etc) mediante su nombre de host, no con su IP.\n"


cd /etc/
echo "*****************************************"
echo "Creando copia de seguridad de los ficheros..."
sudo cp nsswitch.conf nsswitch.confOLD
sudo cp hosts hostsOLD
echo "Modificando ficheros..."
#Opción1
sudo sed -i 's/hosts:[ ]*files mdns4_minimal \[NOTFOUND=return\] dns mdns4/hosts:          files dns/' nsswitch.conf
#Opción2
sudo sed -i 's/hosts:[ ]*files mdns4_minimal \[NOTFOUND=return\] dns/hosts:          files dns/' nsswitch.conf
#Hosts
sudo sed -i '/10.140.18/d' hosts
cd

echo "Reiniciando servicio de red..."
sudo service networking restart


echo "Fichero modificados. Tarea completa."
echo "*****************************************"
echo "\nSi tienes algún problema--> sistemas@hggm.es\n\n"
