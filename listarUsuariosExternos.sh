#!/bin/bash


if [ -z "$1" ] || [ -z "$2" ]; then

  echo -e '\nFuncionamiento-> ./listarUsuariosExternos.sh <nombreDeUsuario> <nombreFichero>\n'

else

  rutaHome=/home/$1/
  for i in *; do
     if grep -q -v '@beeva.com\|.sh' <<< "$i"; then
         echo -e '*********************************************************' >> $rutaHome$2
         echo $i >> $rutaHome$2
         cat $i >> $rutaHome$2
         echo -e '*********************************************************\n\n' >> $rutaHome$2
     fi
  done
  chown $1:$1 $rutaHome$2

fi
