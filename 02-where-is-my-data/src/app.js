const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// El dolor del caso real: La base de datos se guarda en esta ruta dentro del contenedor
const DB_DIR = path.join(__dirname, '../data');
const DB_PATH = path.join(DB_DIR, 'prod.db');

// Asegurar que el directorio data exista
if (!fs.existsSync(DB_DIR)){
    fs.mkdirSync(DB_DIR);
}

// Inicializar Base de Datos
const db = new sqlite3.Database(DB_PATH, (err) => {
  if (err) {
    console.error("🚨 Error abriendo la base de datos:", err.message);
    process.exit(1);
  }
  console.log('📦 Conectado a la base de datos SQLite.');
});

// Crear tabla si no existe
db.serialize(() => {
  db.run("CREATE TABLE IF NOT EXISTS metrics (id INTEGER PRIMARY KEY, views INTEGER)");
  db.run("INSERT INTO metrics (id, views) SELECT 1, 0 WHERE NOT EXISTS (SELECT 1 FROM metrics WHERE id = 1)");
});

// Ruta principal: incrementa el contador y lo muestra
app.get('/', (req, res) => {
  db.serialize(() => {
    db.run("UPDATE metrics SET views = views + 1 WHERE id = 1");
    db.get("SELECT views FROM metrics WHERE id = 1", (err, row) => {
      if (err) {
        return res.status(500).send("🚨 Error leyendo métricas");
      }
      res.send(`📊 Visitas registradas en la Base de Datos: ${row.views}. [Entorno seguro para persistencia]`);
    });
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Servidor de métricas corriendo en el puerto ${PORT}`);
});