const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.send(`<h1>Dummy app</h1><p>Response from PID: ${process.pid}. Hit F5 many times!</p>`);
});
app.listen(3000, () => console.log('Listening on port 3000!'));
