const express = require('express');
const app = express();
const port = 3000;

const hello = 'Hello from CI/CD - senna';

app.get('/', (req, res) => {
  res.send(`
    <html>
      <head>
        <meta http-equiv="refresh" content="5">
        <title>CI/CD Demo</title>
      </head>
      <body>
        <h1>${hello}</h1>
        <p>Page reloads every 5 seconds.</p>
        <p>change me</p>
      </body>
    </html>
  `);
});

app.listen(port, () => console.log(`App running on port ${port}`));
