#!/bin/bash

echo "🧐 Validando laboratorio 02: Persistencia de Datos..."

# 1. Verificar que el contenedor inicial exista
if [ ! "$(docker ps -q -f name=contenedor-metricas)" ]; then
    echo "❌ ERROR: El contenedor 'contenedor-metricas' no está corriendo."
    exit 1
fi

IMAGE_NAME=$(docker inspect --format='{{.Config.Image}}' contenedor-metricas)

echo "🚀 Paso 1: Generando visitas iniciales en la app..."
curl -s http://localhost:3000 > /dev/null
curl -s http://localhost:3000 > /dev/null
FIRST_CHECK=$(curl -s http://localhost:3000)

echo "💥 Paso 2: SIMULANDO DESASTRE. Destruyendo el contenedor activo..."
docker rm -f contenedor-metricas > /dev/null

echo "🔄 Paso 3: Intentando recuperar los datos creando un contenedor nuevo..."
# Recreamos el contenedor usando exactamente las mismas configuraciones que usó el usuario
# (Docker inspect nos permite clonar los binds/mounts que ellos declararon)
VOLUME_CHECK=$(docker volume ls -q --filter name=picshare-db-prod)

if [ -z "$VOLUME_CHECK" ]; then
    echo "❌ ERROR: No se encontró ningún Named Volume llamado 'picshare-db-prod'."
    exit 1
fi

# Levantamos el contenedor de reemplazo enganchando el volumen
docker run -d -p 3000:3000 --name contenedor-metricas -v picshare-db-prod:/app/data "$IMAGE_NAME" > /dev/null

# Esperar un segundo a que inicialice SQLite
sleep 1

echo "🔍 Paso 4: Validando estado de la Base de Datos..."
FINAL_CHECK=$(curl -s http://localhost:3000)

if [[ "$FINAL_CHECK" == *"Visitas registradas en la Base de Datos: 4"* ]]; then
    echo "🎉 ¡ESPECTACULAR! El laboratorio 02 ha sido superado."
    echo "Los datos sobrevivieron a la destrucción del contenedor gracias al volumen."
    echo "Resultado final del servidor: $FINAL_CHECK"
    exit 0
else
    echo "❌ ERROR CATASTRÓFICO: Los datos se perdieron."
    echo "Antes del desastre tenías 3 visitas. Ahora el nuevo contenedor dice:"
    echo "-> $FINAL_CHECK"
    echo "Asegúrate de estar mapeando el volumen a la ruta interna correcta (/app/data)."
    # Limpieza por si falló
    docker rm -f contenedor-metricas > /dev/null
    exit 1
fi