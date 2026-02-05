// app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('DevOps Labs!');
});

// VÉRIFIE BIEN CETTE PARTIE :
app.get('/name/:name', (req, res) => {
  res.send(`Hello, ${req.params.name}!`);
});


module.exports = app; // On exporte l'app sans lancer le serveur
