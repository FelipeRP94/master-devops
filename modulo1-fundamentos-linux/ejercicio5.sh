#!/bin/bash

readonly URL=$1
readonly FILENAME="url_content.html"
readonly WORD=$2

if (( $# != 2 ))
then
        echo "Se necesitan únicamente dos parámetros para ejecutar este script"
        exit 1
fi

curl -so "$FILENAME" "$URL"

num_coincidences=$(grep -cw "$WORD" "$FILENAME")
first_line=$(grep -nwm 1 "$WORD" "$FILENAME" | cut -d: -f1)

if (( $num_coincidences == 0 ))
then
        echo "No se ha encontrado la palabra \""$WORD"\""
        exit 0
fi

if (( $num_coincidences == 1 ))
then
        echo "La palabra \""$WORD"\" aparece 1 vez"
        echo "Aparece únicamente en la línea "$first_line""
else
        echo "La palabra \""$WORD"\" aparece "$num_coincidences" veces"
        echo "Aparece por primera vez en la línea "$first_line""
fi