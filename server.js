// Instala:
// npm init -y
// npm install express
// npm install cors
// npm install request
// npm install bcrypt
// npm install body-parser
// npm install mysql
// npm install axios

// Importa el módulo 'express'
const express = require("express");

// Importa el módulo
const mysql = require("mysql");
// Importa el módulo
const bodyParser = require("body-parser");

// Importa el paquete 'cors'
const cors = require("cors");

// Crea una instancia de la aplicación Express
const app = express();

// Habilita el middleware 'cors'
app.use(cors());

// Define el puerto en el que se ejecutará el servidor
const port = 2800;

app.use(cors());

app.use(bodyParser.json());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "$Yrsa6662$",
  database: "widget_cards",
});

db.connect((err) => {
  if (err) {
    console.log("Error de conexión a MySQL: " + err);
    return;
  }
  console.log("Conexión a MySQL establecida");
});

// Middleware para habilitar el parseo de JSON en las solicitudes entrantes
app.use(express.json());

// Configura ruta raíz para mostrar mensaje de bienvenida
app.get("/", (req, res) => {
  res.send("Bienvenido a mi API REST con Flutter y Node.js");
});

// Endpoints
// Endpoint GET para obtener las categorías
app.get("/categories", (req, res) => {
  const query = "SELECT * FROM categories";
  db.query(query, (err, results) => {
    if (err) {
      console.log("Error al obtener categorías: " + err);
      res.status(500).send({ message: "Error al obtener categorías" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint POST para crear un nuevo widget
app.post("/widgets", (req, res) => {
  const { name, description, image, categoryId } = req.body;
  const query =
    "INSERT INTO widgets (category_id, name, description, image) VALUES (?, ?, ?, ?)";
  db.query(query, [categoryId, name, description, image], (err, results) => {
    if (err) {
      console.log("Error al crear widget: " + err);
      res.status(500).send({ message: "Error al crear widget" });
    } else {
      res.json({ message: "Widget creado con éxito" });
    }
  });
});

// Endpoint GET para obtener todos los widgets
app.get("/widgets", (req, res) => {
  const query = "SELECT * FROM widgets";
  db.query(query, (err, results) => {
    if (err) {
      console.log("Error al obtener widgets: " + err);
      res.status(500).send({ message: "Error al obtener widgets" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint GET para obtener un widget por ID
app.get("/widgets/:id", (req, res) => {
  const id = req.params.id;
  const query = "SELECT * FROM widgets WHERE id = ?";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log("Error al obtener widget: " + err);
      res.status(500).send({ message: "Error al obtener widget" });
    } else {
      res.json(results[0]);
    }
  });
});

// Endpoint GET para obtener los widgets de una categoría
app.get("/categories/:id", (req, res) => {
  const id = req.params.id;
  const query =
    "SELECT c.*, w.* " +
    "FROM categories c " +
    "LEFT JOIN widgets w ON c.id = w.category_id " +
    "WHERE c.id = ?";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log("Error al obtener categoría y widgets: " + err);
      res.status(500).send({ message: "Error al obtener categoría y widgets" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint PUT para actualizar un widget
app.put("/widgets/:id", (req, res) => {
  const id = req.params.id;
  const { name, description, image, categoryId } = req.body;
  const query =
    "UPDATE widgets SET category_id = ?, name = ?, description = ?, image = ? WHERE id = ?";
  db.query(
    query,
    [name, description, image, categoryId, id],
    (err, results) => {
      if (err) {
        console.log("Error al actualizar widget: " + err);
        res.status(500).send({ message: "Error al actualizar widget" });
      } else {
        res.json({ message: "Widget actualizado con éxito" });
      }
    }
  );
});

// Endpoint DELETE para eliminar un widget
app.delete("/widgets/:id", (req, res) => {
  const id = req.params.id;
  const query = "DELETE FROM widgets WHERE id = ?";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log("Error al eliminar widget: " + err);
      res.status(500).send({ message: "Error al eliminar widget" });
    } else {
      res.json({ message: "Widget eliminado con éxito" });
    }
  });
});

app.listen(port, () => {
  console.log(`Servidor Node.js ejecutándose en http://localhost:${port}`);
});
