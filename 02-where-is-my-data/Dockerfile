FROM node:20-alpine

WORKDIR /app

# Copiar archivos de dependencias e instalar
COPY src/package*.json ./
RUN npm install

# Copiar el resto del código fuente de la app
COPY src/ ./src

# Exponer el puerto donde escucha Express
EXPOSE 3000

# Comando para iniciar el microservicio de métricas
CMD ["node", "src/app.js"]