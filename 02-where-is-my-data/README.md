# Lab 02: ¿Dónde están mis datos? (Where is my Data?) 🟢

## 🏢 Contexto de Negocio
El microservicio de analíticas de "PicShare" se encarga de auditar cuántas veces se visualiza cada publicación de los usuarios. Como es un servicio interno y ligero, el equipo de desarrollo decidió utilizar una base de datos embebida **SQLite**, la cual almacena toda la información en un archivo llamado `prod.db` dentro de la carpeta `/app/data/`.

## 🚨 El Desastre
Ayer por la noche se lanzó un parche de seguridad para la aplicación. El administrador de sistemas detuvo el contenedor viejo, borró la imagen e inició un contenedor nuevo con la última versión del código. Diez minutos después, el Director de Producto llamó asustado: **"¡Perdimos todo el historial de métricas del último mes, el contador volvió a cero!"**.

Tu misión como Ingeniero DevOps es configurar la infraestructura de Docker para que los datos sobrevivan a cualquier reinicio, actualización o destrucción del contenedor.



## 🎯 Tu Misión
Para este laboratorio, **nosotros ya te proveemos el `Dockerfile` básico funcional** (está en la raíz de esta carpeta). Tu trabajo no es modificar el código ni el Dockerfile, sino **descubrir cómo correr el contenedor de forma correcta** usando los mecanismos de almacenamiento de Docker.

### Requisitos Técnicos del Desafío:
1. El contenedor debe mapear el puerto `3000:3000`.
2. La aplicación escribe su base de datos específicamente en la ruta interna: `/app/data`.
3. Debes utilizar un **Named Volume** de Docker (llámalo `picshare-db-prod`) para persistir esa carpeta específica.
4. **La Prueba de Fuego:** Debes ser capaz de levantar el contenedor, simular visitas, **borrar el contenedor por completo**, volverlo a crear, y verificar que los datos sigan ahí intactos.

---

## ✅ Criterios de Éxito

Sabrás que salvaste los datos de la empresa si ejecutas el validador automático y pasa todas las pruebas:

1. Levanta tu contenedor aplicando tu solución de persistencia (asegúrate de nombrarlo `contenedor-metricas`):
   ```bash
   # Pista: añade los parámetros de volúmenes necesarios aquí
   docker run -d -p 3000:3000 --name contenedor-metricas TU_IMAGEN:TAG
   ```
2. Ejecuta el script de validación local:
   ```
   chmod +x validate.sh
   ./validate.sh
   ```
   El script simulará tráfico, destruirá tu contenedor en tu cara, creará uno nuevo y verificará si la base de datos mantuvo la memoria.

💡 ¿Atascado con la sintaxis de los volúmenes? Revisa las opciones -v o --mount en la documentación de Docker, o cámbiate a la rama solution.