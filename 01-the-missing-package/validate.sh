#!/bin/bash

echo "🧐 Validando laboratorio 01..."

# 1. Verificar si el contenedor está corriendo
if [ ! "$(docker ps -q -f name=contenedor-imagenes)" ]; then
    echo "❌ ERROR: El contenedor con nombre 'contenedor-imagenes' no está corriendo."
    echo "Asegúrate de haberlo ejecutado con: docker run -d -p 3000:3000 --name contenedor-imagenes ..."
    exit 1
fi

# 2. Hacer una petición HTTP al contenedor y guardar la respuesta
RESPONSE=$(curl -s http://localhost:3000)

# 3. Validar si la respuesta contiene el mensaje de éxito
if [[ "$RESPONSE" == *"¡Aplicación dockerizada con éxito!"* ]]; then
    echo "🎉 ¡FELICITACIONES! El laboratorio 01 ha sido superado con éxito."
    echo "Mensaje del servidor: $RESPONSE"
    exit 0
else
    echo "❌ ERROR: El contenedor respondió, pero hay un problema interno."
    echo "Respuesta obtenida: $RESPONSE"
    echo "Revisa si instalaste 'graphicsmagick' en el Dockerfile o si la variable 'DB_HOST' está vacía."
    exit 1
fi