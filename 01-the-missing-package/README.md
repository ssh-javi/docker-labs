# Lab 01: El Paquete Perdido (The Missing Package) 🟢

## 🏢 Contexto de Negocio
Trabajas en "PicShare", una startup de redes sociales para fotógrafos. El equipo de desarrollo creó un microservicio en Node.js que se encarga de procesar y redimensionar las imágenes que suben los usuarios. Localmente les funciona de maravilla porque todos instalaron las herramientas necesarias en sus Mac/Windows hace meses, pero al intentar subirlo al servidor de pruebas, la aplicación se rompe inmediatamente.

## 🚨 El Desastre
Te han asignado el ticket de soporte técnico #404. El desarrollador te dice: *"Ayer intenté correr la app en el servidor pelado y da error de comandos no encontrados, y además dice que falta una configuración de Base de Datos. En mi laptop sí corre"*. 

Tu objetivo es empaquetar esta aplicación en un contenedor de Docker para asegurar que corra exactamente igual en cualquier parte.

## 🎯 Tu Misión
Debes crear un archivo llamado `Dockerfile` en la raíz de esta carpeta (`01-the-missing-package/`) que cumpla con los siguientes requisitos técnicos del negocio:

1. **Imagen Base:** Usa una imagen oficial de Node.js (versión `20-alpine` recomendada por peso, aunque puedes usar la estándar si lo prefieres).
2. **Dependencia del Sistema Operativo:** El código de la aplicación ejecuta un comando nativo del sistema que requiere que el sistema operativo tenga instalado el paquete **`graphicsmagick`**. Debes asegurarte de instalarlo durante la construcción de la imagen (Tip: si usas Alpine, el gestor de paquetes es `apk`).
3. **Directorio de Trabajo:** La app debe vivir en `/app` dentro del contenedor.
4. **Archivos:** Copia el `package.json` primero, instala las dependencias de Node (`npm install`), y luego copia el resto del código fuente (`src/`).
5. **Entorno:** La aplicación espera recibir de forma obligatoria una variable de entorno llamada `DB_HOST`. Configura un valor por defecto (ej. `localhost`) en el Dockerfile para que no crashee si el usuario olvida pasarla.
6. **Puerto:** La app expone el puerto `3000`.
7. **Arranque:** Ejecuta la app usando el comando adecuado para iniciar Node.js apuntando a `src/app.js`.

---

## ✅ Criterios de Éxito

Sabrás que resolviste el problema de la empresa si logras ejecutar estos comandos en tu terminal sin errores:

1. **Construir la imagen:**
   ```bash
   docker build -t microservicio-imagenes:1.0 .
   ```
2. **Correr el contenedor:**
   ```bash
   docker run -d -p 3000:3000 --name contenedor-imagenes microservicio-imagenes:1.0
   ```
3. **Validar el funcionamiento**
   Ejecuta el script de validación local:
   ```bash
   chmod +x validate.sh
   ./validate.sh
   ```
   O haz un curl http://localhost:3000. Deberías recibir un mensaje de éxito confirmando que graphicsmagick y DB_HOST están activos.

💡 ¿Atascado? Recordá que podes mirar la rama solution si queres comparar tu Dockerfile.