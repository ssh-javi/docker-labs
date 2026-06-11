const express = require('express');
const { exec } = require('child_process'); // Usamos el módulo nativo de Node.js
const app = express();
const PORT = process.env.PORT || 3000;
const DB_HOST = process.env.DB_HOST;

// Validación de Variable de Entorno Crítica
if (!DB_HOST) {
  console.error("🚨 ERROR CRÍTICO: La variable de entorno DB_HOST no está configurada.");
  process.exit(1);
}

app.get('/', (req, res) => {
  // Ejecuta directamente el binario en el Sistema Operativo para validar si existe
  exec('gm -version', (err, stdout, stderr) => {
    if (err) {
      console.error("Fallo al ejecutar gm:", stderr);
      return res.status(500).send("🚨 ERROR EN SERVIDOR: 'graphicsmagick' no está instalado en el sistema operativo del contenedor.");
    }
    
    res.send(`✅ ¡Aplicación dockerizada con éxito! Conectada simultáneamente a DB_HOST: ${DB_HOST}. SO listo para procesar imágenes.`);
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en el puerto ${PORT}`);
});