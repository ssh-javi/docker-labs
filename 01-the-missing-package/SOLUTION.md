# 🛠️ Solución Explicada - Lab 01: El Paquete Perdido

Para resolver este incidente de producción, debías crear un `Dockerfile` que no solo empaquetara el código de Node.js, sino que además preparara el entorno del sistema operativo con las herramientas necesarias y asegurara la configuración por defecto mediante variables de entorno.

## 🧰 Una Posible Solución

Existen múltiples formas válidas de resolver este laboratorio.

La siguiente implementación cumple todos los criterios de éxito definidos para el desafío y representa una aproximación común en entornos productivos.:

```dockerfile
# 1. Usar la imagen oficial de Node.js basada en Alpine para optimizar el espacio
FROM node:20-alpine

# 2. Instalar la dependencia nativa del Sistema Operativo requerida por la aplicación
RUN apk add --no-cache graphicsmagick

# 3. Definir el directorio de trabajo donde vivirá la app dentro del contenedor
WORKDIR /app

# 4. Copiar los archivos de definición de dependencias primero para aprovechar la caché de capas
COPY src/package*.json ./

# 5. Instalar las dependencias de Node.js (en este caso, Express)
RUN npm install

# 6. Copiar el resto del código fuente del proyecto
COPY src/ ./src

# 7. Configurar la variable de entorno por defecto solicitada para evitar que la app crashee
ENV DB_HOST=localhost
ENV PORT=3000

# 8. Documentar el puerto en el que escucha el servicio
EXPOSE 3000

# 9. Definir el comando de arranque de la aplicación usando el formato ejecutable (Exec Form)
CMD ["node", "src/app.js"]
```

## 🧠 Explicación Técnica (El Porqué)

1. **`RUN apk add --no-cache graphicsmagick`**: Este era el núcleo del problema. El código de la aplicación utiliza el módulo nativo de Node.js `child_process` para invocar directamente el comando `gm -version` en la terminal del sistema operativo. Si el contenedor se inicializa en un entorno limpio sin esta herramienta instalada, el sistema arroja un error y Node responde con un código de estado 500. Usar `--no-cache` evita guardar los archivos temporales del instalador de Alpine, manteniendo la imagen lo más ligera posible.
2. **Estrategia de Copiado y Caché (`package.json`)**: Al separar la instrucción `COPY src/package*.json ./` del resto del código, Docker es capaz de cachear la capa del `RUN npm install`. Si el desarrollador modifica una línea de código en `src/app.js`, Docker no volverá a descargar e instalar los paquetes de Node desde internet; saltará directo al copiado del código, reduciendo el tiempo de compilación de minutos a milisegundos.
3. **`ENV DB_HOST=localhost`**: La aplicación cuenta con una validación estricta que aborta el proceso (`process.exit(1)`) si la variable `DB_HOST` no está definida en el entorno. Al declarar un valor por defecto mediante `ENV` dentro del Dockerfile, nos aseguramos de que el contenedor siempre pueda iniciar de forma segura, permitiendo al administrador sobreescribirla en el comando `docker run` si lo requiere.
4. **Formato Ejecutable en `CMD`**: Se prefiere el formato `["node", "src/app.js"]` (Exec form) sobre `node src/app.js` (Shell form) porque arranca el proceso de Node.js directamente como el Process ID 1 (PID 1) dentro del contenedor. Esto es una buena práctica de producción clave para que el contenedor pueda recibir correctamente señales de apagado del sistema operativo (un concepto que profundizaremos en el Lab 06).

---

## 🔬 Comandos para Desplegar y Validar

Para comprobar que todo funciona de punta a punta, puedes ejecutar en tu terminal:

```bash
# Construir la imagen local
docker build -t microservicio-imagenes:1.0 .

# Ejecutar el contenedor asignando el nombre correcto para el validador
docker run -d -p 3000:3000 --name contenedor-imagenes microservicio-imagenes:1.0

# Correr el validador automático del laboratorio
./validate.sh
```

---

## 🚀 Mejoras para Producción

Esta solución cumple los requisitos del laboratorio.

En un entorno real podrías mejorarla aún más:

- Ejecutar la aplicación con un usuario no root.
- Utilizar npm ci en lugar de npm install.
- Añadir un HEALTHCHECK.
- Implementar un proceso de escaneo de vulnerabilidades.
- Utilizar imágenes distroless.

---

## 🎓 Qué Aprendiste

Al completar este laboratorio practicaste:

- Creación de imágenes Docker personalizadas.
- Instalación de dependencias del sistema operativo.
- Variables de entorno.
- Optimización básica de capas.
- Caché de builds.
- Buenas prácticas para comandos de arranque.

Estos conceptos aparecen frecuentemente en aplicaciones reales que deben migrarse a contenedores.