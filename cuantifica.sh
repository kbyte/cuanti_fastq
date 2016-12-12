#!/bin/bash

# Este pequeño script se basa en el pipeline: echo `wc -l mi_archivo.fastq | cut -f1 -d' '` / 4 | bc
# Que cuantifica el numero de lecturas del un archivo tipo fastq o fastq.gz.
# 
# Para fines demostrativos se utilizaron la mayoria de los comandos basicos vistos en el curso pasado
# A excepcion de awk, que es un topico mas complejo.
#
# Espero que sea de utilidad.
#

# Inicia el script

archivo=$1

if test -e $archivo
 then
  ext=`echo $archivo | awk -F \. '{print $NF}'`
  echo " "
  echo "Iniciando proceso de cuantificación..."
  echo " "
 else
  echo " "
  echo "El script no puede ser ejecutado debido a que el archivo es inexistente. Verifica la siguiente información:"
  echo " "
  echo "- uso: cuantifica.sh <nombre_archivo.fastq> o <nombre_archivo.fastq.gz>"
  echo " "
  echo "Intentelo de nuevo."
  echo " "
  exit 0
fi

if test -z $archivo
 then
  echo "El script no puede ser ejecutado. Verifica la siguiente información:"
  echo " "
  echo "- uso: cuantifica.sh <nombre_archivo.fastq> o <nombre_archivo.fastq.gz>"
  echo " "
  echo "Intentelo de nuevo."
  echo " "
  exit 0
fi

if [ $ext = "gz" ]
 then
  echo "El archivo a cuantificar es un archivo comprimido gz"
  lineas=$(zcat $archivo | echo $((`wc -l`/4)))
  echo " "
  echo "El archivo: $archivo presenta un total de $lineas lecturas."
  echo " "
  exit 0
fi

if [ $ext != "fastq" ]
then
  echo $lineas
  echo "El script no puede ser ejecutado. Verifica la siguiente información:"
  echo " "
  echo "- uso: cuantifica.sh <nombre_archivo.fastq> o <nombre_archivo.fastq.gz>"
  echo " "
  echo "Intentelo de nuevo."
  echo " "
  exit 0
fi

if [ $ext = "fastq" ]
 then
  lineas=$(echo `wc -l $archivo | cut -f1 -d ' '` / 4 | bc)
  echo " "
  echo "El archivo: $archivo presenta un total de $lineas lecturas."
  echo " "
  exit 0
fi

# termina el script
# Developed by Pedro Sánchez -  @kbyte
