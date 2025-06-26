// backend/server.js
const express = require("express");
const mysql   = require("mysql2");
const cors    = require("cors");

const app = express();
app.use(cors());
app.use('/images', express.static(__dirname + '/Assets/Images'));

// 1) Configura aquí tus credenciales MySQL
const conexion = mysql.createConnection({
  host:     "localhost",
  user:     "root",            // tu usuario MySQL
  password: "root",   // tu contraseña MySQL
  database: "SQL_Gow_Jefes"
});

// 2) Conectar a la base de datos
conexion.connect(err => {
  if (err) {
    console.error("❌ Error de conexión:", err.message);
    process.exit(1);
  }
  console.log("✅ Conectado a MySQL: SQL_Gow_Jefes");
});

// 3) Endpoints para cada tabla

// Listar todos los jefes
app.get("/jefes", (req, res) => {
  conexion.query("SELECT * FROM Jefe", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Listar fases
app.get("/fases", (req, res) => {
  conexion.query("SELECT * FROM Fase", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Listar diálogos
app.get("/dialogos", (req, res) => {
  conexion.query("SELECT * FROM Dialogo", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// 4) Iniciar servidor
app.listen(3000, () => {
  console.log('Servidor backend corriendo en http://localhost:3000');
});