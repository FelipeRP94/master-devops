#!/bin/bash

readonly URL="https://lemoncode.net/"
readonly FILENAME="url_content.html"

curl -so "$FILENAME" "$URL"

num_coincidences=$(grep -cw "$1" "$FILENAME")
first_line=$(grep -nwm 1 "$1" "$FILENAME" | cut -d: -f1)

if (( $num_coincidences == 0 ))
then
        echo "No se ha encontrado la palabra \""$1"\""
else
        echo "La palabra \""$1"\" aparece "$num_coincidences" veces"
        echo "Aparece por primera vez en la línea "$first_line""
fi