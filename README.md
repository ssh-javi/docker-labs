# 🐳 Docker Labs: De Cero a Senior mediante Casos Reales de Empresa

[![GitHub Stars](https://img.shields.io/github/stars/ssh-javi/docker-labs?style=for-the-badge)](https://github.com/ssh-javi/docker-labs/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

La mayoría de los tutoriales de Docker te enseñan comandos aislados en entornos perfectos que no existen en la vida real. Cuando entras a trabajar a una empresa, te encuentras con imágenes de 2GB, contenedores que pierden datos, fugas de memoria que tiran servidores y fallos de seguridad críticos.

**Este repositorio es diferente.** Aquí no vas a seguir un tutorial paso a paso. Vas a asumir el rol de un **Ingeniero DevOps / Platform Engineer** y resolverás 8 incidentes reales basados en escenarios de producción de empresas reales.

---

## 🎯 La Filosofía: Aprender Rompiendo (Challenge-Based Learning)

Cada laboratorio está estructurado como un ticket de soporte o una misión de negocio:
1. **El Contexto de Negocio 🏢:** Qué hace la empresa y por qué es importante el sistema.
2. **El Desastre 🚨:** Qué se rompió, qué error da la terminal o qué detectó el equipo de seguridad.
3. **Tu Misión 🎯:** Las restricciones técnicas y objetivos que debes cumplir.
4. **Criterios de Éxito ✅:** Un script de automatización (`validate.sh`) que te dirá si tu solución es correcta para producción.

> 💡 **Regla de oro:** La solución no está en la rama principal (`main`). Para resolverlo, tendrás que investigar, usar la terminal y pensar. Si te quedas completamente atascado, puedes consultar las pistas o cambiar a la rama `solution`.

---

## 📈 La Ruta de Aprendizaje (8 Niveles Progresivos)

Completa los laboratorios en orden para experimentar una curva de aprendizaje orgánica, desde los fundamentos de desarrollo local hasta la ingeniería de infraestructura enterprise.

| Nivel | Laboratorio | Tecnologías Clave | El Dolor Real que Resuelves |
| :---: | :--- | :--- | :--- |
| 🟢 <br> **Junior** | **[01-the-missing-package](./01-the-missing-package)** | `Dockerfile`, `RUN`, `ENV` | "En mi máquina funciona". Crear un entorno empaquetado y estandarizado desde cero. |
| 🟢 <br> **Junior** | **[02-where-is-my-data](./02-where-is-my-data)** | `Named Volumes`, `Bind Mounts` | Detener la pérdida de datos de bases de datos cuando los contenedores se reinician. |
| 🟢 <br> **Junior** | **[03-it-works-on-my-machine](./03-it-works-on-my-machine)** | `Docker Compose`, `Networks` | Resolver el clásico error `Connection Refused` al conectar una API con su Base de Datos. |
| 🟡 <br> **Mid** | **[04-the-bloated-image](./04-the-bloated-image)** | `Multi-stage`, `Alpine`, Cache | Optimizar un pipeline de CI/CD reduciendo una imagen de 1.8GB a menos de 150MB. |
| 🟡 <br> **Mid** | **[05-the-secret-leak](./05-the-secret-leak)** | `.dockerignore`, Layers, Secrets | Eliminar API Keys expuestas en el historial de capas de Docker detectadas por auditoría. |
| 🟡 <br> **Mid** | **[06-the-zombie-process](./06-the-zombie-process)** | `PID 1`, `SIGTERM`, Exec vs Shell | Evitar que Docker corte transacciones activas de usuarios al hacer un *Graceful Shutdown*. |
| 🔴 <br> **Senior** | **[07-the-resource-hog](./07-the-resource-hog)** | `Limits`, `OOM Killer`, CGroups | Aislar un contenedor con fuga de memoria para que no congele el servidor completo. |
| 🔴 <br> **Senior** | **[08-the-multi-arch-nightmare](./08-the-multi-arch-nightmare)**| `Buildx`, `QEMU`, Manifests | Resolver el error `exec format error` al desplegar desde Macs M1/M2/M3 a servidores AMD64. |

---

## 🛠️ Cómo Empezar en 3 Pasos

### 1. Clona el repositorio
```bash
git clone [https://github.com/TU_USUARIO/docker-labs.git](https://github.com/TU_USUARIO/docker-labs.git)
cd docker-labs
```

### 2. Elige un desafío y lee el README interno
Entra a la carpeta del nivel que quieras desbloquear
```bash
cd 01-the-missing-package
```

### 3. Valida tu solución
Una vez que creas haber resuelto el desafío siguiendo las instrucciones del README.md interno, ejecuta el validador:
```bash
chmod +x validate.sh
./validate.sh
```

## 👥 Comunidad y Feedback

¿Resolviste un laboratorio de una manera más eficiente u optimizada? ¡Queremos verla!

* **Abre un Pull Request:** Sube tu solución en una rama propia para recibir feedback de la comunidad.
* **Dale una ⭐️ Star:** Si este contenido te sirve para tus entrevistas técnicas o para tu trabajo diario, una estrella nos ayuda a que el algoritmo recomiende el repositorio a más personas.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Siéntete libre de usarlo para estudiar, enseñar en tus comunidades o utilizarlo como base para capacitaciones internas en tu empresa.
